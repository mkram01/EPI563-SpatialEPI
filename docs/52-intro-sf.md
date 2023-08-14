# Tips for working with `sf` data class {#sf-overview}

* [Simple Features (`sf`) cheat sheet](https://github.com/rstudio/cheatsheets/blob/main/sf.pdf)

## `st_set_geom()`

One unique characteristic of `sf` class data in that the special column containing the *geometry* information (often labeled `geom`) is different from other variables. Specifically it is **sticky**. *Stickiness* in a variable means that as you manipulate an `sf` data object, the `geom` column almost always *sticks* to the rest of the data even when you try to remove it.

Imagine what would happen in a regular `data.frame` if you typed this code into the console `mvc[1, 1:2]`.  Typically that kind of numerical indexing would cause `R` to return *row 1* for *columns 1 to 2*. However, when we try this in `R` with an `sf` object this is what happens:


```r
library(sf)
library(tidyverse)

mvc <- st_read('../SpatialEpi-2021/DATA/GA_MVC/ga_mvc.gpkg')
```

```
## Reading layer `ga_mvc' from data source 
##   `/Users/MKRAM02/Library/CloudStorage/OneDrive-EmoryUniversity/EPI563-Spatial Epi/SpatialEpi-2021/DATA/GA_MVC/ga_mvc.gpkg' 
##   using driver `GPKG'
## Simple feature collection with 159 features and 17 fields
## Geometry type: MULTIPOLYGON
## Dimension:     XY
## Bounding box:  xmin: -85.60516 ymin: 30.35785 xmax: -80.83973 ymax: 35.00066
## Geodetic CRS:  WGS 84
```

```r
mvc[1, 1:2]
```

```
## Simple feature collection with 1 feature and 2 fields
## Geometry type: MULTIPOLYGON
## Dimension:     XY
## Bounding box:  xmin: -82.55071 ymin: 31.46925 xmax: -82.04858 ymax: 31.96618
## Geodetic CRS:  WGS 84
##   GEOID                    NAME                           geom
## 1 13001 Appling County, Georgia MULTIPOLYGON (((-82.55069 3...
```


Notice that we did get the first row, and the first and second column but we *also got the `geom` column* even though we didn't request it.  This *stickiness* is generally desirable, because it is so important to keep geographic/geometry data connected to attribute data. However there are times when we want to drop that information. There are several ways to do so, but here is the most explicit way:


```r
mvc2 <- st_set_geometry(mvc, NULL)
```

This literally erases or sets to `NULL` the geometry column. It cannot be retrieved without going back to the original data.


```r
# look at the class of the original and the modified object
class(mvc)
```

```
## [1] "sf"         "data.frame"
```

```r
class(mvc2)
```

```
## [1] "data.frame"
```

```r
# look at the first row and 1-2nd column after NULLing geom
mvc2[1, 1:2]
```

```
##   GEOID                    NAME
## 1 13001 Appling County, Georgia
```


## `st_as_sf()` {#st-as-sf}

There are also times when, inextricably, your data set that **seems** like an `sf` object, but you get an error message that the data is not the right type because it does not have geometry information or not being `sf`.  

This can happen when a data manipulation step strip away some `sf` data class even though the `geom` column still exists. When this happens you can *reinstate* the class status by calling `st_as_sf()`. Essentially this is a formal way for declaring an object to be `sf` by explicitly defining the *spatial* component.


## `st_crs()` 

Spatial coordinate reference systems (CRS) and projections are critically important for managing and visualizing spatial data. The *spatial information* in the `sf` object is determined by the values of the coordinates contained in the `geom` or `geometry` column, but those values assume a known and defined *coordinate system*. For instance unprojected data is typically measured as degrees of latitude or longitude, but even these units can vary depending on which geodetic system and datum are used.  

So how do you know what you're working with? The function `st_crs()` return whatever information is stored with the object about the CRS/projection.


```r
st_crs(mvc)
```

```
## Coordinate Reference System:
##   User input: WGS 84 
##   wkt:
## GEOGCRS["WGS 84",
##     ENSEMBLE["World Geodetic System 1984 ensemble",
##         MEMBER["World Geodetic System 1984 (Transit)"],
##         MEMBER["World Geodetic System 1984 (G730)"],
##         MEMBER["World Geodetic System 1984 (G873)"],
##         MEMBER["World Geodetic System 1984 (G1150)"],
##         MEMBER["World Geodetic System 1984 (G1674)"],
##         MEMBER["World Geodetic System 1984 (G1762)"],
##         MEMBER["World Geodetic System 1984 (G2139)"],
##         ELLIPSOID["WGS 84",6378137,298.257223563,
##             LENGTHUNIT["metre",1]],
##         ENSEMBLEACCURACY[2.0]],
##     PRIMEM["Greenwich",0,
##         ANGLEUNIT["degree",0.0174532925199433]],
##     CS[ellipsoidal,2],
##         AXIS["geodetic latitude (Lat)",north,
##             ORDER[1],
##             ANGLEUNIT["degree",0.0174532925199433]],
##         AXIS["geodetic longitude (Lon)",east,
##             ORDER[2],
##             ANGLEUNIT["degree",0.0174532925199433]],
##     USAGE[
##         SCOPE["Horizontal component of 3D system."],
##         AREA["World."],
##         BBOX[-90,-180,90,180]],
##     ID["EPSG",4326]]
```

In the most recent version of `sf`, what is returned by `st_crs()` is two pieces of information:

1. The first piece is labeled *User input:* and in this case reads `WGS 84`, suggesting this object is based on this datum and CRS.
2. The second piece of information is labeled `wkt:` which stands for *Well-Known Text*. This is a standardized and structured format for describing and annotating coordinate/projection information. There is more detail than you probably want on the structure of [WKT for CRS here](http://docs.opengeospatial.org/is/12-063r5/12-063r5.html#43). In short it includes these features:
  a. The base datum and underlying ellipsoid, which in this case is WGS 84
  b. Specific parameters including the prime meridian, the coordinate system
  c. The ID, which often is represented as the [EPSG code](https://epsg.io/).
  
The fact that the object `mvc` has EPSG code of 4326 suggests it is a simple, unprojected, WGS-84 CRS (e.g. see [here](https://epsg.io/?q=4326)).

Occasionally the *WKT* is more complex, perhaps because there have been previous transformations which were stored in the metadata encoded in *WKT*.  In that case, closer examination of the *WKT* may be needed to identify the CRS/projection. For instance is there a *TARGETCRS* mentioned? That may be the current CRS.

Another trick that may get you most quickly to the data you specifically need (which is usually to know the EPSG code of the data, if one has been applied) is this code:


```r
# Extract only the CRS ID code from the object
st_crs(mvc)$srid
```

```
## [1] "EPSG:4326"
```


