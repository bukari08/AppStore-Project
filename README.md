
## *AppStore-Project*
---
## *Table of Contents*
---
 - [Project Context](#project-context)
 - [Connect to the Dataset](#connect-to-the-dataset)
 - [Identify the Stakeholders](identify-the-stakeholders)
 - [Exploratory Data Analysis](exploratory-data-analysis)
 - [Finding the insights](finding-the-insights)
 - [Recommendations](recommendations)

### *1. Project Context* 
---
This project is about the applications available on the app store. 
dataset 1 .The dataset contains information ablout the app names, the sizing bytes, ratings, supporting devices, supporting languages


### 2. *Connect to the Dataset*
---
I used SQLite online to do this project you can read more. AppleStore_description.csv (dataset 2) 
limitation of this online SQLite is that, it only allows a maximum of 4MG of data.  I uploaded the data an  unto it.The data was divided into 4 parts. the data was uploaded into SQLite online in 4 diffent parts.
 
The data was later combined together.
```
CREATE TABLE appleStore_description_combined AS
SELECT * FROM appleStore_description1
UNION ALL
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4
```

### *3. Identify the  Stakeholders*
---
The stakeholders for this project is an aspiring app developer who needs data driven insights to decide what type of app to build and so may seek answer to questions like what app categories are the most popular, what price should they set, and to can they  maximize user ratings.

  ### 4. Exploratory Data Analysis (EDA)
---
Identifying issues with the data such as missing data, outliners, errors that need to be addressed before the data analysis can be done

Check the number of unique apps in both tables

```
SELECT COUNT(DISTINCT id) AS uniqueAPPIDs
FROM AppleStore; 
```

``` 
SELECT COUNT(DISTINCT id) AS uniqueAPPIDs
FROM appleStore_description_combined;
```

Checking for missing data in dataset

```
SELECT COUNT(*) AS missing
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL or prime_genre;
```

Answer is 0 so there are no missing values

```
SELECT COUNT(*) AS missingvalues
from appleStore_description_combined 
WHERE app_desc IS NULL;
```
Answer is 0 so there are no missing values


Find out the number apps per genre
```
SELECT prime_genre,COUNT(*) AS NumApp
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApp DESC;
```

 Get an overview of App ratings
 ```
SELECT min(user_rating) AS MinRating,
        max(user_rating) AS MaxRating,
        avg(user_rating) AS AvgRating
 from AppleStore;
 ``` 

### *5. Finding the insights*
---
a.  Determine whether paid Apps have higher ratings than free AppsAppleStore

```
SELECT CASE
 				WHEN price > 0 THEN 'Paid'
                ELSE 'Free'
             END AS App_Type,
             avg(user_rating) AS AvgRating
 from AppleStore
 GROUP BY App_Type;
```

b.  Determine if Apps with suported language have higher ratings.
 ```
SELECT CASE
 				WHEN lang_num < 10 THEN '<10 languages'
                WHEN lang_num BETWEEN 10 and 30 THEN '10-30 languages'
                ELSE  '>30 languages'
              END as language_bucket,
              avg(user_rating) AS AvgRating
from AppleStore
GROUP BY language_bucket
order BY AvgRating DESC;
```


c. check genre with low rating

``` 
SELECT prime_genre,
       avg(user_rating) AS AvgRating
from AppleStore
GROUP BY prime_genre
order by AvgRating ASC
LIMIT 10;
```

d. Check Top rated App for each genre

```
SELECT prime_genre, 
		track_name,
        user_rating
from (
        SELECT prime_genre,
  				track_name,
  				user_rating,
		RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, 	rating_count_tot DESC) AS RANK 
        from AppleStore
  		)
        AS a 
WHERE
a.rank=1
```




### * 6. Final recommendations*

- *Paid apps vs free apps***
  - Paid app have better ratings.Paid app generally receive slightly higher ratings than the free one. user who pay for an app may perceive more value leading to more engagements and higher ratings.
  - May consider charging for the app

- *Language Support*
  - Apps supporting between 10 and 30 languages have better ratings.
  - Not about the quantity of the language an app supports but the focusing on the right language
    
- High performing genres*.
  - There are categories like finance and book where existing apps have lower ratings. market penetration opportunities.

- *Apps with a longer description have better ratings*.

### *Limitations* 


