# (PART) Getting ready... {.unnumbered}

# Software installation {.unnumbered}

The information in this module follows on the pre-class video on setting up `R` and `RStudio` on your computer.

## Installing `R` on your computer {.unnumbered}

As of August 2023, the most up-to-date version of `R` is 4.3.1. The *R Project for Statistical Computing* are continually working to update and improve `R`, and as a result there are new versions 1-2 times per year.

If you already have `R` installed, you can open the console and check your current version by typing (or copy/pasting) this: `R.Version()$version.string`

If you do not have `R`, or have an older version than that listed above, you can install or update `R` by going to the `R` repository: <https://www.r-project.org/>. Note that there are many 'mirrors' or servers where the software is stored. Generally it is wise to select one that is geographically close to you, although any should work in theory. One mirror that is relatively close to Atlanta is here: <http://archive.linux.duke.edu/cran/>

### `R` installation notes for Mac OS users

If you click on *Mac OS* from the `cran` webpage, you will see several different options for installation. Specifically, there is a versions for Mac with Intel processors, and a different version for Mac OS with Apple Silicon (e.g. M1 chip). 

::: {.rmdtip data-latex="{tip}"}
**How do I know what chip is in my Mac?**

If you do not know whether you have Intel or Apple processors, click on the Apple icon and choose "*About this Mac*". In the resulting window look for either of these:

* `Chip Apple M1 Pro` means that you have Apple Silicon. You should download that has `arm64` in the name. The description will say it is for native Apple silicon.
* `Processor xxx` where *xxx* is an Intel chip.  This means you have the older Intel chip, and you should download the `R` installer that is for Intel-based Macs.
:::

#### Installing `Xcode` (Mac only)

There are some packages that require compiling done outside of `R`. You may need the utility package `Xcode` to do this.  This is not an `R` package, but instead an app available from the Apple Store. Open the Apple Store, search for `Xcode` and install.

::: {.rmdcaution data-latex="{caution}"}
`Xcode` is BIG! If you don't have much storage on your hard drive this might be a problem. You have two options:

