---
title: "MSDR Capstone"
author: "Enrique Pérez Herrero"
date: "July 23, 2017"
output: html_document
---

# MSDR Capstone

## Introduction

This capstone project will be centered around a dataset obtained from the U.S.
National Oceanographic and Atmospheric Administration (NOAA) on significant
earthquakes around the world. This dataset contains information about 5,933
earthquakes over an approximately 4,000 year time span.

The overall goal of the capstone project is to integrate the skills you have
developed over the courses in this Specialization and to build a software
package that can be used to work with the NOAA Significant Earthquakes dataset.
This dataset has a substantial amount of information embedded in it that may not
be immediately accessible to people without knowledge of the intimate details of
the dataset or of R. Your job is to provide the tools for processing and
visualizing the data so that others may extract some use out of the information
embedded within.

The ultimate goal of the capstone is to build an R package that will contain
features and will satisfy a number of requirements that will be laid out in the
subsequent Modules. You may want to begin organizing your package and insert
various features as you go through the capstone project.

### Dataset

* [NOAA Significant Earthquake Database](https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1)

## Obtain and clean de data

This module is fairly straightforward and involves obtaining/downloading the
dataset and writing functions to clean up some of the variables. The dataset is
in tab-delimited format and can be read in using the `read_delim()` function in
the `readr` package.

After downloading and reading in the dataset, the overall task for this module 
is to write a function named `eq_clean_data()` that takes raw NOAA data frame
and returns a clean data frame. The clean data frame should have the following:

1. A date column created by uniting the year, month, day and converting it to
the Date class

2. LATITUDE and LONGITUDE columns converted to numeric class

3. In addition, write a function `eq_location_clean()` that cleans the 
LOCATION_NAME column by stripping out the country name (including the colon) and
converts names to title case (as opposed to all caps). This will be needed later
for annotating visualizations. This function should be applied to the raw data 
to produce a cleaned up version of the LOCATION_NAME column.

## Visualization tools

The goal of this module is to build two geoms that can be used in conjunction 
with the ggplot2 package to visualize some of the information in the NOAA 
earthquakes dataset. In particular, we would like to visualize the times at 
which earthquakes occur within certain countries. In addition to showing the 
dates on which the earthquakes occur, we can also show the magnitudes (i.e. 
Richter scale value) and the number of deaths associated with each earthquake.

1. Build a geom for `ggplot2` called `geom_timeline()` for plotting a time line
of earthquakes ranging from `xmin` to `xmaxdates` with a point for each
earthquake. Optional aesthetics include color, size, and alpha (for
transparency). The `xaesthetic` is a date and an optional y aesthetic is a
factor indicating some stratification in which case multiple time lines will be
plotted for each level of the factor (e.g. country).



2. Build a geom called `geom_timeline_label()` for adding annotations to the
earthquake data. This geom adds a vertical line to each data point with a text
annotation (e.g. the location of the earthquake) attached to each line. There
should be an option to subset to n_max number of earthquakes, where we take the
n_max largest (by magnitude) earthquakes. Aesthetics are x, which is the date of
the earthquake and label which takes the column name from which annotations will
be obtained.

