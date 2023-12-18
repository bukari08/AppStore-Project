CREATE TABLE appleStore_description_combined AS
SELECT * FROM appleStore_description1
UNION ALL
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4;

#check the number of different apps in both tables**
SELECT COUNT(DISTINCT id) AS uniqueAPPIDs
FROM AppleStore;

SELECT COUNT(DISTINCT id) AS uniqueAPPIDs
FROM appleStore_description_combined;

#Checking for missing data in dataset
SELECT COUNT(*) AS missing
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL or prime_genre;

SELECT COUNT(*) AS missingvalues
from appleStore_description_combined 
WHERE app_desc IS NULL;

#find out the number apps per genre
SELECT prime_genre,COUNT(*) AS NumApp
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApp DESC;
 ---- Get an overview of App ratings
 SELECT min(user_rating) AS MinRating,
        max(user_rating) AS MaxRating,
        avg(user_rating) AS AvgRating
 from AppleStore;
 
 #DATA ANALYSIS***
 #Determine whether paid Apps have higher ratings than free AppsAppleStore
 SELECT CASE
 				WHEN price > 0 THEN 'Paid'
                ELSE 'Free'
             END AS App_Type,
             avg(user_rating) AS AvgRating
 from AppleStore
 GROUP BY App_Type;
 
 #---determine if Apps with suported language have higher ratings.
 SELECT CASE
 				WHEN lang_num < 10 THEN '<10 languages'
                WHEN lang_num BETWEEN 10 and 30 THEN '10-30 languages'
                ELSE  '>30 languages'
              END as language_bucket,
              avg(user_rating) AS AvgRating
from AppleStore
GROUP BY language_bucket
order BY AvgRating DESC;

#---check genre with low rating
SELECT prime_genre,
       avg(user_rating) AS AvgRating
from AppleStore
GROUP BY prime_genre
order by AvgRating ASC
LIMIT 10;


# the rating is low for some categories so there is a need to create an app.AppleStore

#--- check if there is a correlation between the length of App description and the user ratings.AppleStore
SELECT CASE
			WHEN length(b.app_desc) < 500 THEN 'Short'
            when length (b.app_desc) between 500 and 1000 then 'Medium'
            else 'Long'
         end as description_length_bucket,
         avg(a.user_rating) AS Average_Rating
         

FROM AppleStore as a 
join appleStore_description_combined as b  
on 
	a.id = b.id
group by describtion_length_bucket
order by Average_Rating desc;

--- Check Top rated App for each genre
SELECT prime_genre, 
		track_name,
        user_rating
from (
        SELECT prime_genre,
  				track_name,
  				user_rating,
		RANK() OVER (PARTITION BY prime_genre
        ORDER BY user_rating DESC, 
        rating_count_tot DESC) AS RANK 
        from AppleStore
  		)
        AS a 
WHERE
a.rank=1

 
 
 
 
 