---
title: "What does the fire say?"
author: Yvonne Huang
output: 
  github_document
---

# Introduction to problem/question
Natural disasters, such as storms, floods, and wildfires, occur and threaten human survive. Climate change aggravates disasters, expanding the geographic range being impacted and population of disaster victims. Therefore, Understanding people's reactions and emotional changes toward wildfires would be a crucial question when analyzing social resilience. This project focuses on analyzing people's reactions toward a wildfire incident in California. 
  
# Problem / Question
What people tweet before, during, and after wildfire incident.

# Inspiring Examples

## Example 1
![Twitter data sentiment analysis](https://miro.medium.com/max/1100/1*GcH9PB2aVpPmjzy2O3Xaew.png)

This graphic summarize the words being tweets with positive and negative emotion. The red bar represents the words with positive emotion, it also shows the frequency of words in tweets. To illustrate this graphic, we can use `rtweet` to filter tweets related to wildfire. Also use functions in `tidytext` and `textdata` categorize emotions, such as `get_sentiments()`.


## Example 2
![Fire heat map](https://geospatialtraining.com/wp-content/uploads/2022/04/wildfire4-1536x1048.png)
This graphic shows the spatial distribution of wildfire in 
California. These heat points are added by using`add_heatmap()` in `mapdeck package`. The yellow color represent the where being impacted by wildfires severely, and blue color represent those being impacted less severely.

## Example 3
![Twitter topic modeling](https://ars.els-cdn.com/content/image/1-s2.0-S2212420921000674-gr4.jpg)
This graphic shows word clouds, which indicate what words people use to express their needs in earthquakes. This graphic an be illustrated with `wordcloud()` in `wordcloud` package. By using word clouds, we can visualize how people react toward one incident,

# Proposed data sources

Sentiment analysis: Twitter Academic API.
Wildfire area: Wildfires burned down area shape files. (https://frap.fire.ca.gov/mapping/gis-data/)


# Proposed methods

First, extract the polygon represents wildfire area in "Camp wildfire". Second, use `extent()` to produce a bounding box as study area. Third, use Twitter API with bounding box to extract the tweets related to wildfire, including data from before, during, and after fire incident. Fourth, produce word clouds to analyze focus topics in 3 time backgrounds. Finally, we can use `textdata` and `tidytext` to analyze emotional changes caused by wildfire.


# Expected results

Produce a map shows the geographic area with buffer to illustrate the study area, also, 3 word clouds would be made to present the twitter topics with different time backgrounds. In addition, a bar plot will represent the emotion index as analysis of emotional change.

