---
layout: default
title: Outline
nav_order: 1
---

# Welcome to Data Manipulation with *dplyr*

Data manipulation is a crucial part of data visualization and analysis. This workshop introduces common functions in the *dplyr* package to manipulate rows and columns.  
See the UBC library Research Commons [event calendar](https://researchcommons.library.ubc.ca/events/) for related workshops on various topics.  

In this workshop we will use data from Statistics Canada's 2023 Survey on Giving, Volunteering and Participating to answer the question: **Who are Canada's most dedicated volunteers?**

## Before the workshop

This workshop assumes a basic understanding of the R language, but all learners are welcome to participate.

To get ready:

1. Install the latest versions of R and RStudio:
   - R: [https://cran.rstudio.com/](https://cran.rstudio.com/)
   - RStudio: [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)
2. Download these two files and save them in the **same** folder:
   - <a href="{{ '/files/sgvp_2023_workshop.csv' | relative_url }}" download>Download the data (sgvp_2023_workshop.csv)</a>
   - <a href="{{ '/files/Data_Manipulation_Script.R' | relative_url }}" download>Download the R script (Data_Manipulation_Script.R)</a>
3. Open the R script in RStudio and go to **Session > Set Working Directory > To Source File Location**.


> **Note:** Data is adapted from Statistics Canada, Survey on Giving, Volunteering and Participating Public Use Microdata File, 2023. This does not constitute an endorsement by Statistics Canada of this product.


## Learning objectives

At the end of this workshop, you will be able to:
1. Understand what the *dplyr* package is used for
2. Use the pipe operator to combine multiple manipulations together
3. Manipulate rows to filter, select, arrange, and combine cases
4. Manipulate columns to select, arrange, add, and rename variables
5. Combine these steps to answer a research question

## Schedule

| 0:00 - 0:05 | Welcome and using Zoom |
| 0:05 - 0:15 | Intro to *dplyr* and set up |  
| 0:15 - 0:35 | Manipulating rows |
| 0:35 - 0:50 | Manipulating columns |   
| 0:50 - 1:00 | Putting it all together and recap |
| 1:00 - 1:30 | Optional Q&A and bonus content |

## Resources
* [*dplyr* Cheat Sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf)
* [vignette("dplyr")](https://dplyr.tidyverse.org/articles/dplyr.html)
* [Chapter 4 **Data transformation** in the book **R for Data Science (2e)** by Hadley Wickham, Mine Çetinkaya-Rundel and Garrett Grolemund](https://r4ds.hadley.nz/data-transform.html)
* [Chapter 6 **Introduction to *dplyr*** in the textbook for **STAT 545** by Jenny Bryan and The STAT 545 TAs](https://stat545.com/dplyr-intro.html)