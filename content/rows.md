---
layout: default  
title: Manipulating Rows
nav_order: 5  
parent: Workshop Content  
has_toc: false  
---

# 2 Manipulating Rows

| Select rows | `filter()`, `distinct()`, `slice()` 
| Arrange rows | `arrange()`
| Add rows | `add_row()`, `bind_rows()`

Please copy the following code and paste them into a script in the RStudio. We will walk through them with the visual explanations from the dplyr cheat sheet.

Input
{: .label .label-green}
```r
library(tidyverse)
?mtcars
mtcars
```

```

## 2.1 Filter rows with `filter()`
Goal: Keep only cars with fuel efficiency above 20 mpg.

over20 <- mtcars %>%
  filter(mpg > 20)
over20
```

What changed: You now have a smaller data frame that keeps only rows matching the condition.

Mini practice: Change the threshold to `mpg > 25`. How many rows remain?

## 2.2 Keep unique rows with `distinct()`
Goal: See unique values for a row-level grouping variable.

Input
{: .label .label-green}
```r
distinctmt <- mtcars %>%
  distinct(gear)
distinctmt
```

What changed: Duplicate `gear` values are removed, so each value appears once.

Mini practice: Try `distinct(cyl)` and compare the result with `distinct(gear)`.

## 2.3 Pick specific rows with `slice()` and helpers
Goal: Select rows by row position.

Input
{: .label .label-green}
```r
slicemt <- mtcars %>%
  slice(10:15)
headmt <- mtcars %>%
  slice_head(n = 5)
tailmt <- mtcars %>%
  slice_tail(n = 5)

slicemt
headmt
tailmt
```

What changed: Rows are selected by position, not by a logical condition.

Mini practice: Use `slice(1:3)` and compare it with `slice_head(n = 3)`.

## 2.4 Reorder rows with `arrange()`
Goal: Sort rows by one variable.

Input
{: .label .label-green}
```r
arrmt <- mtcars %>%
  arrange(mpg)
descmt <- mtcars %>%
  arrange(desc(mpg))

arrmt
descmt
```

What changed: The same rows are kept, but their order changes.

Mini practice: Sort by `wt` in ascending and descending order.

## 2.5 Add rows with `add_row()` and `bind_rows()`
Goal: Add one row manually and combine multiple data frames by rows.

Input
{: .label .label-green}
```r
# add one row to an existing data frame
x <- data.frame(
  A = c("a", "b"),
  B = c("t", "u"),
  C = c(1, 2)
)

x_plus <- x %>%
  add_row(A = "z", B = "q", C = 99)
x_plus

# combine data frames with overlapping columns
y <- data.frame(
  A = c("c", "v"),
  B = c("d", "w"),
  D = c(TRUE, FALSE)
)

bind_rows(x, y)
```

What changed: `add_row()` appends one row; `bind_rows()` stacks data frames and fills missing columns with `NA`.

Mini practice: Add one more row to `x_plus` with your own values.

## Practice 1
`iris` is a data frame with 150 cases (rows) and 5 variables (columns) such as `Petal.Width` and `Species`. In the `iris` data set, the cases with the minimum and maximum petal width belong to what species?
<details>
	<summary><u>Click here for solutions</u></summary>
	<div style="border: thin grey 1px; background-color: #eeebee; padding:15px;">
		<p>
		# solution 1 <br>
		arrange(iris, Petal.Width) <br>
		
		# solution 2 <br>
		slice_min(iris, Petal.Width) <br>
		slice_max(iris, Petal.Width) <br>
		
		 <br>
		# The case with the minimum petal width belongs to setosa. <br>
		# The case with the maximum petal width belongs to virginica.
		</p>
    </div>
</details>
&nbsp;    
&nbsp;  
