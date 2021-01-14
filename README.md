# IS507, Spring 2021 (taught online, synchronously; 3 hrs/class)

**NOTE: check each week to see if its IN-DEV or READY for each week**

These are the course materials for IS507 (previously IS542) at the iSchool, University of Illinois, Urbana-Champaign.  

If you see any bugs or errors please issue a PR -- always looking to make things better!


## How to use this repo

Each week consists of lecture slides and prep-notebooks in the programming language R along with suggested resources and readings.  The readings consist of what was "required" for the course as well as optional extra readings so feel free to take/leave what you'd like.

Below is the outline of the course, with links to the individual folders for each week.  Each folder contains:
 1. an "README.md" file which lists the suggested readings, datasets and any extra resources for the week
 1. The lecture slides (as a pdf)
 1. Prep coding notebooks used for the "live coding" portions of class which generally happened after the lecture portion (.ipynb files) **BUT** sometimes we swtich between the lecture slides & R.  This will be denoted in the slides as well as R.
 1. Any datasets used in the coding portion
 

## Course Outline

Example [syllabus here](syllabus.md).

| Week Link  | Topic |
|---|---|
| [Week 01](week01) | Course Intro & Motivation, Intro to R |
| [Week 02](week02) | Intro to Numerical Data, Intro to R |
| [Week 03](week03) | Intro to Categorical Data, Table Proportions, and Probability Theory |
| [Week 04](week04) | Random Variables, Continous Probability Distributions |
| [Week 05](week05) | The Normal Distribution |
| [Week 06](week06) | The Normal & Binomial Distributions |
| [Week 07](week07) | Foundations for Inference |
| [Week 08](week08) | Hypothesis testing: Normal, T-distribution, and single proportions; <br> differences of 2 means/proportions, paired data; ANOVA and <img src="https://render.githubusercontent.com/render/math?math=\chi^2"> models |
| [Week 09](week09) | Fake Break!  We'll do some fun stats stuff in Python.  |
| [Week 10](week10) | Linear Regression & Multiple Linear Regression |
| [Week 11](week11) | Intro to classification & Logistic Regression |
| [Week 12](week12) | Classification with KNN & Beginning Model Selection with CV & Bootstrapping |
| [Week 13](week13) | Model Selection & Shrinkage Methods for Linear Regression |
| [Week 14](week14) | Lasso Regression & CV; Intro to PCA; Course wrap-up |


## Reading

This course is based off of the following textbooks:

#### Required
   * [OIS]: OpenIntro Statistics, **4th Edition** which can be found on [amazon](https://www.amazon.com/OpenIntro-Statistics-Fourth-David-Diez/dp/1943450072) or in [free pdf form -- make sure you select "The Book" for free version](https://leanpub.com/openintro-statistics). 
   * [ITR] An Introduction to R, available as a [pdf](https://cran.r-project.org/doc/manuals/R-intro.pdf).
   * [ISL] An Introduction to Statistical Learning, click on the `Download the PDF` link [here](http://faculty.marshall.usc.edu/gareth-james/ISL/).
   
#### Optional
   * [MIS] [Intermediate Statistics with R](https://scholarworks.montana.edu/xmlui/handle/1/2999) ([pdf link](https://scholarworks.montana.edu/xmlui/bitstream/handle/1/2999/Greenwood_Book_2.1.pdf?sequence=9&isAllowed=y))
   * [STOR390] [STOR 390: Introduction to Data Science](https://idc9.github.io/stor390/) course page.


## Installation of R, RStudio and Jupyter notebooks

 1. Download R from the [R-project webpage](https://www.r-project.org/)
 1. Courses were taught using RStudio which you can [download right here](https://rstudio.com/)
 
**Totally optional:** To run the Jupyter notebooks with R locally, install [Anaconda](https://www.anaconda.com/distribution/) and then please follow the [instructions for installing R using the Anaconda Navigator](https://docs.anaconda.com/anaconda/navigator/tutorials/r-lang/).  The easiest way to install packages is through the Anaconda GUI, or you can conda install -- either way you [need to append an `r-` to all packages!](https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/)
 
 **NOTE:** There are pay-versions of this software but we assume you are using the free versions.
 
## [References](references.md)

## TODO

 * Add in a "who this course is for" section -- describe your typical iSchool student
 * Add in photos of RStudio & label panels
 * Link to Data ag install list?
 * Add in pedagogy links and general references
 * Add in "working on" as far as online teaching strategies -- what is currently working and is not
 * add in course pre-reqs
 * add in slides with lecture notes
 * collapse answers to practice problems
 * Add in instructor notes for all weeks pages
 
**Weeks**
 * Week 02
    * A-void notebook
 * Week 03
    * Add in extra GLM stuff, corrplot, links to datacamp
 * Week 10
    * **ERROR:** the `tabplot` library won't load in jupyter notebooks
 * Week 15
    * add in-person "real life" example using the motion data and KNN
 * Week 16
    * prep notebook for PCA isn't included as of now
	
**Stretch Goals**
 * include bayesian stuffs as a bonus class


### Disclaimer

My background is in astrophysics (hydro simulations) so there will be an abundance of astronomy examples and space jokes.  Also my spelling is atrocious. You have been warned.
