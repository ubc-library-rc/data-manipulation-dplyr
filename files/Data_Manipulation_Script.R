#------------------------------------------------------------------------------#
# 
# DATA MANIPULATION WITH DPLYR
#
#------------------------------------------------------------------------------#

# Before you start: save this script and sgvp_2023_workshop.csv in the SAME 
# folder.

# In RStudio go to Session > Set Working Directory > To Source File Location

# This tells R to look for data in the same folder where the script you are 
# writing is saved.

#------------------------------------------------------------------------------#
# (1) SET UP
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# LOAD TIDYVERSE
#------------------------------------------------------------------------------#

if(!require(tidyverse)) # checks if package can be loaded
{ # if not, install and then load
  install.packages("tidyverse") # install package
  library(tidyverse) # load package 
}

#------------------------------------------------------------------------------#
# LOAD DATA
#------------------------------------------------------------------------------#

# We will use the 2023 Survey on Giving, Volunteering and Participating (SGVP) 
# from Statistics Canada. 

#Read in survey data
sgvp <- read_csv("sgvp_2023_workshop.csv")

# This data is tidy! Each variable is in its own column and each observation is 
# in its own row

#------------------------------------------------------------------------------#
# REMINDER: PIPES
#------------------------------------------------------------------------------#

# The pipe |> takes the result on its left and passes it to the function on
# its right. You can read it as "and then".

# Without pipe
sgvp_bc <- select(filter(sgvp, province == "British Columbia"), age_group, gender, volunteer, weight)

# With pipe
sgvp_bc <- sgvp |>
  filter(province == "British Columbia") |>
  select(age_group, gender, volunteer, weight)

#------------------------------------------------------------------------------#
# (2) MANIPULATE ROWS
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# FILTER ROWS
#------------------------------------------------------------------------------#

# filter() keeps the ROWS that meet a condition

# Keep only the people who volunteered
volunteers <- sgvp |>
  filter(volunteer == "Volunteer")

# Conditions can use numbers too.
# Keep people who volunteered more than 500 hours in the past year
dedicated <- sgvp |>
  filter(volunteer_hours > 500)

# Useful comparison operators:
#   ==  equal to                 !=  not equal to
#   >   greater than             <   less than
#   >=  greater than or equal    <=  less than or equal

# Non-volunteers have NA for volunteer_hours. filter() drops any row where
# the condition can't be checked, so they are removed automatically.

# A comma (or &) means AND: both conditions must be true
dedicated_bc <- sgvp |>
  filter(volunteer_hours > 500, province == "British Columbia")

# | means OR: at least one condition must be true
west_coast <- sgvp |>
  filter(province == "British Columbia" | province == "Alberta")

# %in% is a shortcut for several ORs on the same column
prairies <- sgvp |>
  filter(province %in% c("Manitoba", "Saskatchewan", "Alberta"))

# Practice: keep volunteers aged 15 to 24 who volunteered more than
# 200 hours. How many rows are left? 





#------------------------------------------------------------------------------#
# KEEP UNIQUE ROWS
#------------------------------------------------------------------------------#

# distinct() keeps only the unique values of the columns you name.
# It's a quick way to see what categories a column contains.
age_groups <- sgvp |>
  distinct(age_group)

# With more than one column, it keeps each unique COMBINATION
age_gender <- sgvp |>
  distinct(age_group, gender)

# Practice: what education levels are in the data? How many are there?





#------------------------------------------------------------------------------#
# PICK SPECIFIC ROWS
#------------------------------------------------------------------------------#

# slice() keeps rows by their POSITION (row number)
rows_10_15 <- sgvp |>
  slice(10:15)

# slice_max() and slice_min() keep the rows with the largest or smallest values
# The 10 people who volunteered the most hours:
top_volunteers <- sgvp |>
  slice_max(volunteer_hours, n = 10)

# Practice: find the 10 people who donated the most money (donation_amount).





#------------------------------------------------------------------------------#
# REORDER ROWS
#------------------------------------------------------------------------------#

# arrange() sorts rows by a column, smallest to largest
by_hours <- sgvp |>
  arrange(volunteer_hours)

# desc() sorts from largest to smallest. You can also sort by more than one
# column: here by province, then by hours within each province.
by_province_hours <- sgvp |>
  arrange(province, desc(volunteer_hours))

# Practice: sort the data by donation_amount, largest first.





#------------------------------------------------------------------------------#
# COMBINE ROWS
#------------------------------------------------------------------------------#

# bind_rows() stacks data frames on top of each other, matching columns by name
top_bc <- sgvp |>
  filter(province == "British Columbia") |>
  slice_max(volunteer_hours, n = 5)

top_on <- sgvp |>
  filter(province == "Ontario") |>
  slice_max(volunteer_hours, n = 5)

top_bc_on <- bind_rows(top_bc, top_on)

# Practice: add the top 5 volunteers from Quebec to top_bc_on.




#------------------------------------------------------------------------------#
# (3) MANIPULATE COLUMNS
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# SELECT COLUMNS
#------------------------------------------------------------------------------#

# select() keeps the columns you name
hours_data <- sgvp |>
  select(id, province, age_group, gender, volunteer_hours)

# A minus sign removes columns instead
no_donations <- sgvp |>
  select(-donor, -donation_amount)

# pull() takes a single column out as a vector (a list of values) rather than
# a data frame. This is handy when a function needs plain values, like mean().
hours <- sgvp |>
  pull(volunteer_hours)

mean(hours, na.rm = TRUE)

#------------------------------------------------------------------------------#
# REORDER COLUMNS
#------------------------------------------------------------------------------#

