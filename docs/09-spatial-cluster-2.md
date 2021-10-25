# Spatial Structure and Clustering II: Spatial scan statistics


## Getting Ready

### Learning objectives


```{=latex}
 
  \providecommand{\huxb}[2]{\arrayrulecolor[RGB]{#1}\global\arrayrulewidth=#2pt}
  \providecommand{\huxvb}[2]{\color[RGB]{#1}\vrule width #2pt}
  \providecommand{\huxtpad}[1]{\rule{0pt}{#1}}
  \providecommand{\huxbpad}[1]{\rule[-#1]{0pt}{#1}}

\begin{table}[ht]
\begin{centerbox}
\begin{threeparttable}
\captionsetup{justification=centering,singlelinecheck=off}
\caption{(\#tab:learning-ob) Learning objectives by weekly module}
 \setlength{\tabcolsep}{0pt}
\begin{tabularx}{1\textwidth}{p{1\textwidth}}


\hhline{>{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{1\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{204, 204, 204}\hspace{6pt}\parbox[b]{1\textwidth-6pt-6pt}{\huxtpad{2pt + 1em}\raggedright \textbf{After this module you should be able to…}\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{1\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{242, 242, 242}\hspace{6pt}\parbox[b]{1\textwidth-6pt-6pt}{\huxtpad{2pt + 1em}\raggedright Evaluate statistical estimation of spatial clustering in population health to generate epidemiologic hypotheses\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{1\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{230, 230, 230}\hspace{6pt}\parbox[b]{1\textwidth-6pt-6pt}{\huxtpad{2pt + 1em}\raggedright Apply spatial scan statistics to epidemiologic data and interpret results\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}
\end{tabularx}
\end{threeparttable}\par\end{centerbox}

\end{table}
 
```


### Additional Resources

