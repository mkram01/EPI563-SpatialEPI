# (PART) Appendices {-}


# Tips for reproducibility in `R`

## Additional Resources {-}

* [R Markdown Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/rmarkdown.pdf)
* [Comprehensive guide to using R Markdown](https://bookdown.org/yihui/rmarkdown/) 
  + [Chapter within the R Markdown guide specific to Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html)
* [Epidemiologist R Handbook - Working with projects](https://epirhandbook.com/r-projects.html)
* [Epidemiologist R Handbook - R markdown](https://epirhandbook.com/reports-with-r-markdown.html#r-markdown-components)
* [Working with *Projects* in `R`](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects)
* [R for Data Science - Workflow Projects](https://r4ds.had.co.nz/workflow-projects.html)


## The benefits of code reproducibility {-}

*Reproducibility* refers to the capacity for any process you create to be fully and independently replicable either by yourself in the future or by another person. Non-reproducibility of scientific findings has been cited as a leading problem and some of the problem comes from the *ad-hoc* and thus non-reproducible conduct of data preparation and analysis.

Spatial epidemiology requires intensive data preparation, cleaning, and management, and often complex sequence of analytic steps.  In other words it would be difficult for another analyst or a future version of yourself to repeat the process in exactly the same way unless there is a perfect record of what was done.  For this reason, reproducibility of analysis is emphasized and required in this course.

For an analysis to be reproducible you be sure that all data stays paired with all code, and that all (or as many as possible) steps that change or manipulate data are written in your scripts rather than done 'by hand' (e.g. in Excel or some other editor).

## Workflows to enhance reproducibility {-}

Because `R` and RStudio are often used for data preparation, analysis, and reporting, the fundamental importance of *reproducibility* (making analytic processes transparent, interpretable and repeatable) is built-in through many features.  This Appendix introduces several strategies that are important for reproducibility broadly, and also important for the work you do in this course. 

First, there is a brief introduction to *projects* in RStudio, and then there is a slightly more in-depth description of a specific file format, `rmarkdown` and how it can be used to create Notebooks.

### Using Projects in `R` {-}

A **project** in `R` organizes your work much as you might use *folders* on your computer to sort and separate into some logical scheme. In other words, it is a place where you put multiple documents or files that are related to one another. 

For instance, you might choose to have a single project for each week of this class, and perhaps a separate project for each assignment. In each *project directory* (folder) you could store the data, the scripts or code, and any outputs (e.g. saved maps or other saved objects) that are specific to that week or assignment.

The advantage of creating a formal *project* in RStudio (rather than just a regular folder, for example), is that RStudio projects have certain benefits for your coding workflow. 

* When you open a project, the *working directory* (e.g. the root directory or file path where `R` looks for files when you import) is automatically set to be inside the project folder. This means that if you keep your data inside the project, you will never have to worry about broken links or incorrect file paths that occur because data was moved.
* Projects remember environmental settings in RStudio, so you may customize something to a specific project and that will be remembered each time you open the project.
* If you ever work with a version control system such as Github, projects are the natural strategy to contain a repository

:::{rmd-caution data-latex="{caution}"}
**You should avoid using `setwd()` in `R`**!  That function changes the *working directory* and you may have been taught to do this to make it easier. This is bad because whatever pathname you put inside the `setwd()` will amost never work on another computer. That means your code is fragile and specific to your computer, and probably to your computer at only a specific point in time.

If you find yourself relying on `setwd()` or any other strategy to *hard code* file pathnames, please consider learning about projects.  They help make code *less fragile* and *more robust* for sharing and reproducing.

:::

**To create a new project**:

1.Look in the upper-right corner of RStudio for the blue-ish R symbol that will likely say '*Project*'. Click the pull-down menu and select New Project
2. You will see the Project Wizard open with three options:
  + If you have not yet created the folder on your computer that will be your project, choose *New Directory*
  + If you already have a folder (e.g. perhaps it is named 'Week1'), choose *Existing Directory*
  + If you are are forking or checking out a repository from Github, GitLab or other system, choose *Version Control*
3. Navigate to the location you want your *new folder* to be, or else the location where you *existing folder* already is
4. Name the project and click Create Project


Once the project is created, you can navigate via your finder to that folder. You will notice a new file with extension `.Rproj`. If you double-click this file, your project will open, including whatever files and settings you have already worked on.

:::{.rmdtip data-latex="{tip}"}
Get in the habit of opening `R` by double-clicking on the `xxx.Rproj` icon in your project folder.  Doing this makes sure that the working directory is set and helps you maintain *relative* rather than *absolute* file pathnames within your project folder.
:::


## Organizing projects

Some projects or analyses are simple and perhaps only involve a single script document and use built-in data.  But most projects are more complex than that, involving dataset(s), one or more files with code scripts, possibly output including datasets as well as images saved from figures, and markdown files or reports.  It is good practice to have a standard strategy for organizing these.

### Make scripts that do discrete tasks

You may be used to having one file with hundreds or even thousands of lines of code to do every part of an analysis. This isn't inherently wrong, but it can make it difficult to find the particular snippets of code where you defined a recoded variable, or carried out descriptive analyses.  For larger projects, consider creating separate scripts for discrete steps. If you do have many different `R` scripts in a given project, consider storing them in a sub-folder perhaps labeled `code/`.  You might break your work down into separate scripts like this:

1. A script for data preparation. This allows you to quickly return to the process of retrieving and preparing your data to make changes.
2. Scripts for descriptive analysis. You may want to revisit your descriptives in the future and having them separate makes that easier.
3. Scripts (one or more) for more complex analyses including modeling, figure preparation, or simulation.

Each script should have an informative name such as `project-x-data-prep.R` or `project-x-create-final-maps.R`.

### Always store data with code and output

If you are creating maps, the raw (and possibly post-processed, or intermediate) data that supports those maps should be stored **inside your project folder**.  This is the only way to guarantee that you can return in a year and recreate the map exactly. If you have multiple data files, you might consider putting this content in a sub-folder, possibly labeled `data/`.

### Maintain all output files (figures, cleaned datasets, etc)

Just as you want to store code and data together, you should also plan to store all output content in the main project folder or possibly in one or more sub-folders (e.g. `images/` or `reports/`). There are several kinds of outputs that might be generated including:

* Images or figures
* Maps
* Cleaned or prepared datasets (either stored as `.xlsx` or `.csv` or possibly stored in `R` binary format such as `.rds`)
* Reports (e.g. rendered from R-markdown either as `html` or `pdf`)

## Use the `here` package to maintain robust relative pathnames

There are many reasons to keep your work organized, but one is to maintain a known and constant relationship between where data and code are stored.  As discussed above, the use of `setwd()` creates a rigid or *absolute* pointer to where a file (e.g. your data might be at `C:\MyDocuments\EPI563\Week1`) are stored. But if you changed computers or changed your file structure on your current computer, that *absolute* path would likely fail making the code non-reproducible (your code could not *find* you data)!

Instead, please try to preference *relative* pathnames. That is a way of describing where something is *relative to* a given starting point. In the case of projects in R-studio, that starting point is always the folder containing the project. Thus, the location of a dataset stored in a sub-folder called *data* is: `data/mydataset.xlsx`; it is assumed that the folder `data` is a sub-folder of the parent or project folder.  As long as you keep your project as a self-contained folder (e.g. copy/paste it as a folder or share it as a folder with all contents), this *relative* location will be robust.

The `here` package was developed to try to make some of this a bit easier. The package named `here` also has a function named `here()` (I know it feels a bit repetitive!). The function, `here()` serves to describe the hierarchical nesting of folders that locates the file or location you desire (e.g. where to import a dataset from or where to save a figure to). This is some examples of how to use `here()`:

* __Importing data__: `mydata <- read.csv(here('data', 'wave1', 'wave1_data.csv))`.  In this code, we create a new object (named `mydata`) that results from using the function `read.csv()`.  The data is located *within the project folder* at this relative path location: `data/wave1/wave1_data.csv`.
* __Saving output__: `ggsave(here('figures', 'figure1.png'))`.  In this code, we save the `ggplot()` figure to our computer at this location within the overall project folder: `figures/figure1.png`. 


:::{.rmdcaution data-latex="{caution}"}
**Caution**: If you work in a Windows OS environment, be careful how you designate file pathnames.  `R` uses notation that is similar to *Unix OS*, and also the one adopted by Mac OS, which is to define a set of nested folders with a *forward slash* as in: `H:/mkram02/gis-file` .  Unfortunately that is *the opposite* of how Windows describes pathnames (e.g. in Windows the above would use *back slash* like this: `H:\mkram02\gis-file`). Using the `here` packages avoids this confusion.
:::


### Specify a relative location outside the working directory {-}

What if you have one folder for this entire course, and inside it you have a separate project directory for each week. If you are working on the project for `Week2`, you might wish to load a file that you saved previously in `Week1`. In other words it is not a sub-folder, but is actually *outside* of the current directory. You could use the `setwd()` function to change the location, but that creates a possibly fragile *absolute pathname* and can be dangerous. Instead you could create a more robust *relative pathname* by referring to the other file in relation to your current location.

Using two dots in a pathname tells `R` to **go up a level** in the directory. So to if the `georgia.csv` file I referred to above were in your `Week1` directory, but your are currently woring in `Week2` you could do this:


```r
dd <- read.csv('../data/death-data/georgia.csv')
```

This means "*go up a level, then look in the data folder, then the death-data folder, then load the georgia.csv file*".  If you need to go up two (or more) levels, simply repeat:  `../../data/death-data.georgia.csv`

## Why `R Notebooks`? {-}

For most assignments in this course, at least a portion of the deliverable will be a fully-functional, annotated `R Notebook`.  These *notebooks* are actually a specific case of `rmarkdown` which itself is a format for creating reproducible documents with interspersed `R` code, analytic results and text. For example this eBook, and many other resources in this course are created using `rmarkdown` or related packages such as `bookdown`. 

But as I said, `R Notebooks` are a specific instance or case of markdown that is incorporated into R Studio and has some nice features for the applied data analyst.

* Notebooks allow you to type text that explains what is happening, interpret findings, or note areas in need of further exploration. This is similar to the usual *commenting* you might be familiar with, but makes it easy to be more narrative or expansive in comments.
* Notebooks contain functional `R` code interspersed with the narrative comments, so that code, comments *and output or results* can all be seen in one continuous way.
* Notebooks work in an *interactive* mode. This means that as you are coding and working you can see the results in the document. When you save the Notebook the text, the code **and the results** are saved! 

So the reason for using Notebooks is that they provide a means for clear annotation and documentation combined with ready reproducibility. Reproducibility means that someone else (or a future you!) could come back and get the same result again.

To benefit from the advantages above, I recommend you gain familiarity with the basic (and perhaps the optional) formatting described below. I also recommend you develop a knack for rich annotation and documentation, not just brief (often cryptic) comments that we are all used to writing in SAS and other code! Document what you **plan to do**. Document what you **did**.  Document what the **results means**. Document what else **needs to be done**.

:::{.rmdtip data-latex = "{tip}"}
R Notebooks are very handy and serve like '*lab notebooks*' documenting your thinking as you go. They are great for reports you want to share with others (or your future self). But it is still ok to use regular R-scripts for analyses that do not require extensive documentation. For example writing functions or data-cleaning scripts may be more appropriate in simple scripts that have the extension `my_code.R` rather than `my_code.Rmd` (e.g. the notebook markdown).
:::

## What you need to know {-}

This file summarizes both **important** and just a small handful of **optional** functions for effectively using `R` Notebooks. The **important** functions are those necessary to effectively intersperse narrative text and description communicating what you did and what it means, with clear R code and the resulting output.  The **optional** parts are about some simple formatting tools. These **are not** necessary for your homework (our goal is documentation of analytic process not being 'pretty'), but you may find them useful.

See these

## Important R Notebook functions {-}

### The YAML {-}

```
---
title: "Title of your notebook"
author: "Your Name Here"
date: "Submission date here"
output:
  html_notebook:
    number_sections: yes
    toc: yes
    toc_float: yes
---
```


When you create a new `R` Notebook or `R` Markdown file from within R Studio (e.g. via *File > New File > R Notebook*), a 'YAML' will automatically be created at the top of the script delineated by three dash lines `---`.  *YAML* stands for "*yet another markup language*" and it is a set of instructions about how the finished notebook will look and be structured. You can accept the default YAML structure (of course modifying the title) or copy/paste the YAML from the top of this script. You can also read more online about additional customizations to the YAML, but none are necessary for this course. 

However, the `YAML` can be tricky sometimes. Here are a few general tips:

* Keywords (e.g. `title`, `date` or `output`) end with a colon and what comes after is the '*argument*' or '*setting*' for that keyword.  
* When the '*argument*' or '*setting*' for a keyword takes up multiple lines, you can hit *<Return>*, as is the case above with `output:`.
  + However, note that sub-arguments (e.g. `html_notebook:`) to a parent must be indented by 2 spaces.
  + Further sub-arguments (e.g. `number_sections: yes` which is a specific setting for `html_notebook:`) must be indented an additional 2 spaces. The indentations represent organization to connect multiple settings to the correct parent keyword.

## Typing text {-}

The utility of `R` Notebooks is the ability to more completely document your thinking and your process as you carry out analyses. It is not necessary to be wordy just for the sake of taking up space, but this is an opportunity to clearly delineate goals, steps, data sources, interpretations, etc.  

You can just start typing text in the script to serve this purpose. Some text formatting functions are summarized later in this document, and in [Cheat sheets](https://github.com/rstudio/cheatsheets/raw/master/rmarkdown.pdf) and online resources linked to elsewhere.



## Adding `R` Code {-}

`R` Notebooks let you write `R` code within your Markdown file, and then run that code, seeing the results appear right under the code (rather than only in the Console, where they usually appear). 

There are 2 ways to add a new chunk of R code:

1. Click the green `C-Insert` button at the top of the editor panel in `R` Studio. The top option is for `R` code.  
2. Use a keyboard short cut: 
    + *Mac*  Command + Shift + I
    + *Windows* Ctrl + Alt + I
    
Notice these `R` code chunks are delineated by three back-ticks (sort of like apostrophes)...these back-ticks are typically on the same key as the tilde (~) on the upper left of most keyboards. The space between the sets of 3 back-ticks is where the `R` code goes and this is called a *code chunk*.

:::{.rmdnote data-latex="{note}"}
You will see the syntax color change for things you type *inside* an `R` chunk (e.g. delineated by ` ``` `), versus *outside*.  Everything *inside* follows the syntax rules of `R`. Everything *outside* will be printed in the final report, but will not be run as `R` code.
:::

When you want to run the code inside the code chunks, you can either:

1. Place your cursor on a line and click *Ctrl+enter* (Windows) or *CMD+Return* (Mac), or you can click the *Run* button at the top of the editor pane in R Studio. 
2. To run all of the code within a chunk click the green *Run Current Chunk* button at the upper-right of the code chunk. 

Below is some code and the corresponding results.



```r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```



```r
plot(cars)
```

![](80-reproducibility_files/figure-latex/unnamed-chunk-3-1.pdf)<!-- --> 


In this way you can iterate through your analytic process...switching between running code, viewing output, documenting in free text.

If you want to see what your current work-in-progress looks like in HTML, you can click the *Preview* button at the top of the panel. This will both save your document, and open the *Viewer* panel.


## Making tables {-}

While not required, you may want to summarize data in a table in `R` Markdown. There are packages devoted to creating tables, but you can create a quick-and-dirty table just using keyboard symbols.  

1. First start by making a header row. Separate each column name with a *'pipe'* symbol, `|`
2. Put a continuous line of dashes (`-----`) under each column name, separating columns with pipe symbol (`|`)
3. Now type text corresponding to each row and column. Separate columns with pipe (`|`) and separate rows by carriage return/Enter

So the following text typed directly into the Markdown file (e.g. not inside a code chunk):

```
Column 1  | Column 2 | Column 3
----------|----------|-----------
Text 1    | Text 2   | Text 3
Next line | Next line 2 | Next line 3
```

Will produce the following output:

Column 1  | Column 2 | Column 3
----------|----------|-----------
Text 1    | Text 2   | Text 3
Next line | Next line 2 | Next line 3

## Workflow {-}

The benefit of Notebooks (slightly different from regular Markdown) is that you can work interactively with your code, seeing results immediately just as you would with a regular script. In contrast a 'regular' Markdown file doesn't run the code until you click 'Knit'.

**Here is what I recommend for workflow**:

1. Click *File>New File>R Notebook* to create a new file. Edit the `YAML` (the stuff at the top) to have the correct title, author, etc.  The template that is created has some example code. **Delete this generic code** that is under the `YAML`. Save the file to your project folder.
2. Use the space *under* the `YAML` to type the objective or purpose of this analysis, and any introduction or background that is useful. 
3. Carry out your analysis, inserting code chunks, running them, and documenting them with free text as you go.  
  + If you wish, you can see how the results look in HTML by clicking the *Preview* button.
4.  Sometimes we go back and re-run code in a different order, or else delete some code without re-running the entire script. This means the code is *not reproducible* because some objects you created no longer have code to support them. As a final check of *reproducibility* (the assurance that your code is self-contained and not dependent on steps you did outside the script) I recommend you always end by clicking the *RUN* button at the top of the panel. Specifically, choose **Restart R and Run all Chunks**.  After it runs be sure to *look at the results*!  This step erases all data objects in memory and starts running your script from the top. If there is an error when you do this, then something is missing in your code. Try to figure it out and make changes so that you have code in your script that does everything you expect.

## Optional functions {-}

The list of formatting functions is long. I include only a couple I find useful (but not mandatory) here:

## Customizing your YAML {-}

While the default YAML is perfectly fine, the YAML at the top of this script includes a few added functions including:  

1. Specify a table of contents - this only works if you use headers
2. Specify section numbering
3. Specify that the table of contents should be 'floating' which means that in *html* it is visible even when you scroll. For PDF rendering, 'float' is not an option. 


## Simple formatting of your Notebook {-}

It is generally helpful to organize a document by using headers to separate tasks or steps in your code. You can easily create headers using the hashtag/pound sign `#`. Specifically...

* `#` at the beginning of the line denotes a top-level (level-1) header that will be large and bold.
* `##` at the beginning of the line denotes level-2 header
* `###` unsurprisingly is a level-3 header!
* Make sure there is a space between the `#` and the text
* Always leave a blank line (return/enter) between the header text and the '*regular*' text.

You can also make numbered or bulleted lists if that is helpful.  A line that begins with either an asterisk (`*`) or a number will begin a bulleted or numbered list.

Headers are populated into the table of contents, if specified.

## Text formatting {-}

The [`R` Markdown Cheatsheets](https://github.com/rstudio/cheatsheets/raw/master/rmarkdown.pdf) have lots of examples of formatting. Three things that I use more frequently are bold, italics, and numbered or bulleted lists.  

Key stroke            | Result
------------          | -------
```*italics*```       | *italics*
```**bold**```        | **bold**


1. Numbered lists start with number, and each line must end with 2 space (or have blank line between).
2. Instead of numbers you can use letters

* Bulleted lists can be initiated with an asterisk or +, and also must have 2 spaces (or blank carriage return) at end of each item.


## Final Note {-}

Remember that a final step when you think you are done with a project, is to Click `Restart R and Run all Chunks`, and then save/preview the Notebook **after** doing this to be sure it is what you expect. 