# relocate() moves columns. By default it moves them to the front.
hours_first <- sgvp |>
  relocate(volunteer_hours)

# .after (or .before) says where to put them
hours_after_id <- sgvp |>
  relocate(volunteer_hours, .after = id)

#------------------------------------------------------------------------------#
# RENAME COLUMNS
#------------------------------------------------------------------------------#

# rename() changes column names: new name on the left, old name on the right
sgvp_renamed <- sgvp |>
  rename(hours = volunteer_hours)



#------------------------------------------------------------------------------#
# ADD COLUMNS
#------------------------------------------------------------------------------#

# mutate() adds a new column and keeps all the existing ones
# Convert yearly hours to hours per week
sgvp_weekly <- sgvp |>
  mutate(hours_per_week = volunteer_hours / 52)

# transmute() adds new columns and drops everything else
weekly_only <- sgvp |>
  transmute(id, hours_per_week = volunteer_hours / 52)

# Practice: add a column called dedicated that is TRUE for people who
# volunteered more than 500 hours, and FALSE otherwise.






# mutate() works with "vectorized" functions: functions that take a column
# and return one new value for every row. Some useful ones:

# if_else(): one of two values, depending on a condition
sgvp_dedicated <- sgvp |>
  mutate(dedicated = if_else(volunteer_hours > 500, "Dedicated", "Other"))

# case_when(): more than two categories. Conditions are checked in order,
# and each row gets the value of the first condition that is TRUE.
# .default is used for rows where none of the conditions are TRUE.
sgvp_level <- sgvp |>
  mutate(volunteer_level = case_when(
    volunteer_hours > 500  ~ "High",
    volunteer_hours > 100  ~ "Medium",
    volunteer_hours <= 100 ~ "Low",
    .default = "Not a volunteer"
  ))

# between(): TRUE if a value is within a range (including both ends)
sgvp_mid <- sgvp |>
  mutate(mid_range = between(volunteer_hours, 100, 500))

# min_rank(): ranks each row. Use desc() so the most hours gets rank 1.
sgvp_ranked <- sgvp |>
  mutate(hours_rank = min_rank(desc(volunteer_hours)))

# .after (or .before) puts the new column where you want it
sgvp_ranked <- sgvp |>
  mutate(hours_rank = min_rank(desc(volunteer_hours)), .after = id)

#------------------------------------------------------------------------------#
# (4) PUTTING IT ALL TOGETHER
#------------------------------------------------------------------------------#

# Who are Canada's most dedicated volunteers?
# One pipeline, using functions from both sections:

top_10 <- sgvp |>
  filter(volunteer == "Volunteer") |>                # keep volunteers
  mutate(hours_per_week = volunteer_hours / 52) |>   # add hours per week
  slice_max(hours_per_week, n = 10) |>               # keep the top 10
  select(province, age_group, gender, hours_per_week) |>  # keep key columns
  rename(weekly_hours = hours_per_week)              # tidy the name


# Practice: change the pipeline to find the 10 people who donated the most.
# Show their province, age group, gender, and how much they donated per month.





#==============================================================================#
# BONUS: SUMMARISING AND JOINING
# We'll cover these if there's time. Otherwise, try them on your own!
# For more on joins, see the UBC Library workshop "Relational data in R"
#==============================================================================#

#------------------------------------------------------------------------------#
# (5) SUMMARISE
#------------------------------------------------------------------------------#

# summarise() collapses many rows into a single row of summary values
# Average and median hours among volunteers
hours_summary <- sgvp |>
  filter(volunteer == "Volunteer") |>
  summarise(
    mean_hours   = mean(volunteer_hours),
    median_hours = median(volunteer_hours)
  )

# group_by() calculates the summary separately for each group
hours_by_province <- sgvp |>
  filter(volunteer == "Volunteer") |>
  group_by(province) |>
  summarise(median_hours = median(volunteer_hours))

# count() counts the rows in each group
# How many dedicated volunteers (more than 500 hours) in each province?
dedicated_count <- sgvp |>
  filter(volunteer_hours > 500) |>
  count(province)

# Practice: find the median hours for each age group. Which age group
# volunteers the most?





#------------------------------------------------------------------------------#
# (6) COMBINE TABLES
#------------------------------------------------------------------------------#

# A join combines two tables by matching rows on a column they share (the KEY)

# Example 1: add information from a lookup table
# A small table assigning each province to a region
regions <- tibble(
  province = c("Newfoundland and Labrador", "Prince Edward Island",
               "Nova Scotia", "New Brunswick", "Quebec", "Ontario",
               "Manitoba", "Saskatchewan", "Alberta", "British Columbia"),
  region   = c("Atlantic", "Atlantic", "Atlantic", "Atlantic", "Quebec",
               "Ontario", "Prairies", "Prairies", "Prairies",
               "British Columbia")
)

# left_join() keeps every row of the first table and adds the matching
# columns from the second
sgvp_regions <- sgvp |>
  left_join(regions, by = "province")

# Example 2: are the top volunteers also top donors?
top_hours <- sgvp |>
  slice_max(volunteer_hours, n = 100) |>
  select(id, volunteer_hours)

top_donors <- sgvp |>
  slice_max(donation_amount, n = 100) |>
  select(id, donation_amount)

# inner_join() keeps only rows that appear in BOTH tables
top_both <- inner_join(top_hours, top_donors, by = "id")

# Other joins:
#   full_join()  keeps all rows from both tables (filling gaps with NA)
#   anti_join()  keeps rows in the first table with NO match in the second

# Practice: use anti_join() to find the top volunteers who are NOT top donors.





