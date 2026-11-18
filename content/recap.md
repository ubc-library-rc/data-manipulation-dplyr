---
layout: default
title: Recap
nav_order: 4
parent: Workshop Content
has_toc: false
---


# **4. Recap**

## Putting it all together

Our question was: **Who are Canada's most dedicated volunteers?**

We can answer it with one pipeline that uses functions from both the rows and columns sections:

```r
top_10 <- sgvp |>
  filter(volunteer == "Volunteer") |>                # keep volunteers
  mutate(hours_per_week = volunteer_hours / 52) |>   # add hours per week
  slice_max(hours_per_week, n = 10) |>               # keep the top 10
  select(province, age_group, gender, hours_per_week) |>  # keep key columns
  rename(weekly_hours = hours_per_week)              # tidy the name
```

Look at `top_10`. What do the most dedicated volunteers have in common?

<div markdown="1" style="border-left: 5px solid #7253ed; background-color: #f5f2ff; padding: 10px 20px; margin: 25px 0;">
**Practice**

Change the pipeline to find the 10 people who donated the most. Show their province, age group, gender, and how much they donated per month.

<details>
<summary><u>Click here for solution</u></summary>
<pre>
top_donors <- sgvp |>
  filter(donor == "Giver") |>
  mutate(monthly_donation = donation_amount / 12) |>
  slice_max(monthly_donation, n = 10) |>
  select(province, age_group, gender, monthly_donation)
</pre>
</details>
</div>

## This workshop covered:

**Manipulating rows**
* `filter()`: keep rows that meet a condition
* `distinct()`: see the unique values in a column
* `slice()`, `slice_max()`: pick rows by position or by the largest values
* `arrange()`: sort rows
* `bind_rows()`: stack data frames on top of each other

**Manipulating columns**
* `select()`, `pull()`: keep columns, or take one out as a vector
* `relocate()`: change the order of columns
* `rename()`: change column names
* `mutate()`, `transmute()`: add new columns, including with `if_else()` and `case_when()`

And how to combine multiple manipulations with the pipe `|>`.

Now you are equipped to do basic data manipulation tasks in R with *dplyr*.  

## Topics for further learning:
* summarising data with `group_by()` and `summarise()`, and combining tables with joins (see the bonus sections in the R script),
* the comparison of the functions from *dplyr* package and similar functions from the base R package, such as some shown in [STAT 545](https://stat545.com/dplyr-intro.html#use-filter-to-subset-data-row-wise:~:text=Compare%20with%20some%20base%20R%20code%20to%20accomplish%20the%20same%20things%3A),
* optional arguments in each function that help control certain features,
* various kinds of functions to use with `mutate()` and `summarise()`, such as some shown in the [*dplyr* Cheat Sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf),
* manipulate multiple variables at once, such as some shown in the *dplyr* Cheat Sheet.


Practice and use additional resources to build your skill to the next level. You can also attend other workshops or book a consultation with the research commons.

## Resources
* [Workshops](https://researchcommons.library.ubc.ca/events/)
* [Book a consultation](https://libcal.library.ubc.ca/appointments/research_commons)
* [vignette("dplyr")](https://dplyr.tidyverse.org/articles/dplyr.html)
* [Chapter 4 **Data transformation** in the book **R for Data Science (2e)** by Hadley Wickham, Mine Çetinkaya-Rundel and Garrett Grolemund](https://r4ds.hadley.nz/data-transform.html)
* [Chapter 6 **Introduction to *dplyr*** in the textbook for **STAT 545** by Jenny Bryan and The STAT 545 TAs](https://stat545.com/dplyr-intro.html)
* [UBC Library workshop: Relational data in R](https://ubc-library-rc.github.io/relational-data-r/) (for more on joins)