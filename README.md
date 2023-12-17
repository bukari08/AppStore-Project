
## *AppStore-Project*
---
## *Table of Contents*
---
 - [Project Overview](#project-overview)
 - [Data Source](#data-source)
 - [Tools](tools)
 - [Recommendation](recommendation)

### *Project Overview* 
---
This data analysis 


### Data Source
Sales Data: The primary dataset used for 

### *Tools*
---
- Excel - Data Cleaning
  - Data Analysis Using SQLite [visit]
    - (https://sqliteonline.com/)
- SQL Server Data Analysis 
-  PowerBI - Creating Reports

  ### Data Cleaning and Preparation
  ---
  In the initial data phase, we performed the following 
  1. Data
  2. Handling missing data
  3. Data cleaning

### *Exploratory Data Analysis*
---
- What is the overall trend

### *Data Analysis*
``` CREATE TABLE appleStore_description_combined AS

SELECT * FROM appleStore_description1
UNION ALL
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4
```

-----check the number of different apps in both tables----
``` SELECT COUNT(DISTINCT id) AS uniqueAPPIDs
FROM AppleStore; ```

``` SELECT COUNT(DISTINCT id) AS uniqueAPPIDs
FROM appleStore_description_combined;```



```---Checking for missing data in dataset-----```

`` SELECT COUNT(*) AS missing
FROM AppleStore
WHERE track_name ISNULL OR user_rating ISNULL or prime_genre;``

```SELECT COUNT(*) AS missingvalues
from appleStore_description_combined 
WHERE app_desc ISNULL; ```

```find out he number apps per genre```
``` SELECT prime_genre,COUNT(*) AS NumApp
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApp DESC; 

``` Get an overview of App ratings
``` SELECT min(user_rating) AS MinRating,
        max(user_rating) AS MaxRating,
        avg(user_rating) AS AvgRating
 from AppleStore;```


```
### *Results*
The analysis results are
1. the company has
2. the sales

### *Recommendations*
- *Paid apps vs free apps***
  - Paid app have better ratings.Paid app generally receive slightly higher ratings than the free one. user who pay for an app may perceive more value leading to more engagements and higher ratings.
  - May consider charging for the app

-Language Support
   - Apps supporting between 10 and 30 languages have better ratings.
   - Not about the quantity of the language an app supports but the focusing on the right language 

- High performing genres.
   - There are categories like finance and book where existing apps have lower ratings. market penetration opportunities.

- Apps with a longer description have better ratings.

### *Limitations* 


