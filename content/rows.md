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
# make sure you loaded the tidyverse library
library(tidyverse)

# Get to know the data
?mtcars
mtcars

# Sample code from the dplyr cheat sheet
## 2.1 Select cases
over20=filter(mtcars, mpg > 20)
distinctmt=distinct(mtcars, gear)
slicemt=slice(mtcars, 10:15)
headmt=slice_head(mtcars, n = 5)
tailmt=slice_tail(mtcars, n = 5)

## 2.2 Arrange observations
arrmt=arrange(mtcars, mpg)
descmt=arrange(mtcars, desc(mpg))

## 2.3 Make dataframes and bind them together
### A showcase for bind_rows
x <- data.frame(
  A = c('a', 'b'), 
  B = c('t', 'u'),
  C = c(1, 2))
x
y <- data.frame(
  A = c('c', 'v'), 
  B = c('d', 'w'),
  D = c(TRUE, FALSE))
y
bind_rows(x, y)
```

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
