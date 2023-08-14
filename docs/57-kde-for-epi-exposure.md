# Using kernel density estimates to quantify an exposure for Spatial Epi {#kde-extract}


As discussed in **Disease Mapping IV**, kernel density estimation can be used to map diseases (e.g. *outcomes*), but it can also be used to create continuous surfaces of an epidemiologic *exposure* or *covariate*. If you create a continuous geographically weighted surface of an exposure, you might wonder how to **extract** or join it to polygon or point data for further analysis.

>GOAL: The purpose of this appendix is to take an exposure that is defined by points (e.g. locations of power plants, health clinics, or waste sites), and to connect it to an sf data frame that has outcome (e.g. aggregated to a polygon) for further analysis.

## Prepare the exposure surface

This tutorial assumes you have data as a points object. Recall that if you retrieved data with latitude and longitude as numbers in columns, you can use `sf` tools to create an spatial points object. 


### Step 1. 

Because we are doing kernel density on points, we will use the `sparr` package which requires that our data get converted from `sf` to the older `sp`


```r
# df_sf is an sf object where each row is a point feature representing the location of an FQHC health care clinic

# This converts sf to sp
df_sp <- df_sf %>% as("Spatial")
```


### Step 2. 

Create an observation window (`owin`) that defines the outer bounds of the study area. **NOTE**: the point dataset with the exposure and the polygon representing the study area must be in the same CRS projection.

In the code below, the object `study_area` is a polygon defining the outer bounds of the included study area. This is akin to the county boundary we used in Disease Mapping IV.


```r
# Create an observation window within which the kernel density estimation will be constrained
study_owin <- maptools::as.owin.SpatialPolygons(study_area)
```


### Step 3. 

Now follow the steps from Disease Mapping IV (and the corresponding lab) to create a `ppp` object and then create a kernel density. Finally, you will convert your kernel density to a `raster` object.

:::{.rmdnote data-latex="{note}"}
**What does this kernel density represent?**

The interpretation of the resulting surface depends on what data you are analyzing. Imagine it is points representing Federally Qualified Health Centers (FQHCs).  By converting these discrete locations into a kernel density surface, you will be quantifying the average density of FQHCs per square unit area (e.g. per square km). 

Therefore, the meaning of each `raster` grid value is in fact the density in the vicinity of that particular grid cell. And the "*vicinity*" is defined by the kernel bandwidth.
:::


Here we create the `ppp` object:


```r
# Create the birth ppp object
fqhc_ppp <- ppp(x = st_coordinates(df_sp)[, 1], 
             y = st_coordinates(df_sp)[, 2],
             window = study_owin)
```


In the code below, we use a fixed bandwidth of 5km (note that `h0=5000` only corresponds to 5km if the projection unit is in square meters). **Note that you could use any of the bandwidth diagnostics, or use adaptive bandwidths in this setting, just as we did for Disease Mapping IV.** 

:::{.rmdnote data-latex="{note}"}
**Density or Intensity?**

Remember, we had some discussion in Disease Mapping IV about the distinction between "density" and "intensity". The "*intensity*" is the ratio of units (e.g. FQHCs int his case) per area (e.g. per square km). A true "*density*" is the intensity at one location relative to all of the study area. That means that the "*density*" will always sum to 1 across the study area (e.g. it is a formal statistical probability density). 

When we are creating a surface of an exposure, we usually want the units to be meaningful. Thus, the *intensity* is more relevant as it tells us how many units there are in space.  The code below sets `density=FALSE` to indicate this preference.
:::


```r
fqhc_kde <- bivariate.density(pp = fqhc_ppp, 
                              h0 = 5000, 
                              density = FALSE,
                              edge = 'diggle')
```

Now we can take the `img` object that was output from `bivariate.density()` and convert it to a `raster` format. Recall that because the `crs()` coordinate reference information gets stripped away in this process, we simply need to re-define it.


```r
fqhc_kde_raster <- raster(fqhc_kde$z)
crs(fqhc_kde_raster) <- "EPSG:5070"
```


If you plot the resulting raster, the values in the legend will be quite small, because for example, they are telling us how many FQHCs there are in every square meter!! Obviously there are not many. But if you multiply by $1,000,000$, the values will be the number of FQHCs per square kilometer. That still might be small so you could even multiply by a bigger number to make it the number of FQHCs per 10 or per 100 square km.

### Step 4. 

Everything up until now has been very similar to Disease Mapping IV. But now we want to **extract** the values. In other words we want to know what the average continuous FQHC intensity is at some given point where we measured a health outcome. If our health outcomes are aggregated to polygons (e.g. rates per census tract or county), we might choose to use the centroid of that polygon as the place to extract. If, on the other hand, the points were the actual street address of individuals, we would use those locations for extraction. In other words, the goal is to extract from the raster to specific points.


Here the target outcome unit of analysis is a polygon named `tracts-ms`. For extraction we want it to be points, and so we will use the centroid of every tract as the point of reference.


```r
df_tract_point <- st_centroid(df_tracts_ms)
```


Our goal now is to extract values from a `raster` (e.g. to merge or join the point to the raster and connect the raster cell value undelying the point). The point object needs to be class `sp` so if it is not, convert it first (e.g. `d_sp <- df_tract_point %>% as("Spatial")`). 

Now use the `extract()` function from the `raster` package:


```r
exposure_value <- raster::extract(fqhc_kde_raster, df_tract_point)
```

The code above specifies the raster first, and then the object containing the point information second. This should produce a vector with as many values as there were points in `df_tract_point`.  Now you simply join them onto your analytic dataset that has the outcome to bring the exposure and the outcome together!


```r
tracts_ms$fqhc_inensity <- exposure_value
```

