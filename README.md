# Generalized additive modelling with R

### Aarhus University PhD Course

* 2024 running: December 10<sup>th</sup> &ndash; 12<sup>th</sup>

* Class times: 0930-1600

* ECTS credits: 1.5 ECTS

* Language: English

* Fee: 350 DKK

## Name of course leader

Gavin Simpson, Assistant Professor, Department of Animal and Veterinary Sciences, Aarhus University gavin@anivet.au.dk

### Registration

You can register for the course here: <https://events.au.dk/phdcoursegeneralizedadditivemodellingwithr>

<!-- ### Slides

* [Monday](https://gavinsimpson.github.io/au-multivariate-stats/slides/01-dissimilarity-clustering-diversity/slides.html)

* [Tuesday](https://gavinsimpson.github.io/au-multivariate-stats/slides/02-unconstrained-ordination/slides.html)

* [Wednesday](https://gavinsimpson.github.io/au-multivariate-stats/slides/03-constrained-ordination/slides.html)

* [Thursday](https://gavinsimpson.github.io/au-multivariate-stats/slides/04-permutation-tests/slides.html)

* [Friday](https://gavinsimpson.github.io/au-multivariate-stats/slides/05-other-stuff/slides.html)

### Computing

* [Monday](https://gavinsimpson.github.io/au-multivariate-stats/computing/01-cluster-analysis/cluster-analysis.html)

* [Tuesday](https://gavinsimpson.github.io/au-multivariate-stats/computing/02-unconstrained-ordination/unconstrained-ordination.html)

* [Wednesday](https://gavinsimpson.github.io/au-multivariate-stats/computing/03-constrained-ordination/constrained-ordination.html)

* [Thursday](https://gavinsimpson.github.io/au-multivariate-stats/computing/04-permutation-tests/permutation-tests.html)

-->

## Objectives of the course

The course will provide an applied introduction to generalized additive modelling in R for biologists. Most of the statistical methods you are likely to have encountered will have specified fixed functional forms for the relationships between covariates and the response, either implicitly or explicitly. These might be linear effects or involve polynomials, such as x + x2 + x3. Generalized additive models (GAMs) are different; they build upon the generalized linear model by allowing the shapes of the relationships between response and covariates to be learned from the data using splines. Modern GAMs are a general data analysis framework, encompassing many models as special cases, including GLMs and GLMMs, and the variety of splines available to users allows GAMs to be used in surprisingly large situations. In this course we’ll show you how to leverage the power and flexibility of splines to go beyond parametric modelling techniques like GLMs.

## Learning outcomes and competences

After completing the course, participants will

* understand how GAMs work from a practical viewpoint to learn relationships between covariates and response from the data
* be able to fit GAMs in R using the mgcv package
* know the differences between the types of splines and when to use them in your models
* know how to visualise fitted GAMs and to check the assumptions of the model
* know how to test specific hypotheses and estimate quantities of interest using fitted models,
* be able to use the R statistical software and in particular the *mgcv*, *gratia*, and *marginaleffects* packages to fit and analyse generalized additive models.

## Compulsory programme

Active participation in the course including attendance at lectures and completion of computer-based classes and exercises. Completion of short, computer-based assessments testing their understanding of a topic and the practical skills taught. For credit, students must complete a data analysis exercise to be submitted one week after the end of the course (19th December).

## Course content

The course is based on a series of lectures and computer-based practical classes led by an international expert in generalized additive modelling and who is the author of gratia, an R package for working with GAMs fitted using the mgcv package. 

The course covers the following topics:

* A recap of generalized linear models for data that are not Gaussian
* Fitting GAMs using mgcv
* Working with penalized splines to estimate flexible effects of covariates
* Model diagnostics and assessment
* Estimating marginal effects and adjusted predictions with GAMs
* Hypothesis testing using GAMs
* Displaying model estimates and reporting results

## Prerequisites

This course is suitable for Phd students (including senior thesis-based masters students) and researchers working with biological data who want to fit models that allow for nonlinear relationships (effects) of covariates on responses.  The course will be of particular interest to PhD candidates and researchers in inter alia biology, animal science, ecology, agriculture, and environmental science. Some prior knowledge of R is required, and some prior knowledge of generalized linear modelling in R would be an advantage.

<!-- ## Computing requirements

Participants need to bring their own laptop with the latest version of R installed (version 4.4.0 or later), as well as the current version of RStudio. If you use another editor for your R code feel free to use it instead of Rstudio, but we cannot help you if you encounter problems with it.

You can download R from [cloud.r-project.org](https://cloud.r-project.org/) and select from the three links at the top of the page as required for your operating system.

You can download RStudio from [www.rstudio.com](https://www.rstudio.com/products/rstudio/download/#download) and choose from the list of **installers** as appropriate for your operating system.

If you have already installed R and RStudio, please check that they are both up-to-date. Within R you can run:

```r
version
```

and look at the entry next to `version.string`:

```
r$> version                                                                     
               _                           
platform       x86_64-pc-linux-gnu         
arch           x86_64                      
os             linux-gnu                   
system         x86_64, linux-gnu           
status                                     
major          4                           
minor          2.1                         
year           2022                        
month          06                          
day            23                          
svn rev        82513                       
language       R                           
version.string R version 4.2.1 (2022-06-23)
nickname       Funny-Looking Kid
```

This should include `4.4.x` if you are running the latest release, but should be no lower than `4.2.0`. If the installed version of R is < 4.4.0, install a newver version of R by downloading and running one of the installers from [cloud.r-project.org](https://cloud.r-project.org/) as mentioned above.

To check that RStudio is up-to-date, open RStudio, open the Help menu, and choose *Check for Updates*. RStudio will then check to see if there is a newer version available and if there is it will give you the option to download the newer version.

Prior to arriving at AU Viborg on the 19th of September, make sure you have updated your installed R packages and that you have installed the following packages: tidyverse, vegan, mvabund, boral, ecoCopula, and cocorresp. To do this, open RStudio (or R) and in the console window (usually lower left, with a prompt that looks like `>`) run

```r
parallel::detectCores(logical = FALSE)
```

This checks to see how many CPU cores you have available, which we use in the next chunk. 

```r
update.packages(ask = FALSE, checkBuilt = TRUE, Ncpus = 4)
```

Change the value of `Ncpus` to the number cores you have on your computer as this will speed up package updates if you have many packages installed that require updating. If you want to work while this is being done, set `Ncpus` to a number less than that returned by `parallel::detectCores(logical = FALSE)`.

Now we can install the required packages

```r
install.packages(c("tidyverse", "vegan"))
```

-->