* [Vignette for `scanstatistics` package in R](https://github.com/BenjaK/scanstatistics)
* [SatScan website](https://www.satscan.org/), supported by National Cancer Institute

### Important Vocabulary


```{=latex}
 
  \providecommand{\huxb}[2]{\arrayrulecolor[RGB]{#1}\global\arrayrulewidth=#2pt}
  \providecommand{\huxvb}[2]{\color[RGB]{#1}\vrule width #2pt}
  \providecommand{\huxtpad}[1]{\rule{0pt}{#1}}
  \providecommand{\huxbpad}[1]{\rule[-#1]{0pt}{#1}}

\begin{table}[ht]
\begin{centerbox}
\begin{threeparttable}
\captionsetup{justification=centering,singlelinecheck=off}
\caption{(\#tab:unnamed-chunk-2) Vocabulary for Week 9}
 \setlength{\tabcolsep}{0pt}
\begin{tabularx}{0.9\textwidth}{p{0.45\textwidth} p{0.45\textwidth}}


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{84, 153, 199}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{\textcolor[RGB]{255, 255, 255}{Term}}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{84, 153, 199}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright \textbf{\textcolor[RGB]{255, 255, 255}{Definition}}\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{212, 230, 241}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{1st order process}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{212, 230, 241}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright Statistical measures where units taken one at a time. Spatial heterogeneity is about how the mean intensity varies for each unit, and is therefore primarily about first order process\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{169, 204, 227}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{2nd order process}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{169, 204, 227}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright Statistical measures where units considered at least two at a time. Spatial dependence is about correlation or relatedness between units and is therefore about 2nd order processes\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{212, 230, 241}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{Global vs Local spatial analysis}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{212, 230, 241}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright Global analysis evaluates a pattern or trends that characterizes the entire study region; in contrast local analysis characterizes patterns that are unique to each sub-region of the study area\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{169, 204, 227}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{Spatial dependence}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{169, 204, 227}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright When attribute values or statistical parameters are, on avreage, more similar for nearby places than they are for distant places. Spatial dependence is evaluated by looking at pairs or sets of places.\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{212, 230, 241}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{Spatial heterogeneity}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{212, 230, 241}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright Attributes or statistical parameters are varied (e.g. not homogenous) across sub-areas in a broader region. In Disease mapping we typically are evaluating whether (and how much) disease intensity (risk, rate, prevalence) varies across places.\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{169, 204, 227}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{Spatial scan statistic}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{169, 204, 227}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright A test for extreme or unusual event intensity inside versus outside a varying regional window, in an effort to detect local clusters of disease\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}
\end{tabularx}
\end{threeparttable}\par\end{centerbox}

\end{table}
 
```


## Spatial Thinking in Epidemiology: Conceptual tools for thinking about 'clusters'

Last week we formalized two essential questions in spatial epidemiology:

1. Is there **spatial heterogeneity** or variation in the intensity of disease within a study area?
2. Is there **spatial dependency** or autocorrelation in the disease rate among local sub-regions of the overall study area?


These two questions recalled a contrast that we have made in prior weeks between *global* patterns and *local* patterns:

1. **Global**: characterization of patterns of intensity or autocorrelation for an entire study region. 
2. **Local**: characterization of specific deviations from expectation in sub-regions of the study area. 

To combine these two constructs, describing **global heterogeneity** is to ask, "*are there any areas that are meaningfully different from the constant risk null hypothesis?*" Describing **global autocorrelation** is to ask, "*on average do values in each region correlate with values in their neighboring regions?*"

And by extension, describing **local heterogeneity** is to detect the existence of a local extreme (e.g. intensity that is significantly and/or meaningfully higher or lower than expected under assumptions of constant risk). Similarly, describing **local autocorrelation** is to detect specific sub-regions that are unusually similar to (or perhaps unusually unlike) their neighbors.


### The clustering conundrum

The preceding summary of points covered over the past weeks gives us a starting point for analytically and statistically *detecting* and *describing* spatial clustering of disease. As discussed last week, this is of interest statistically (e.g. to rule out bias and error as sources of unusual patterning), epidemiologically (e.g. to characterize the occurrence of disease as part of surveillance or etiologic research), and from a policy and public health perspective (e.g. to inform public health prevention, regulation, or policy).  

While the constructs above help with the *detection* of unusual patterns, *explaining* them (e.g. in terms of causes, processes, and exposures) is often the ultimate goal. So what exactly is '*disease clustering*' and what does statistical evidence of global or local heterogeneity or dependency tell us about the generation or causes of clustering? 

It turns out this notion of explaining '*clustering*' is a tricky one both conceptually and analytically. 

**Conceptually**, we might like to distinguish between at least two kinds of processes:

1. Factors about the context or the population itself that results in greater or smaller intensity of disease in one place versus another. For example environmental toxicants such as air pollution or arsenic in the water could plausibly affect all who live in the area, resulting in a higher disease prevalence. UV-exposure varies by latitude, and this partly explains differences in skin cancer and Vitamin D deficiency. *Spatial variation caused by changes in the underlying property of places or populations are called* **1st order effects**.
2. Processes of spread, contagion, or diffusion suggest that some interaction between people (or between the institutional influence within places) result in a spread or transmission of disease. This is most intuitive for infectious disease, where transmission is a function of proximity.  But contagion and diffusion can occur in non-infectious outcomes as well, as seen with behavioral contagion and social norms shared within networks (e.g. acceptability of smoking, expectations about body size, etc). *Spatial variation or clustering caused by the interaction between individuals or entities are called* **2nd order effects**.


![(\#fig:unnamed-chunk-3)Image source: https://mgimond.github.io/Spatial/index.html](images/1st_2nd_order_property.png) 


The figure above illustrates 1st and 2nd order spatial effects in the context of ecology. The core concept relevant to epidemiology is that 1st order effects assume patterns are from differences in the *mean intensity*, whereas 2nd order effects focuses on differences in *covariation* or *correlation*.  

You might recognize, therefore, a parallel with our two essential questions of heterogeneity of the mean intensity versus autocorrelation among local sets of regions. You may also note that our analytic strategies have been framed in the context of these distinctions: tests for spatial heterogeneity built on the null hypothesis of constant risk sound like they are evaluating 1st order effects; in contrast tests for spatial autocorrelation comparing pairs of regions sound like they are evaluating 2nd order effects.


**Analytically** it would be great to have a test that distinguishes clearly between these competing explanations for how the unusual spatial pattern was generated or produced. But this is the second tricky issue. Both 1st and 2nd order processes can produce patterns of disease that could be detected with either tests for heterogeneity or tests for spatial autocorrelation. Said another way, our tests cannot analytically distinguish **why** an unusual pattern was caused; instead they are complementary ways to describe the **magnitude** and **location** of patterns. 

At the end of the day, spatial epidemiologists must design the studies and select the tools that best serve the needs of the question at hand. If detecting and describing clustering is the primary goals (e.g. for surveillance or description), then the combination of disease mapping and cluster detection may be the beginning and the end of the work. 

However, if characterizing the underlying causes and processes are important -- either for scientific understanding or effective public health action -- then the tools are just steps on the way. Disease mapping and cluster detection may generate hypotheses, lead to additional investigation, or be used to triangulate with other data to build a fuller picture.



## Spatial Scan Statistics

The family of *scan statistics* are commonly used for identifying localized spatial clusters of disease. Some of the specific examples of statistical approaches in this broad category have been attributed to *Besag & Newell*, *Openshaw* (the *Geographical Analysis Machine*), and to *Kulldorff & Nagarwalla*.  

This discussion focuses primarily on implementation of the latter set of tests. Many users take advantage of stand-alone free software called *SaTScan* to carry out these tests. The software can be downloaded here: https://www.satscan.org/download_satscan.html. This site also has a rich set of tutorial and technical documentation resources.

In part because of the widespread use of the *SaTScan* software, there has been less development of scan statistics in `R`. For that reason, some of the functions used in the examples below do not have as many *helper* functions or wrappers as we've had in some previous examples. As a result, this tutorial is a mix of spatial analysis and hacking our way through output with `R` coding. 

### Packages & Data

We will use several familiar, and one new package in this lab: `scanstatistics`.

:::{.rmdcaution data-latex="{caution}"}

**As of 2021 `scanstatistics` is not updated for R4.0**

Unfortunately the developer of this package moved onto other things and has not continued to maintain this package as versions of R have evolved. Thus the package is no longer hosted on *CRAN repositories*. In lab we will install an older version directly from *Github*. The older version seems to perform well, at least in these examples.

:::


```r
library(sf)        # manage sf class data 
library(dplyr)     # facilitates data processing
library(tmap)      # for thematic mapping
library(SpatialEpi) # Functions including the kulldorff()
#install.packages('scanstatistics') # install if not already done
library(scanstatistics) # spatio-temporal scan
library(ggplot2)  # Create a ggplot visualization
```





In terms of data, we are using a new dataset for this example. Specifically we have the counts of reported sexually transmitted infections (STIs; includes chlamydia, gonorrhea, chancroid, and syphilis) for each county in Georgia, along with the population count at risk. These data exist in a *cross-sectional* version, pooling counts for 2018, with n=159 rows for the 159 counties. 

However, there is also a *spatio-temporal* dataset of STIs for each county for each year from 2010-2018. These data are in *long format* which means that there is a row for every year and county (e.g. repeated rows within counties).





```r
# cross-sectional STI data
sti <- st_read('ga-std-2017-18.gpkg')

# calculated overall global risk of STI
r <- sum(sti$STD) / sum(sti$POP)

# use the global risk and the population of each county to calculate local expected 
sti$expected <- r*sti$POP

# longitudinal STI data
sti_long <- st_read('ga-std-long.gpkg')
```


Because these are new data, here is a simple map of the STI rate for the 2017-18 years pooled.


```r
sti %>%
  mutate(rate = STD / POP * 1000) %>%
  tm_shape() + 
  tm_fill('rate',
          style = 'quantile',
          palette = 'YlGnBu',
          title = 'STI per 1000') +
  tm_layout(main.title = 'STI per capita, Georgia, 2018',
            inner.margins = c(0.1, 0.02, 0.02, 0.08)) +
  tm_credits('Source: GA-OASIS, https://oasis.state.ga.us/') +
  tm_borders()
```

![](09-spatial-cluster-2_files/figure-latex/unnamed-chunk-7-1.pdf)<!-- --> 



### Overview of *Kulldorff & Nagarwalla* scan statistic

Scan statistics get their name because they approach detection of clusters in a flexible manner by '*scanning*' the entire study region with many different possible windows of observation.  The basic analytic strategy of the Kulldorff scan statistic follows several steps:

1. Define a single location (e.g. centroid of a polygon, or at regularly-placed grid points across the region)
2. At each location, further define the radius of a *window* defining the area *local to* the location. The radius typically is varied iteratively from zero (e.g. only the single location included), to something large (perhaps as large as is necessary to include 50% of the population). Scan statistics typically use a *circular* window, although *ellipses* and other shapes are possible.
3. For each location $x$, and for each of many possible window-radii (e.g. the window surrounding each reference point), aggregate the count of events and the population at risk (or alternatively the *expected count of events* under a constant risk hypothesis) **inside** (e.g. $p$) and **outside** (e.g. $q$) the window.
4. Calculate a *likelihood ratio test* for whether the rates/risks are equal ($H_0: p=q$), or the risk inside the window is larger ($H_1: p>q$). 
5. Repeat the above four steps for *every iteration of window-radius* and *every location* in the study region. 

The first thing that should be apparent, is that the null assumption being tested is the *constant risk* or *spatial homogeneity of risk* assumption, rather than the *spatial independence* assumption. This is clear from the fact that we are not assessing correlation between values, but the magnitude of the risk/rate inside versus outside the region. This illustrates that testing for spatial autocorrelation (e.g. with Moran's I or LISA) is not the only way to conceive of clusters.

It is also apparent that what results is a large number of test statistics, which raises concern for multiple comparisons and Type I error. Kulldorff's approach, however, suggests that we are not interested in the set of *statistically significant* test statistics (of which there could be many by chance alone given the number of tests conducted), but instead that we are interested in identifying a single (or perhaps a few) *most-likely cluster(s)*.  

By *a priori* restricting interest to a most-likely cluster, we eliminate concern for multiple comparison. It is possible that the most-likely cluster is in fact statistically significant, or that it is not (e.g. if there is spatial homogeneity, the *most likely* is still not that interesting!). 

Because all-possible locations $x$ and window-radius were tested, we can also choose to look at secondary clusters, recognizing that the further down the list of *unusual* test statistics, the greater the risk of Type I error.

The strengths of the Kulldorff scan statistic are its flexibility with respect to defining '*local*', and the straightforward evaluation of whether there is more risk within a window versus outside. The potential limitations are that some clusters (e.g. along highways producing a linear pattern) may not be readily detected by circular or elliptical search windows.

### Spatio-temporal scan statistics

While the above strategy described a purely *spatial* scan, it is relatively straightforward to extend the strategy to include *spatio-temporal* scans.  Obviously for this to work, data must be available for multiple time-periods within every region. 

For spatio-temporal scans, we simply add another dimension of the defined *window*. Each window will be centered at a given location (e.g. the centroid of a county), have a given radius, *and include a varying-number of time-periods*. For instance, two iterations of the test could be centered at the same spatial location, with the same window-size, but one might include a single time-period, and another includes two time-periods. 

A comparison of the resulting test statistics tells us whether the count of events *inside the spatio-temporal window* (or spatio-temporal '*column*') with one time-period is different from that of a *spatio-temporal window* with two time-periods. Instead of a *scanning circle* traveling across the map, we might imagine a *scanning column* or tube with its height varying to define different numbers of time periods.

For example in the illustration below, the conventional cross-sectional scan statistic would simply move a two-dimensional window around the map. But the spatio-temporal window has a third dimension reflecting maps *stacked on top of one another*.


![(\#fig:unnamed-chunk-8)Image source: https://www.mdpi.com/1999-4907/11/4/454/htm](images/spatio-temporal-window.png) 


### Estimating *spatial-only* Kulldorff scan statistics

The `kulldorff()` function in the package, `SpatialEpi` is a relatively easy way to implement spatial-only scan statistics.  

#### Prepare data

Look at the help documentation for the function, `kulldorff()`. The function is not currently written to directly use a spatial object in `R` (e.g. an object of class `sf` or `sp`), so instead we must supply a matrix of $x,y$ coordinates representing the centroids of each area region (county in this scenario). The centroids are used in the iterative specification of the study window, determining who is *in* versus *out* of the window by whether the county-centroid falls in or out of the circle.

First we need the $x,y$ coordinates of the *centroid* of each county in a `matrix` form. The following code achieves that.


```r
sti_cent <- st_centroid(sti) %>%
  st_coordinates()
head(sti_cent)
```

```
##         X       Y
## 1 1057695 1255760
## 2 1363356 1098009
## 3 1095793 1279833
## 4 1367529 1010385
## 5 1225492 1068308
## 6 1279077 1097468
```

#### Call `kulldorff()` function

There are several other decisions to make when using the scan statistic. First, what is the maximum size window you wish to search? This can be specified using contextual knowledge about how large or small clusters are anticipated to be. In the absence of *a priori* knowledge about size, it is common practice to allow windows to vary from zero to a size large enough to include 50% of the population at risk within the window. 

In addition, you must set the number of Monte Carlo simulations of the null hypothesis (e.g. simulations of the distribution of counts under a *constant risk hypothesis*). As discussed previously, you need an adequately large number of iterations to approximate the distribution of what could happen by chance alone under the null. 

The precision (number of significant digits) of the resulting p-value is limited by the number of iterations.  Below I specify n=499 null iterations, which when added to the single test of the observed data produces n=500 versions of the test. Our inference is based on how unusual the single test from the observed data are in relation to the 499 tests under the null.

Finally, the specification of the `alpha.level` dictates which (if any) *secondary clusters* are retained. The most-likely cluster will be reported no matter the significance, but secondary clusters are only retained if they are smaller than the alpha threshold. For the purposes of exploration I set alpha to 0.2.


```r
k1 <- kulldorff(sti_cent, 
                cases = sti$STD,
                population = sti$POP,
                expected.cases = sti$expected,
                pop.upper.bound = 0.5,
                n.simulations = 499,
                alpha.level = 0.2)
```

![](09-spatial-cluster-2_files/figure-latex/unnamed-chunk-10-1.pdf)<!-- --> 

The plot produced by default (to suppress plot specify `plot = FALSE`), shows a histogram of the simulated null distribution for log-likelihood ratios of the contrast of rates *inside* versus *outside* assuming the constant risk hypothesis.  

In other words, the permutation simulation applied the average risk to the actual population assuming simple Poisson distribution.  The histogram therefore includes information on the likelihood ratios for $n=499$ simulations of the null. In addition to simulated permutations there is $n=1$ actual observed likelihood ratio from the single most significant cluster identified from all-possible scans. In this case the single most significant cluster is indicated with a *red line*. It is quite evident that this cluster is *highly unusual* under the null assumption, with empirical *p-value = 0.002*.

#### Summarize results

Unfortunately, there is not a handy function for providing a pretty summary, but much information is contained within this object. By examining specific aspects of the result we can learn a great deal. First, note that the object produced, `k1` is a `list` meaning it is composed of several sub-parts. We can see the names of those parts like this:  


```r
# See the elements returned by function - explore them!
names(k1) 
```

```
## [1] "most.likely.cluster" "secondary.clusters"  "type"               
## [4] "log.lkhd"            "simulated.log.lkhd"
```


We will begin by looking at the `most.likely.cluster` component, which itself has several sub-parts:


```r
# See the row-numbers for the counties in the most-likely cluster
k1$most.likely.cluster$location.IDs.included
```

```
##  [1] 138 142 111 137 135  76  23   8 159 130  24 123 131  90  85  46 157 136 141
## [20] 129 122  99 145  83  29 104  74 153 152  96  35  95  45  78 100  62  93  88
## [39] 105  69  98  32 128 140  38  49  12   5 158 119 151  34  75 125  53 102  91
## [58] 144 132  18  25  89  81  80  72 124  48  26  19 139 120  52  63 154  97 121
## [77] 117  84   6  36  37  50 134  79 156  59  68  82  66  94 147   1
```

```r
# See the SMR for the most-likely cluster
k1$most.likely.cluster$SMR
```

```
## [1] 1.255823
```

```r
# See the observed and expected cases inside cluster
k1$most.likely.cluster$number.of.cases
```

```
## [1] 55699
```

```r
k1$most.likely.cluster$expected.cases
```

```
## [1] 44352.6
```

You can see that the STI rate inside this cluster is two and a half times higher than the rate outside the cluster (e.g. the SMR contrasting rates *inside* versus *outside* is 2.54). 

We can also look at similar information for the *secondary* clusters, which are the clusters with the second-highest log-likelihood ratio.


```r
# see how many additional clusters reported:
length(k1$secondary.clusters)
```

```
## [1] 4
```

The object `secondary.clusters` is a list, with each element of the list containing the same information we just reviewed in the `most.likely.cluster`.  In other words we can see the p-value, SMR, and list of counties contributing to each of these secondary clusters. In this code-snippet I use the base-R function `sapply()` to extract the 5th element (SMR) and 8th element (p.value) from each of the secondary cluster in `k1$secondary.clusters`. (Alternatively you could have used `k1$secondary.clusters[[1]]$p.value`, and `k1$secondary.clusters[[2]]$p.value` to get the values). I use the `format()` function to specify the number of digits to print. 


```r
tibble(
  SMR = format(sapply(k1$secondary.clusters, '[[', 5), digits = 3), # this gets SMR's
  lik = format(sapply(k1$secondary.clusters, '[[', 6), digits = 2), # this gets log-likelihoods
  pval = format(sapply(k1$secondary.clusters, '[[', 8), digits = 3)) %>%# this gets p.values
  kableExtra::kable(align = 'c')
```


\begin{tabular}{c|c|c}
\hline
SMR & lik & pval\\
\hline
2.25 & 1013 & 0.002\\
\hline
1.40 & 245 & 0.002\\
\hline
1.33 & 33 & 0.002\\
\hline
1.27 & 25 & 0.002\\
\hline
\end{tabular}

First, notice that the log-likelihood ratios for these two secondary clusters are substantially smaller than our most-likely cluster (it was nearly 6000!). In addition the SMR's and p-values vary. 

#### Plotting results

Just as there isn't a handy function for summarizing the results, there also isn't a handy function for plotting results. As a result we have to do a little work to **see** where the clusters are. Here is a step-by-step strategy for creating a variable in our Georgia county STI dataset that indicates whether each county is in or out of a cluster.

1. First, initialize a new variable called `k1_cluster`. To *initialize* simply means to create it without any values (e.g. all set to `NA`).


```r
sti$k1_cluster <- NA
```

2. Now fill in the value for this new variable according to whether each county is **in** a given cluster.  Recall that the row-numbers for the counties included in the *most-likely cluster* are contained as a vector in `k1$most.likely.cluster$location.IDs.included`.  Therefore, we can use those row indices to say which counties should be assigned to **cluster 1** (the most-likely cluster). 


```r
sti$k1_cluster[k1$most.likely.cluster$location.IDs.included] <- 'Most likely cluster'
```


3. The same approach can be used to extract the `location.IDs.included` for each of the secondary clusters. Here I simply loop (using `for(i in 1:length(x))`) across however many `secondary.clusters` there are and name them.


```r
for(i in 1:length(k1$secondary.clusters)){
sti$k1_cluster[k1$secondary.clusters[[i]]$location.IDs.included] <- paste(
  'Secondary cluster ', i, sep = '')
}
```


The result is a mappable variable:


```r
tm_shape(sti) +
  tm_fill('k1_cluster',
          style = 'cat',
          textNA = 'Not in cluster',
          palette = 'Set1',
          title = '') + 
  tm_borders() + 
  tm_layout(legend.outside = T)
```

![](09-spatial-cluster-2_files/figure-latex/unnamed-chunk-18-1.pdf)<!-- --> 

There are several things apparent from this map. First and foremost, the STI rate in the portion of the state colored red is substantially higher than outside that portion, and the cluster including all of these counties has the largest likelihood ratio.  In addition to that huge cluster, there are a handful of secondary clusters that reached our threshold of significance at $\alpha = 0.2$.


### Estimating *spatio-temporal* Kuldorff scan statistic

In `R`, there is currently only one package that readily permits *spatio-temporal* scan testing, and that is `scanstatistics`.  It actually implements a somewhat limited version of the *temporal* component: It assess how cluster duration varies, but at least in its current iteration, all cluster duration go from the *last period* back. In other words if our data end in 2017, it will consider 2017, then 2017+2016, then 2017+2016+2015.  However what it (apparently) will not do is consider intervals of time in the middle of the study period (e.g. 2015+2016 but not including 2017).  This is unlike Kulldorff's implementation in the free software Sat Scan.

:::{.rmdcaution data-latex="{caution}"}

The examples below have some relatively complex looking R code.  It is provided here for those who might try to adapt the code to their own projects. However please note that I do not expect everyone to 'learn' or 'remember' all of these code details. The important high level concepts concern the interpretation of scan statistics. 

:::


#### Preparing data

The data in the `sti_long` spatio-temporal object include STI counts and population at risk for every Georgia county and for each year from 2008-2017. In other words there are 10 rows for every county.  

There are several ways to present data to the `scanstatistics` functions, but the easiest will probably be as an `sf` data frame. However the variables must follow a specific naming protocol (see help documentation).


```r
sti_scan2 <- sti_long %>%
  mutate(count = STD,       # event variable must be labeled 'count'
         location = GEOID, # region id must be labeled 'location'
         population = POP, # denominator must be labeled 'population
         time = as.integer(YEAR))%>%  # time-period must be labeled 'time'
  dplyr::select(time, location, count, population) 
```

#### Prepare geographic window *zones*

This package also has a unique way of defining the areas contained within the varying-sized *windows*, which are called *zones* in this context. The approach first defines k-nearest neighbors in order to locate how regions are *connected* to one another. Then using measures of distance between each region and its k-nearest neighbors, the varying-sized windows are applied. The result is a set of *zones* which consist of each county plus its neighbors starting at zero-distance (no neighbors) up to the maximum number of neighbors defined.  

Although the data are in the *long* format (e.g. multiple years for every geographic region, county), the zones should be calculated from an object where each region is only represented once.


```r
zones <- sti %>%
  st_centroid() %>% # convert polygons to centroid
  st_coordinates() %>% #converts sf object to matrix of x, y locations
  spDists(x = ., y = ., longlat = FALSE) %>%
  dist_to_knn(k = 50) %>% # distance up to the 50 nearest neighbors
  knn_zones() # convert into zones needed for scanstatistics based on distances
```

What exactly did this function do? First try looking at the data class of the object and its length:


```r
class(zones)
```

```
## [1] "list"
```

```r
length(zones)
```

```
## [1] 7718
```

Because the object is of class `list`, we can examine individual list elements to better understand the output (here I just randomly chose some elements):


```r
zones[[34]]
```

```
##  [1]   1   3   9  26  28  34  44  50  52  65  72  77  79  80  82  89  92  94 101
## [20] 103 106 107 113 115 117 118 124 127 139 147 150 151 156 158
```

```r
zones[[657]]
```

```
##  [1]  2  4 14 17 39 41 56 57 60 67 70 87
```

Notice that each element in the list called `zones` is a vector of *row-id's*. In other words what `zones` represents is every iteration of *location x window-size* calculated from the preceding procedure. This will become important when it comes time to plot the results.

#### Estimate spatio-temporal scan statistics

There are several scan statistic options in this package including reliance on Poisson assumptions versus Negative binomial, and allowing for estimation with population denominators, or with expected counts. Here is an implementation of the population-denominator version of the Poisson scan (**note** this will take a minute to run):


```r
k2 <- scan_pb_poisson(sti_scan2, 
                      zones = zones,
                      n_mcsim = 499)
print(k2)
```

```
## Data distribution:                Poisson
## Type of scan statistic:           population-based
## Setting:                          univariate
## Number of locations considered:   159
## Maximum duration considered:      9
## Number of spatial zones:          7718
## Number of Monte Carlo replicates: 499
## Monte Carlo P-value:              0.002
## Gumbel P-value:                   NULL
## Most likely event duration:       9
## ID of locations in MLC:           4, 47, 60, 71
```

The basic summary information tells us the row-ID's for the most likely spatio-temporal cluster, and that of the 9 year period, the most-likely duration of this cluster is in fact 9-years (e.g. 2010-2018). In other words the cluster of STI's is quite persistent over time!

#### Visualizing most-likely clusters

The package `scanstatistics` has a function for extracting the most-likely clusters, and from this we can visualize their location, and explore the duration and intensity of each.

First, we use the function `top_clusters()` to extract the information. In this case we are asking for the **top 5** clusters, specifying that we want them to be non-overlapping.


```r
top5 <- top_clusters(k2, zones, k = 5, overlapping = FALSE)
```

To see what `top_clusters()` produced, look at the object:


```r
top5
```

```
##       zone duration     score relrisk_in relrisk_out MC_pvalue Gumbel_pvalue
## 1      154        9 11897.572   1.572102   0.9287618     0.002             0
## 34    4596        9  8900.966   1.424261   0.9307529     0.002             0
## 434   6962        9  5326.146   1.538497   0.9659981     0.002             0
## 6177   501        8  2662.215   1.850967   0.9883536     0.002             0
## 13398 4486        9  1640.551   1.723231   0.9917845     0.002             0
```

As expected there are 5 rows in the object, and each row tells us something about that respective cluster. 

* The first thing it tells us is what *spatial* zone is involved. Remember how each element in the object `zones` was a vector of neighbors? This zone number refers to a particular neighbor set with the highest likelihoods of containing clustered deaths.  
* In addition the object `top5` tells us the most likely duration or *temporal* dimension of the cluster. So the single most likely *spatio-temporal* cluster is described by zone 154, and it is 9 years in duration; the fifth most likely cluster is described spatially by zones 501, and temporally was 8-years in duration.

To get the information about zones into our `sf` object for mapping we can use functions from the package `purrr` which is an efficient way to process vectors contained in lists. What it is doing is looking at the zones defined in `top5$zone`, and using that number, extracting the vector of row-ids from our original `zones` object. This produces a list of involved counties.



```r
# First, get vector of county names
county <- as.vector(sti$NAME)

# Find the counties corresponding to the spatial zones of the 5 clusters.
top5_counties <- top5$zone %>%
  purrr::map(get_zone, zones = zones) %>%
  purrr::map(function(x) county[x])
```

The new object, `top5_counties` is a list of length 5, and each element of the list is a vector of county names.

Now we can use this list of names to populate a new variable in our `sf` dataset. We'll do that by iterating through the elements in the list, `top5_counties`, and apply a cluster ID, cluster duration, and cluster score, which is related to the log-likelihood.


```r
for(i in 1:length(top5_counties)){
  cluster <- top5_counties[[i]]
  sti$cluster[sti$NAME %in% cluster] <- i
  sti$c_score[sti$NAME %in% cluster] <- top5$score[i]
  sti$c_duration[sti$NAME %in% cluster] <- top5$duration[i]
}
```

#### Mapping top-5 clusters


```r
tm_shape(sti) + 
  tm_fill('cluster',
          style = 'cat',
          palette = 'Set1') +
  tm_borders()
```

![](09-spatial-cluster-2_files/figure-latex/unnamed-chunk-28-1.pdf)<!-- --> 

So why are there only 4 clusters when we asked for 5? After some investigation it is clear that the most likely cluster and the second most-likely fully overlap (despite the option to disallow overlapping clusters!). 

You may also note that the cluster locations look quite different from the cross-sectional analysis of 2018 data! This is because the search for spatio-temporal clustering can turn up distinct patterns from what would be observed in a single year. These clusters rise to the top because there is the strongest evidence for them being significantly unusual.

If you wanted to also produce a visualization of the time-span of each of these clusters, you could use `ggplot2` to do so. First we create a variable for the start and end time (all end times are assumed to be the last year, 2017). 


```r
# Assign a cluster number called 'order'
top5$order <- 1:nrow(top5)
# Calculate start/end years from cluster duration
top5$end <- 2018
top5$start <- 2018 - top5$duration

# Create ggplot
g <- ggplot(top5, aes(x = start, y = order, col = as.factor(order)))
g + geom_segment(aes(yend = order), xend = 2019, size = 2) + 
  geom_point(size = 3) + 
  labs(x = 'Cluster timing',
       y = 'Cluster number',
       col = 'Cluster') 
```

![](09-spatial-cluster-2_files/figure-latex/unnamed-chunk-29-1.pdf)<!-- --> 


Because most of the clusters represent persistently high levels over the entire 9-year period, there is not much distinction in this example. However, Cluster 5 does stand out in that it was only apparent in the beginning of the study period.

#### Mapping relative scores 

Each county has a varying probability of being *in* versus *out* of a cluster. There is a function (*which takes a long time to run!*) that calculates, the average of the statistic for each space-time window that the location is included. In other words, it averages the statistic over both the zones and the maximum duration. The reason for doing this, is to quantify (and visualize) the relative likelihood that each location is a part of the cluster. 


```r
# Note: This step takes awhile...about 4-5 minutes on my computer
county_scores <- score_locations(k2, zones)
```


```r
# This part goes quicker - first just rename some stuff for merging
sti_scan3 <- county_scores %>% 
  mutate(NAME = county) %>%
  left_join(sti, by ='NAME') %>%
  st_as_sf() # this just converts the new object back to 'sf'
```

Now you can map the *relative score*, interpreting it as the relative likelihood of each county being a member of the cluster:


```r
tm_shape(sti_scan3) +
  tm_fill('relative_score') + 
  tm_borders()
```

![](09-spatial-cluster-2_files/figure-latex/unnamed-chunk-32-1.pdf)<!-- --> 

This shows that, using the 9-year time series, there is variation in the likelihood of counties being a part of a true cluster, with highest probability around the most likely cluster. It is once again notable that the patterns of spatio-temporal clustering are relatively distinct from the patterns of point-in-time cross-sectional clustering using 2018 data only.

### Concluding thoughts

The scan statistics represent one more tool useful for investigating for the existence and location of spatial clusters of disease events. In the case of the scan statistics, the *clustering* is specifically local *excess risk* in violation of the assumption of *spatial homogeneity* or constant risk. It is therefore distinct from the measures of *spatial auto correlation* such as the Moran's I statistic. 

Scan statistics are useful for finding a statistically significant most-likely cluster, and for exploring secondary clusters. Their extension to spatio-temporal setting is another feature. This information can compliment what is learned from tests of spatial auto correlation, and from the global and local test discussed last week.  

