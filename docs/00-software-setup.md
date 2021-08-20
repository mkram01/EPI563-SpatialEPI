# (PART) Getting ready... {-}



# Software installation {-}

The information in this module follows on the pre-class video on setting up `R` and `RStudio` on your computer. 

## Installing `R` on your computer {-}

As of August 2021, the most up-to-date version of `R` is 4.1.1. The *R Project for Statistical Computing* are continually working to update and improve `R`, and as a result there are new versions 1-2 times per year. 


If you already have `R` installed, you can open the console and check your current version by doing this: `R.Version()$version.string`

If you do not have `R` or have an older version than that listed above, you can install `R` by going to the `R` repository: https://www.r-project.org/. Note that there are many 'mirrors' or servers where the software is stored. Generally it is wise to select one that is geographically close to you, although any should work in theory. One mirror that is relatively close to Atlanta is here: http://archive.linux.duke.edu/cran/  

## Installing RStudio on your computer {-}

The current version of RStudio  1.4.1717. If you do not have RStudio or have a version older than 1.2 please install/update.

**TO INSTALL**: go to https://www.rstudio.com/products/rstudio/download/   

**TO UPDATE**: Open RStudio and go to Help Menu and choose 'Check for Updates'

# Installing packages for this course {-}

While base `R` has a great deal of essential functionality, most of the power of `R` comes from the rapidly growing list of user-created and contributed 'packages'. A package is simply a bundle of functions and tools, sometimes also including example datasets, basic documentation, and even tutorial 'vignettes'.  You can see all the official `R` packages by going here: https://cran.r-project.org/web/packages/. 

The most common way to install package in `R` is with the `install.packages()` command.  For instance to install the package `ggplot2` you do this:

`install.packages("ggplot2")`

Remember that you only need to install a package once (although you may have to update packages occasionally -- see the green Update button in the Packages tab in R Studio). When you want to actually *use* a package (for example `ggplot2`) you call it like this:

`library(ggplot2)`


If your call to `library()` is working, nothing visible happens. However if you see errors, they might be because your package is out of date (and thus needs to be updated/reinstalled), or because some important *dependencies* are missing. Dependencies are other packages on which this package depends. Typically these are installed by default, but sometimes something is missing. If so, simply install the missing package and then try calling `library(ggplot2)` again. 

:::{.rmdnote data-latex="{note}"}
Notice that for the function `install.packages('yourPackage')` you **must use quotes** around the package name. In contrast for the function `library(youPackage)` you **do not use quotes**. 
:::



:::{.rmdcaution data-latex="{caution}"}

As you submit each installation request, note the output in your R console. If you get a warning that says installation was not possible because you are missing a package *'namespace'*, that suggests you are missing a dependency (e.g. something the main package needs to work correctly). Try installing the package mentioned in the error. If you have trouble, reach out to the TA's!

:::


## Installing `Rtools40` (Windows Only) {-}

While **most** packages can be installed as mentioned above (e.g. using `install.packages()`), there are instances where an installation requires a more complex '*unpacking*' of the course code or installation from github. Mac OS and Unix have the capability of doing this, but on a Windows machine you may require additional *tools*.  Luckily there is a package for that! It is called `Rtools40`, and you should install that **before** you install the packages below.


If you are running Windows, navigate to this website: https://cran.r-project.org/bin/windows/Rtools/ and follow the instructions. 

## Installing packages used for general data science {-}

For the rest of this page, copy and paste the provided code in order to install packages necessary for this course. Notice if you hover to the right of a code-chunk in the html version of the eBook, you will see a *copy* icon for quick copying and pasting.

:::{.rmdtip data-latex="{tip}"}

Although you are copying and pasting the code, take a moment to look at the output. Did you get any error messages that a package did not install? If so, re-check the code or try again. 

:::

These packages will support some of our general work in `R`:

* `rmarkdown` allows the creation of mixed output documents that combine code, documentation and results in a single, readable format. 
* The packages `tinytex` and `knitr` are necessary for creating the `R` documents including PDF output that will be required for submitting assignments. 
* We will use many data manipulation tools from the `tidyverse`.  You can learn more about the `tidyverse` here: https://tidyverse.tidyverse.org/, and you can see applications of `tidyverse` packages in the [R for Epidemiologists Handbook](https://epirhandbook.com/index.html). The `tidyverse` is actually a collection of data science tools including the visualization/plotting package `ggplot2` and the data manipulation package `dplyr`. For that reason, when you `install.packages('tidyverse')` below, you are actually installing *multiple* packages!  
* The packages `here` and `pacman` are utilities to help simplify file pathnames and package loading behavior.



```r
install.packages('tidyverse')   
install.packages(c('pacman', 'here'))
install.packages(c('tinytex', 'rmarkdown', 'knitr')) 
tinytex::install_tinytex()  
# this function installs the tinytex LaTex on your
#  computer which is necessary for rendering (creating) PDF's 
```


## Installing packages use for geographic data {-}

There are many ways to get the data we want for spatial epidemiology into `R`. Because we often (but don't always) use census geographies as aggregating units, and census populations as denominators, the following packages will be useful. They are designed to quickly extract both geographic boundary files (e.g. *'shapefiles'*) as well as attribute data from the US Census website via an API.  **NOTE**: For these to work you have to request a free Census API key.  Notice the `help()` function below to get instructions on how to do this.


```r
install.packages(c('tidycensus','tigris')) 

help('census_api_key','tidycensus')
```



## Installing packages used for spatial data manipulation & visualization {-}


This section installs a set of tools specific to our goals of importing, exporting, manipulating, visualizing, and analyzing spatial data. 

* The first line of packages have functions for defining, importing, exporting, and manipulating spatial data. 
* The second line has some tools we will use for visualizing spatial data (e.g. making maps!). 


```r
install.packages(c('sp', 'sf', 'rgdal', 'raster', 'RColorBrewer', 'rgeos', 'maptools', 'OpenStreetMap'))  
install.packages(c('tmap', 'tmaptools', 'ggmap', 'shinyjs', 'shiny', 'micromap')) 
```



## Installing packages used for spatial analysis {-}

Finally these are packages specifically to spatial analysis tasks we'll carry out.


```r
install.packages(c('spdep', 'CARBayes', 'sparr', 'spatialreg',  'DCluster', 'SpatialEpi'))
install.packages(c('GWmodel', 'spgwr') )
```


