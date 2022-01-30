-- write your queries underneath each number:
 
-- 1. the total number of rows in the database
SELECT count(*) FROM twitchdata;
-- 2. show the first 15 rows, but only display 3 columns (your choice)
SELECT channel, followers, thelanguage FROM twitchdata limit 15;
-- 3. do the same as above, but chose a column to sort on, and sort in descending order
SELECT channel, followers, thelanguage FROM twitchdata ORDER BY followers DESC limit 15;
-- 4. add a new column without a default value
ALTER TABLE twitchdata ADD COLUMN peakaverratio numeric;
-- 5. set the value of that new column
UPDATE twitchdata SET peakaverratio = round((peakviewers/averviewers)::numeric,2);
-- 6. show only the unique (non duplicates) of a column of your choice
SELECT DISTINCT thelanguage FROM twitchdata;
-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group 
SELECT thelanguage, count(thelanguage) FROM twitchdata GROUP BY thelanguage;
-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups 
SELECT thelanguage, count(thelanguage) FROM twitchdata GROUP BY thelanguage HAVING count(thelanguage)>20;
-- 9. show the top 15 channels with largest streamtime
SELECT channel, streamtime FROM twitchdata ORDER BY streamtime DESC limit 15;
-- 10. to show the top top 15 channels with ratio of Watchtime to streamtime
SELECT channel, round((watchtime/streamtime)::numeric,2) FROM twitchdata ORDER BY round((watchtime/streamtime)::numeric,2) DESC limit 15;
-- 11. show all channels using Thai language
SELECT channel AS channelThai FROM twitchdata WHERE thelanguage='Thai';
-- 12. show top 15 channels with largest gained Views
SELECT channel FROM twitchdata ORDER BY gainedviews DESC limit 15;