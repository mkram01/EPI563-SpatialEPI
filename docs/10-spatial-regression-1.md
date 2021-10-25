# Spatial Regression I: Spatializing aspatial regression residuals {#spatreg1}

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

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{1\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{242, 242, 242}\hspace{6pt}\parbox[b]{1\textwidth-6pt-6pt}{\huxtpad{2pt + 1em}\raggedright Choose and justify spatial analytic methods that aligns with the epidemiologic research question or objective\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{1\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{230, 230, 230}\hspace{6pt}\parbox[b]{1\textwidth-6pt-6pt}{\huxtpad{2pt + 1em}\raggedright Calculate and interpret spatial patterns of residuals from an aspatial multivariable regression model\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}
\end{tabularx}
\end{threeparttable}\par\end{centerbox}

\end{table}
 
```

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
\caption{(\#tab:unnamed-chunk-2) Vocabulary for Week 10}
 \setlength{\tabcolsep}{0pt}
\begin{tabularx}{0.9\textwidth}{p{0.45\textwidth} p{0.45\textwidth}}


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{84, 153, 199}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{\textcolor[RGB]{255, 255, 255}{Term}}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{84, 153, 199}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright \textbf{\textcolor[RGB]{255, 255, 255}{Definition}}\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{212, 230, 241}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{Data generating process}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{212, 230, 241}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright The true underlying causal structure that gives rise to (generates) the data from which you sampled. The data generating process is not known. We use models to try to emulate or approximate the data generating process.\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}

\multicolumn{1}{!{\huxvb{255, 255, 255}{1}}p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{169, 204, 227}\hspace{6pt}\parbox[b]{0.45\textwidth-6pt-2pt}{\huxtpad{2pt + 1em}\raggedright \textbf{Model residual}\huxbpad{2pt}}} &
\multicolumn{1}{p{0.45\textwidth}!{\huxvb{255, 255, 255}{1}}}{\cellcolor[RGB]{169, 204, 227}\hspace{2pt}\parbox[b]{0.45\textwidth-2pt-6pt}{\huxtpad{2pt + 1em}\raggedright The difference between the model predicted value of the outcomee and the observed value. In spatial epidemiology, model residuals can provide clues as to the presence of missing variables that produce spatial patterns\huxbpad{2pt}}} \tabularnewline[-0.5pt]


\hhline{>{\huxb{255, 255, 255}{1}}->{\huxb{255, 255, 255}{1}}-}
\arrayrulecolor{black}
\end{tabularx}
\end{threeparttable}\par\end{centerbox}

\end{table}
 
```

## Spatial Thinking in Epidemiology

### Multivariable regression for exploring spatial data

Multivariable regression is not magic. It is just fancy correlations and estimation of sample means. It is a statistical tool that takes noisy or variable data, and *smooths* or *reduces* it to summary statistics which we hope are more interpretable than trying to make meaning from the raw data alone. 

Multivariable regression methods are useful to epidemiologists because this is often what we want: *smoothed summaries* that distill some trends or features that (hopefully) give us clues about the true process.  

There are several motivations for using multivariable regression with spatial data:

1. **For descriptive spatial analysis**, we may be interested in producing *adjusted* estimates conditioned on multiple covariates (e.g. age strata, socioeconomic status, or background/nuisance environmental features). While it is possible to produce indirectly adjusted estimates as discussed in Disease Mapping, this becomes more challenging with higher data-dimensionality (more variables). For example we could use multiple variables to *predict* the disease count (or rate) in each region as a function of those covariates.
2. **For exploration and diagnosis of aspatial model performance**, we may want to evaluate whether regression models explain spatial auto correlation, or whether there is undiagnosed dependency (spatial autocorrelation) in residuals that is not apparent from conventional aspatial residual diagnostic plots. 
3. **For etiologic spatial analysis**, we may be interested in estimating conditional associations which could be interpreted as causal effect estimates under certain circumstances including adjustment for causally confounded pathways. This motivation for aspatial modeling extends to spatial in at least two scenarios:
    * Interest is in association between a predictor and an outcome, conditional on covariates, but there is concern for residual nuisance spatial auto correlation which if unaddressed could bias estimates
    * Interest is in association between a predictor and an outcome, conditional on covariates, and there is spatial interaction or spillover in the causal process.
  
### Data Generating Process

Of critical importance for effective use of regression in any aspect of epidemiology, including spatial, is theorizing or hypothesizing about the **data generating process**. This is simply a phrase for describing the (possibly unknown) mechanisms in the world that collectively *generated* the events that gave rise to the data we sampled and observed.  In causal epidemiology, we often use directed acyclic graphs (DAGs) as illustrations or models of possible data generating processes.  

The reason to bring this concept up at this point, is because the process by which spatial patterns are *generated* is of central interest in spatial epidemiology. If health events (e.g. incident cancer, influenza, or diabetes) were homogeneous and constant over space -- or if they were heterogeneous but purely random and independent of one another -- we might see less value in the tools of spatial epidemiology to gain insight.  

However, when we observe *spatial structure* or *patterns* (including extremes of heterogeneity or dependence) in disease or health status, it is unlikely that these patterns just 'sprung up' for no reason. In other words, rarely is your physical location at a specific latitude and longitude the sole explanation for having higher or lower risk of disease. Instead *spatial patterns in health* are due to *spatial patterns in the* **causes** *of health*, or the data generating process.  Therefore we often wish to dig deeper to understand these causes, and to describe as accurately as possible the data generating process.

### Model residuals are not just mistakes

You will likely recall from biostatistics that for a given random variable we can define *statistical error* as the deviation of a specific observation's measured value from its *expected value*, which is the true mean in the underlying population.  Because we rarely know the true mean for the entire population, we use the mean from our specific sample as an approximation.  Therefore a model *residual* is the difference of an observation from the *sample mean*.

The use of the word '*error*' is used in some contexts because these deviations are presumed to represent some unknown, random, *mistakes* in the estimation perhaps because of sampling error (e.g. we only took a sub-sample from the full population) or because of simple random chance (e.g. 'measurement' error).  Because we sometimes treat the errors as random mistakes, we often assume the errors follow certain random distributions. 

For example, in linear regression we assume that the model residuals are *normally distributed*, and that -- on average -- their value is zero. In other words, we assume that the average observation is in fact equal to the sample mean, and therefore there is zero difference between them. In addition, for the residuals that are not exactly equal to the expected value, they could be positive (e.g. the observed value is larger than expected), or negative (observed value is smaller than expected), and the amount of variability is summarized as $\sigma^2$.

So in classical theory, these modeled '*mistakes*' or residuals are assumed to show a pattern consistent with random chance: 

1. They should be independent of one another;
2. They should vary around zero;
3. They should follow an expected distribution (e.g. normal distribution for simple linear regression). 

What, then, does it mean if the pattern of the residuals **does not** appear as expected? This is what you have been trained to examine when you do residual diagnostics of regression models. 

:::{.rmdnote data-latex="{note}"}

**Regression models to approximate the data generating process**

*Spatial variation in disease can be explained by spatial variation in the causes or predictors of disease*. A somewhat simplistic strategy to begin to explore the data generating process follows:

1. The predicted value from an *unconditional mean* regression model (e.g. a model with only an intercept but no other predictors) is that every observation is *average* (e.g. the prediction is that each observation equals the intercept). The model residuals represent *error* or difference of each observation from the global average.
2. Putting these residuals on the map describes the pattern of *error* or *unexplained* variation. If there is autocorrelation, we might hypothesize there are *missing variables* that are part of the data generating process. 
3. We could fit one or several additional models in which we add hypothesized predictor of the data generating process. For each model, we can make a new prediction of the value of each observation, incorporating the $\beta$ coefficient and measured value of the predictor.
4. Putting the residuals from *conditional* or *adjusted* models on the map describes whether there is **still** any spatial structure, after we have accounted for the parts of the data generating process attributable to the exposures or predictors in the model.

:::

This basic logic - that model residuals '*absorb*' or '*describe*' the *unexplained* variation in health above and beyond expectations from the specified model, is leveraged in many analytic strategies in spatial epidemiology. We can use patterns in regression model residuals as clues about how well we are approximating the *data generating process*. Specifically, we often test for when or whether the residuals are spatially independent (as expected under the null hypothesis for model errors), or spatially dependent or auto-correlated. 

In other words, putting regression residuals *on the map* in their spatial context provides a whole new lens through which to think about the data. 

    
## Spatial Analysis in Epidemiology

### Spatializing aspatial regression

This is the first of three weeks considering the application of *multivariable regression* to spatial data. A logical starting point is considering how we can interpret the conventional *aspatial* regression models you have become familiar with from biostatistics and epidemiologic modeling coursework.  
    

#### Data & Packages




```r
pacman::p_load(tidyverse, # General data processing
               sf,        # Read/write sf data
               spdep,     # Moran's I and spatial neighbors functions
               tmap,      # Mapping
               MASS)      # Statistical package including function for studentized residuals
```








```r
vlbw <- st_read('ga-vlbw-covar.gpkg')  %>%
  mutate(rate = VLBW / TOT)
```

In this tutorial, we will once again use the `vlbw` dataset with *very low birthweight* prevalence in Georgia counties as an example. Although it has the identical outcome as that used in prior examples, this dataset also has several contextual variables as covariates. These contextual variables are selected as proxies of one hypothesized *data generating process*. Specifically, we now have the following variables measured for each county:

* `MCD`: A categorical variable designating each county as a *Maternity Care Desert* or an area with inadequate access to outpatient and inpatient women's health care services
* `PctPov`: A continuous measure of the percent of the population living below the federal poverty line (ranges from 0 to 1)
* `isolation`: A measure of county-level Black-White residential racial segregation using the Isolation Index (ranges from 0 which is no segregation to 1 which is complete segregation).
* `FI`: Food Insecurity index
* `SocCap`: Social Capital index
* `pctNOIns_Fem`: The proportion of women without health insurance

These added variables may not explain all differences in risk for very low birth weight. But because each of these is known to vary spatially, and each is related to population-level lifecourse economic opportunity, health status and access to health care, they are plausible (or at least hypothesized) contributors to the generation of spatial structure or dependence in population VLBW.


#### Fitting unconditional (empty) model

We have discussed extensively the benefits of modeling '*rate*' data with numerator and denominator counts as arising from a Poisson, binomial, or negative binomial distribution. This is because the values are not normally distributed, and the variance may be different (heteroskedastic) across regions due to different population size at risk.  

However, as an approximation we will convert the numerator and denominator counts into a continuous '*rate*' or ratio, and model using linear regression. To partially account for the heteroskedasticity, we will weight each county by its relative population (e.g. number of births at risk for VLBW).




Fitting linear regression models in `R` is straightforward. For our purposes, we might first fit an *empty* or *unconditional mean* model. That means a regression model where there is only an intercept, but no predictors. This model essentially decomposes the outcome into a *global mean* value (the expected value), and the residuals represent the difference of each county from that overall mean or expectation.




```r
# Create a vector of weights that reflect the relative population (births) size in each county
wts <- vlbw$TOT / sum(vlbw$TOT) * 159

# Fit a weighted linear regression model of the raw (observed) rates
m0 <- lm(rate ~ 1, 
         data = vlbw,
         weights = wts)

summary(m0)
```

```
## 
## Call:
## lm(formula = rate ~ 1, data = vlbw, weights = wts)
## 
## Weighted Residuals:
##        Min         1Q     Median         3Q        Max 
## -0.0149727 -0.0035211  0.0003131  0.0029493  0.0186953 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 0.018189   0.000436   41.72   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.005498 on 158 degrees of freedom
```

Look at the summary of this model. The results are sparse because we did not include any predictors. The intercept estimate is our modeled expectation of the global average risk for VLBW (e.g. 0.018 or 1.8%). The summary results also report the basic numerical range of the model residuals. Below we will put those residuals *on the map*, but first let's fit one more model.

#### Fitting conditional model

That previous model is not very interesting, so we might add some predictor variables. Here we consider two measures of social and material context that could influence women's health (poverty rate, `pctPOV` and residential racial segregation, `isolation`), as well as two indicators of health access including the prevalence of women in the county who are uninsured (`pctNOIns_Fem`) and whether each county is a designated Maternity Care Desert (`MCD`), meaning there is no access to OB/GYN or midwives, nor any hospitals with labor and delivery capacity.


```r
m1 <- lm(rate ~ pctPOV + isolation + pctNOIns_Fem + MCD,
         data = vlbw,
         weights = wts)
summary(m1)
```

```
## 
## Call:
## lm(formula = rate ~ pctPOV + isolation + pctNOIns_Fem + MCD, 
##     data = vlbw, weights = wts)
## 
## Weighted Residuals:
##        Min         1Q     Median         3Q        Max 
## -0.0103096 -0.0023745  0.0003931  0.0026713  0.0105881 
## 
## Coefficients:
##                      Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         0.0074464  0.0017699   4.207 4.39e-05 ***
## pctPOV              0.0275036  0.0068742   4.001 9.80e-05 ***
## isolation           0.0114604  0.0015850   7.231 2.15e-11 ***
## pctNOIns_Fem        0.0032358  0.0120122   0.269    0.788    
## MCDLimited Access 1 0.0008278  0.0009327   0.888    0.376    
## MCDNo Access        0.0009929  0.0013909   0.714    0.476    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.004154 on 153 degrees of freedom
## Multiple R-squared:  0.4471,	Adjusted R-squared:  0.429 
## F-statistic: 24.74 on 5 and 153 DF,  p-value: < 2.2e-16
```

In this case, it appears that (in the non-spatial results), the socio-material variables of poverty rate and segregation are strongly correlated with VLBW, but conditional on those measures, there is no independent association of either prevalence uninsured or living in a maternity care desert. You could carry out routine regression diagnostics to evaluate extreme values, leverage, or normality of the residuals. 

### Mapping residuals

But our purpose here is to extend the examination of model performance and fit from simply *aspatial* to *spatial* context. The first easy step is to attach the residuals of each model (`m0` representing only the deviations of each county VLBW rate from the overall mean; and `m1` representing the deviation of each county from the value predicted by covariates) to our data object and map them. Specifically, because we used weighted linear regression to account for unequal variance in estimates among counties, we extract the *studentized residuals* which are residuals normalized to their variance. There is a function in the package `MASS` for calculating studentized residuals (e.g. `studres()`).


```r
vlbw$m0_resids <- studres(m0)
vlbw$m1_resids <- studres(m1)
```

There are many ways to visualize these data. For example we might simply be interested in seeing the spatial distribution of all the residuals, both those at extremes as well as those near zero. Using the `style = "quantile"` accomplishes this objective.

:::{.rmdtip data-latex="{tip}"}

**Residuals should be represented with diverging color palette**

Remember what residuals are: deviations from an average expected value.  If the predicted value is truly an *average* some deviations should be positive, some should be negative, and some should be zero (e.g. the same as predicted).  

When we map values that have a central value (e.g. zero in this case or 1 in the case of a ratio measure like RR or SMR), it is best to use a diverging color palette. Below we specify `RdYlGn`, which is diverging.  

`midpoint = 0` specifies the value of the *neutral* or central color.

:::


```r
tm_shape(vlbw) +
  tm_fill(c('m0_resids', 'm1_resids'),
          style = 'quantile',
          palette = 'RdYlGn',
          midpoint = 0) +
  tm_borders()  +
  tm_layout(legend.position = c('RIGHT','top'),
            inner.margins = c(0.02, 0.02, 0.02, 0.1),
            legend.format = list(digits = 1))
```

![](10-spatial-regression-1_files/figure-latex/unnamed-chunk-9-1.pdf)<!-- --> 



In these maps it appears that there is more spatial clustering of residuals in the empty model (`m0`) than in the conditional model (`m1`). More specifically, there appear to be clustered *negative residuals* in North Georgia (e.g. places where the model predicted a higher rate than was observed) and positive residuals in Southwest Georgia (e.g. places where the observed VLBW was higher than predicted by the model).

In contrast the map on the right appears (qualitatively at least) to have less clustering of county values. For some counties the prediction is better (e.g. closer to zero), but for others it actually seems to be worse (e.g. further from zero). 

### Moran's I tests on `lm` models

Recall from two weeks ago, that we used the global Moran's I statistic to test for spatial auto correlation. As a reminder, auto correlation refers to the dependency (correlation) of the value of a measure in one place with the values of the neighbors of that place. In the *absence* of spatial structure or clustering, we expect *spatial independence* (e.g. the null hypothesis), and therefore evidence of spatial auto correlation suggests *departure from independence*.

In linear regression we assume that conditional on the global mean (intercept), and the mean slope for covariates (beta estimates), the residual error is normally distributed and independently distributed.  That assumption can be checked *aspatially* with plots of residuals, but this check can be extended to space by applying the Moran's I statistic to model residuals.

#### Creating spatial neighbors

Just as in past exercises, the definition of spatial neighbors can be critically important, and results are often sensitive to the choice (e.g. each choice represents a different alternative hypothesis). The definition of neighbors is a definition of which units are likely to interact with or depend on which others. Is it only contiguous and adjacent units (as implied by Queen contiguity), or is it all units within a certain sphere of influence, or is there some inverse distance relationship that is continuous over space? 

Here I use the Queen contiguity neighbor definition because **a)** it is convenient and intuitive; and **b)** it is commonly used in spatial analysis. But to be clear, it is not the only choice, and you as the analyst should always consider whether there are better alternatives.

This code chunk combines several steps: first it creates an `nb` neighbor object; and then, it takes the `nb` object and converts it to the `listw` object needed for Moran's I.


```r
qnb_listw <- vlbw %>%
  poly2nb() %>%
  nb2listw()
```


#### `lm.morantest()` function

In the section on detecting general autocorrelation, we introduced several function for calculating the global Moran's I including `moran.test()` and `moranI.test()`. These were appropriate for evaluating an observed data series like the observed VLBW rate. In this instance, the residuals are *modeled* estimates and thus require a different approach. 

To evaluate spatial auto correlation of the *residuals from a model* we will use the function `lm.morantest()` and its derivatives. 


:::{.rmdcaution data-latex="{caution}"}

It would be possible, **but incorrect**, to extract the residuals from the model (as we did above for mapping) and apply `moran.test()` directly.

:::


```r
lm.morantest(m0, listw = qnb_listw)
```

```
## 
## 	Global Moran I for regression residuals
## 
## data:  
## model: lm(formula = rate ~ 1, data = vlbw, weights = wts)
## weights: qnb_listw
## 
## Moran I statistic standard deviate = 4.6616, p-value = 1.569e-06
## alternative hypothesis: greater
## sample estimates:
## Observed Moran I      Expectation         Variance 
##      0.223521496     -0.005214700      0.002407732
```

```r
lm.morantest(m1, listw = qnb_listw)
```

```
## 
## 	Global Moran I for regression residuals
## 
## data:  
## model: lm(formula = rate ~ pctPOV + isolation + pctNOIns_Fem + MCD,
## data = vlbw, weights = wts)
## weights: qnb_listw
## 
## Moran I statistic standard deviate = 0.56403, p-value = 0.2864
## alternative hypothesis: greater
## sample estimates:
## Observed Moran I      Expectation         Variance 
##      0.016003102     -0.011353497      0.002352452
```

There are several observations to make about the results above:

* The Moran's I evaluating the degree of spatial auto-correlation among the residuals for the *unconditional model*, `m0` is 0.22 (p < 0.001). In other words there is moderate clustering or spatial dependence in VLBW.
* The Moran's I evaluating residuals for the *conditional model* (e.g. `m1`, specifically adjusted for the 4 variables described) is 0.02 (p = 0.29).
* Looking back at the model summary for model `m1` we see that the adjusted $R^2$ was 0.43. That is to say these four variables '*explain*' some, but not all, of the between-county variation in VLBW. 
* Together these results suggest that the *spatial patterns* of clustering are largely explained by the four variables, but the *non-spatial patterns* of between-county differences are not fully explained.
* Said another way, model `m1` describes a possible *data generating process* that lead to **spatial dependence** or clustering, but model `m1` does not fully describe a *data generating process* for **spatial heterogeneity** in risk among counties


:::{.rmdcaution data-latex="{caution}"}

**Correlation is not causation**

Whether the statistical patterns from the preceding results represent causal patterns versus spurious associations due to confounding, selection, misclassification, or random error requires knowledge and insight beyond the model output. 

For instance it is possible that a set of variables "*explains*" the spatial dependence or heterogeneity but those variables are only proxies for other (possibly unmeasured) causal structures.

:::

This process -- in which sequential models with different variables included are compared -- is an exploratory approach to understanding not only the relationship between predictor and outcome variables, but the *spatial patterning of relationships*. Variables that -- when adjusted -- decrease spatial auto correlation are tapping into some aspect (or proxy) of the *reason for clustering in the first place*. 

Of course the fact that these four variables '*explain*' the spatial autocorrelation is not equivalent to these four variables being the *causal data generating process*. To evaluate causation we would need to more fully investigate threats to causal inference including individual-level, ecologic-level, and cross-level confounding. 

### Moran's I tests on `glm` models

As mentioned in the previous section, the focus on linear regression, with its underlying Gaussian probability distribution, is in contrast to our focus on distributional assumptions from the generalized linear exponential family including Poisson and Negative Binomial. One reason is because many of the statistical tools for spatial auto correlation, developed in fields more accustomed to normally-distributed continuous data, rather than count or binomial data common in epidemiology. 

But is it possible to use tools like the Moran's I statistic on residuals from GLM models? Well there is certainly some reason to be cautious. As you may have learned in biostatistics (or EPI III), the *residuals* from a GLM model (e.g. from a logistic regression) do not behave like residuals from a linear model, in part because they are *not normally distributed* and may not be *homoskedastic*. Even on the link scale (e.g. the *logit* or *log* scale), there are differences. 


:::{.rmdcaution data-latex="{caution}"}

Because the `glm` model families do not fully meet the assumptions of the linear model Moran's I tests, the following section should be seen as purely exploratory. 

:::


However, it is possible to examine *deviance residuals* from `glm` models, and assess their degree of spatial auto correlation, and the locations of better or worse model fit. To begin, we fit an unconditional and conditional *Poisson* model to estimate the prevalence of very low birthweight by county.

Note that we are no longer weighting for population (e.g. `TOT`), because that is incorporated directly into the Poisson model as an offset.


```r
g0 <- glm(VLBW ~ 1 + offset(log(TOT)), 
          data = vlbw,
          family = poisson())
g1 <- glm(VLBW ~ pctPOV + isolation + pctNOIns_Fem + MCD +
            offset(log(TOT)), 
          data = vlbw,
          family = poisson())
```


```r
summary(g0)
```

```
## 
## Call:
## glm(formula = VLBW ~ 1 + offset(log(TOT)), family = poisson(), 
##     data = vlbw)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -4.8499  -1.2148   0.0915   0.8064   5.0633  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -4.00696    0.01476  -271.4   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for poisson family taken to be 1)
## 
##     Null deviance: 409.27  on 158  degrees of freedom
## Residual deviance: 409.27  on 158  degrees of freedom
## AIC: 1081.6
## 
## Number of Fisher Scoring iterations: 4
```

```r
summary(g1)
```

```
## 
## Call:
## glm(formula = VLBW ~ pctPOV + isolation + pctNOIns_Fem + MCD + 
##     offset(log(TOT)), family = poisson(), data = vlbw)
## 
## Deviance Residuals: 
##      Min        1Q    Median        3Q       Max  
## -3.02292  -0.75060   0.08613   0.75246   2.89161  
## 
## Coefficients:
##                     Estimate Std. Error z value Pr(>|z|)    
## (Intercept)         -4.63412    0.08267 -56.058  < 2e-16 ***
## pctPOV               1.49965    0.29511   5.082 3.74e-07 ***
## isolation            0.64721    0.07094   9.123  < 2e-16 ***
## pctNOIns_Fem         0.24054    0.54309   0.443    0.658    
## MCDLimited Access 1  0.04657    0.04188   1.112    0.266    
## MCDNo Access         0.06040    0.06128   0.986    0.324    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for poisson family taken to be 1)
## 
##     Null deviance: 409.27  on 158  degrees of freedom
## Residual deviance: 220.93  on 153  degrees of freedom
## AIC: 903.31
## 
## Number of Fisher Scoring iterations: 4
```

As you examine the summary results, recall that because this is a Poisson regression, the coefficients are on the log scale. So the $e^{intercept}$ is the background prevalence/risk of VLBW, and $e^\beta$ represents the relative excess prevalence/risk of VLBW for each 1-unit increase in the predictor variable.

### Mapping `glm` residuals

First extract the *deviance residuals* from the `glm` objects:


```r
vlbw$g0_resids <- resid(g0, type = 'deviance')
vlbw$g1_resids <- resid(g1, type = 'deviance')
```

Then map them:


```r
tm_shape(vlbw) +
  tm_fill(c('g0_resids', 'g1_resids'),
          style = 'quantile',
          palette = 'RdYlGn',
          midpoint = 0) +
  tm_borders()  +
  tm_layout(legend.position = c('RIGHT','top'),
            inner.margins = c(0.02, 0.02, 0.02, 0.1),
            legend.format = list(digits = 1))
```

![](10-spatial-regression-1_files/figure-latex/unnamed-chunk-15-1.pdf)<!-- --> 


As we saw with the `lm()` models results above, there appears qualitatively to be slightly more clustering or dependence in the left (unconditional, `m0`) map as compared to the right (conditional or adjusted model, `m1`).  Unlike the previous set of maps, it appears that *magnitude* of the deviation of counties from the predicted (e.g. the min and max of the residuals) is smaller in the adjusted model.

### Moran's I for `glm`

It turns out the `lm.morantest()` function will actually accept a `glm` model object. That does not mean the use of Moran's I on deviance residuals from a `glm` model is interpretable in the same way as expected (e.g. hypothesis testing is discouraged), but with caution it could be a useful exploratory tool.


```r
lm.morantest(g0, listw = qnb_listw)
```

```
## 
## 	Global Moran I for regression residuals
## 
## data:  
## model: glm(formula = VLBW ~ 1 + offset(log(TOT)), family = poisson(),
## data = vlbw)
## weights: qnb_listw
## 
## Moran I statistic standard deviate = 4.5915, p-value = 2.201e-06
## alternative hypothesis: greater
## sample estimates:
## Observed Moran I      Expectation         Variance 
##     0.2284486189    -0.0002192915     0.0024803253
```

```r
lm.morantest(g1, listw = qnb_listw)
```

```
## 
## 	Global Moran I for regression residuals
## 
## data:  
## model: glm(formula = VLBW ~ pctPOV + isolation + pctNOIns_Fem + MCD +
## offset(log(TOT)), family = poisson(), data = vlbw)
## weights: qnb_listw
## 
## Moran I statistic standard deviate = 0.067635, p-value = 0.473
## alternative hypothesis: greater
## sample estimates:
## Observed Moran I      Expectation         Variance 
##     0.0024999785    -0.0009614966     0.0026192872
```

Reassuringly, thee results using the Poisson model are quite consistent with the weighted linear regression model in both the magnitude and statistical significance of the Moran's I test statistic. 


### Final words

While we have not directly tackled *spatial regression* this week, we have illustrated how easily conventional *aspatial regression* models can be projected onto space, assuming that the units of observation correspond to geographic places. This exploratory and diagnostic approach greatly extends our understanding of model relationships and can begin to answer the questions raised over the past two weeks about *why* or *how* health data came to be clustered in space.

In the next two weeks we will build on this to more formally incorporate spatial relationships into the model itself.