1. Don't install `Xcode` and see what happens. Depending on other configurations on your machine, it might not be necessary. You will know there is a problem if some packages do not install.
2. Try install a "*slimmer*" version of `Xcode` by following [these instructions](https://mac.install.guide/commandlinetools/index.html).
:::

### `R` installation for Windows OS users

If you are using a computer running Microsoft Windows OS, you will click on the Windows option on the CRAN website.  Choose the option that reads `base` and click on the most recent downloader.

#### Installing `Rtools43` (Windows Only) 

While **most** of your work with `R` packages (e.g. installing new ones) can be done with the base-R tools, there are instances where an installation of a new package requires a more complex '*unpacking*' of the code or installation from github. Windows machine  may require additional *tools* to do this work. Luckily there is a package for that! It is called `Rtools43` (assuming you have already downloaded and installed R 4.2), and you should install that **before** you install the packages below.

Note that `Rtools43` is not a package within `R`, but instead is a Windows utility installed outside of `R` itself.

If you are running Windows, navigate back to the [CRAN](https://cran.r-project.org) website, choose Windows, and then -- instead of clicking on `base` -- click on `Rtools` and follow the instructions. Specifically, be sure your version of `Rtool` aligns with your version of `R`. For example, if you have `R` 4.3.1, then choose `Rtools43`. 


## Installing *RStudio* on your computer {.unnumbered}

R-Studio is one of several *integrated development environments* (IDE) for working in `R`. That means it is a *wrapper* around the core `R` functionality that makes coding and project work in `R` much easier than it would be without. We *develop* projects or analyses using `R` within an IDE such as R-Studio. Using R-Studio lets us have robust code-editing and debugging, code syntax highlighting (e.g. coloring different words according to their use, and identifying possible errors), and some assistance with file management, working in larger projects, and outputting results.

The current version of RStudio 2023.06.1+524. If you do not have RStudio or have an up-to-date version, please install or update it.

**TO INSTALL**: go to <https://posit.co/download/rstudio-desktop/>

**TO UPDATE**: Open RStudio and go to Help Menu and choose 'Check for Updates'

::: {.rmdtip data-latex="{tip}"}
[R-Studio Cheat sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/rstudio-ide.pdf) provides a quick reference guide for many of the ways that R-Studio makes your work with `R` easier. 

In fact, there are "*cheat sheets*" for lots of packages and utilities in `R`; browse some of them [here](https://www.rstudio.com/resources/cheatsheets/).
:::


# Installing packages for this course {.unnumbered}

While base `R` has a great deal of essential functionality, most of the power of `R` comes from the rapidly growing list of user-created and contributed '*packages*'. A package is simply a bundle of functions and tools, sometimes also including example datasets, basic documentation, and even tutorial 'vignettes'. You can see all the official `R` packages by going here: <https://cran.r-project.org/web/packages/>.

The most common way to install package in `R` is with the `install.packages()` command. For instance to install the package `ggplot2` you do this:

`install.packages("ggplot2")`

Remember that you only need to install a package once (although you may have to update packages occasionally -- see the green Update button in the Packages tab in R Studio). When you want to actually *use* a package (for example `ggplot2`) you call it like this:

`library(ggplot2)`

If your call to `library()` is working, nothing visible happens. However if you see errors, they might be because your package is out of date (and thus needs to be updated/reinstalled), or because some important *dependencies* are missing. Dependencies are other packages on which this package depends. Typically these are installed by default, but sometimes something is missing. If so, simply install the missing package and then try calling `library(ggplot2)` again.

::: {.rmdnote data-latex="{note}"}
Notice that for the function `install.packages('yourPackage')` you **must use quotes** around the package name. In contrast for the function `library(yourPackage)` you **do not use quotes**.
:::

::: {.rmdcaution data-latex="{caution}"}
As you submit each installation request, note the output in your R console. If you get a warning that says installation was not possible because you are missing a package *'yourPackage'*, that suggests you are missing a dependency (e.g. something the main package needs to work correctly). Try installing the package mentioned in the error. If you have trouble, reach out to the TA's!
:::


## Installing packages used for general data science {.unnumbered}

For the rest of this page, copy and paste the provided code in order to install packages necessary for this course. Notice if you hover to the right of a code-chunk in the html version of the eBook, you will see a *copy* icon for quick copying and pasting.

::: {.rmdtip data-latex="{tip}"}
Although you are copying and pasting the code, take a moment to **look** at the output. Did you get any error messages that a package did not install? Sometimes you see a **warning** message announcing something, but perhaps the package installed ok. If there is an **error** message, the package probably did not install. 

To see if a package was installed, try loading it by typing `library(yourPackage)`. If nothing happens (no errors) then all is good!
:::

These packages will support some of our general work in `R`:

-   `rmarkdown` allows the creation of mixed output documents that combine code, documentation and results in a single, readable format.
-   The packages `tinytex` and `knitr` are necessary for creating the `R` documents including PDF output that will be required for submitting assignments.
-   We will use many data manipulation tools from the `tidyverse`. You can learn more about the `tidyverse` here: <https://tidyverse.tidyverse.org/>, and you can see applications of `tidyverse` packages in the [R for Epidemiologists Handbook](https://epirhandbook.com/index.html). The `tidyverse` is actually a collection of data science tools including the visualization/plotting package `ggplot2` and the data manipulation package `dplyr`. For that reason, when you `install.packages('tidyverse')` below, you are actually installing *multiple* packages!
-   The packages `here` and `pacman` are utilities to help simplify file pathnames and package loading behavior.


```r
install.packages('tidyverse')   
install.packages(c('pacman', 'here'))
install.packages(c('tinytex', 'rmarkdown', 'knitr')) 
tinytex::install_tinytex()  
# this function installs the tinytex LaTex on your
#  computer which is necessary for rendering (creating) PDF's 
```

## Installing packages use for geographic data {.unnumbered}

There are many ways to get the data we want for spatial epidemiology into `R`. Because we often (but don't always) use census geographies as aggregating units, and census populations as denominators, the following packages will be useful. They are designed to quickly extract both geographic boundary files (e.g. *'shapefiles'*) as well as attribute data from the US Census website via an API. 


```r
install.packages(c('tidycensus','tigris')) 

help('census_api_key','tidycensus')
```

:::{.rmdtip data-latex="{tip}"}
**NOTE**: To be able to interact with the Census bureau API through `R`, you will need a personalized "**API key**".  When you enter the second line of code above (e.g. the `help()` function), you will see information on how to:

1. Request a key from the Census bureau
2. Enter your cutoms key into your machine so that it is available when needed.

We will not need the Census API key for a couple of weeks, but it is good to start now and ask for help if you have trouble!
:::

## Installing packages used for spatial data manipulation & visualization {.unnumbered}

This section installs a set of tools specific to our goals of importing, exporting, manipulating, visualizing, and analyzing spatial data.

-   The first line of packages have functions for defining, importing, exporting, and manipulating spatial data.
-   The second line has some tools we will use for visualizing spatial data (e.g. making maps!).


```r
install.packages(c('sp', 'sf', 'raster', 'RColorBrewer', 'OpenStreetMap'))  
install.packages(c('tmap', 'tmaptools')) 
```

::: {.rmdcaution data-latex="{caution}"}
**BEWARE**

There are many large shifts currently underway in `R` architecture for spatial analysis. As we will learn, for years we have been shifting away from an older data class defined in the package `sp` to a newer one called `sf`. 

In addition to that shift, at the end of 2023 several packages that helped link older R functions to standard GIS libraries outside of `R` [are being retired](https://r-spatial.org/r/2022/04/12/evolution.html). These include `maptools`, `rgeos` and `rgdal`.  Newer packages do not rely on them, but some older packages have not been updated. Note that `sp`, `rgeos`, `rgdal`, and `maptools` are all included in the list above. Each year we uncover new opportunities and new bugs related to unanticipated package dependencies caused by some packages aging out. We'll see what bumps we run into this year!
:::


## Installing packages used for spatial analysis {.unnumbered}

Finally these are packages specifically for spatial analysis tasks we will carry out.


```r
install.packages(c('spdep', 'CARBayes', 'sparr', 'spatialreg',  'DCluster', 'SpatialEpi', 'smerc'))
install.packages(c('GWmodel', 'spgwr') )
```


