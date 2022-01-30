Please use the raw option to see my repord.md file, since I do not know why this file looks so messy in normal views in github.
# Overview
Name / Title: twitchdata-update.csv
Link to Data: https://www.kaggle.com/aayushmishra1512/twitchdata
Source / Origin:
Author or Creator: Aayush Mishra
Publication Date: updated a year ago
Publisher: Aayush Mishra
Version or Data Accessed: 3
License: CC0: Public Domain
Format: csv
Size: 79 KB
Number of Records: 1000

Fields or Column Headers
Field/Column 1: Channel: str
Field/Column 2: Watch Time: int
Field/Column 3: Stream time : int
Field/Column 4: Peak viewers: int
Field/Column 5: Average viewers : int
Field/Column 6: Followers : int
Field/Column 7: Followers gained : int
Field/Column 8: Views gained: int
Field/Column 9: Partnered: bool
Field/Column 10: Mature : bool
Field/Column 11: Language : String


# Table Design
I will use channel column as the primary key since all the channels will not overlap and since that's the Data
from the past year, so the channel column will not change.

About the data type, channel and language will be text, watchtime will be bigint since some numbers just be big.
streamtime, peakviewers, averviwers, followers, gainedfollowers,gainedviwers will all be int, and partnered and 
mature will be boolean.

there is no missing data in this csv file, so I will not worry about this point.


# Import
when I use COPY command, I just got the error as following:
lydiahw5=# COPY twitchdata (Channel, WatchTime, StreamTime,Averviewers,Followers,gainedFo,gainedViews,Partnered,Mature,thelanguage) 
lydiahw5-# FROM '/Users/sirutao/Documents/GitHub/LydiaNyu-homework05/twitchdata-update.csv' 
lydiahw5-# csv HEADER NULL AS 'N/A';
ERROR:  could not open file "/Users/sirutao/Documents/GitHub/LydiaNyu-homework05/twitchdata-update.csv" for reading: Permission denied
HINT:  COPY FROM instructs the PostgreSQL server process to read a file. You may want a client-side facility such as psql's \copy.

The way I fixed it is to use the instruction in the hint, using \copy instead of COPY, then it will work.


# Database Information
1.show all of databases in your postgres instance
lydiahw5=# \l
                             List of databases
   Name    |  Owner   | Encoding | Collate | Ctype |   Access privileges   
-----------+----------+----------+---------+-------+-----------------------
 lydiahw5  | postgres | UTF8     | C       | C     | 
 lydiatest | postgres | UTF8     | C       | C     | 
 mydb      | postgres | UTF8     | C       | C     | 
 postgres  | postgres | UTF8     | C       | C     | 
 template0 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
 template1 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
2.  show all of the tables in your database
lydiahw5=# \dt
           List of relations
 Schema |    Name    | Type  |  Owner   
--------+------------+-------+----------
 public | twitchdata | table | postgres

3 finally, show some information about the table you 
created and imported data into: find a way to show its columns,
 types and constraints (hint: describe the table)
 lydiahw5=# \d twitchdata
               Table "public.twitchdata"
   Column    |  Type   | Collation | Nullable | Default 
-------------+---------+-----------+----------+---------
 channel     | text    |           | not null | 
 watchtime   | bigint  |           |          | 
 streamtime  | integer |           |          | 
 peakviewers | integer |           |          | 
 averviewers | integer |           |          | 
 followers   | integer |           |          | 
 gainedfo    | integer |           |          | 
 gainedviews | integer |           |          | 
 partnered   | boolean |           |          | 
 mature      | boolean |           |          | 
 thelanguage | text    |           |          | 
Indexes:
    "twitchdata_pkey" PRIMARY KEY, btree (channel)


# Query Results
-- 1. the total number of rows in the database
 lydiahw5=# SELECT count(*) FROM twitchdata;
 count 
-------
  1000
(1 row)
-- 2. show the first 15 rows, but only display 3 columns (your choice)
lydiahw5=# SELECT channel, followers, thelanguage FROM twitchdata limit 15;
        channel         | followers | thelanguage 
------------------------+-----------+-------------
 xQcOW                  |   3246298 | English
 summit1g               |   5310163 | English
 Gaules                 |   1767635 | Portuguese
 ESL_CSGO               |   3944850 | English
 Tfue                   |   8938903 | English
 Asmongold              |   1563438 | English
 NICKMERCS              |   4074287 | English
 Fextralife             |    508816 | English
 loltyler1              |   3530767 | English
 Anomaly                |   2607076 | English
 TimTheTatman           |   5265659 | English
 LIRIK                  |   2666382 | English
 Riot Games (riotgames) |   4487489 | English
 Rubius                 |   5751354 | Spanish
 auronplay              |   3983847 | Spanish
(15 rows)

-- 3. do the same as above, but chose a column to sort on, and sort in descending order
lydiahw5=# SELECT channel, followers, thelanguage FROM twitchdata ORDER BY followers DESC limit 15;
        channel         | followers | thelanguage 
------------------------+-----------+-------------
 Tfue                   |   8938903 | English
 shroud                 |   7744066 | English
 Myth                   |   6726893 | English
 Rubius                 |   5751354 | Spanish
 pokimane               |   5367605 | English
 summit1g               |   5310163 | English
 TimTheTatman           |   5265659 | English
 dakotaz                |   4520305 | English
 Riot Games (riotgames) |   4487489 | English
 DrDisrespect           |   4450718 | English
 DrLupo                 |   4115083 | English
 NICKMERCS              |   4074287 | English
 auronplay              |   3983847 | Spanish
 ESL_CSGO               |   3944850 | English
 TheGrefg               |   3795667 | Spanish
(15 rows)

-- 4. add a new column without a default value
lydiahw5=# ALTER TABLE twitchdata ADD COLUMN peakaverratio numeric;
ALTER TABLE
lydiahw5=# \d twitchdata
                Table "public.twitchdata"
    Column     |  Type   | Collation | Nullable | Default 
---------------+---------+-----------+----------+---------
 channel       | text    |           | not null | 
 watchtime     | bigint  |           |          | 
 streamtime    | integer |           |          | 
 peakviewers   | integer |           |          | 
 averviewers   | integer |           |          | 
 followers     | integer |           |          | 
 gainedfo      | integer |           |          | 
 gainedviews   | integer |           |          | 
 partnered     | boolean |           |          | 
 mature        | boolean |           |          | 
 thelanguage   | text    |           |          | 
 peakaverratio | numeric |           |          | 
Indexes:
    "twitchdata_pkey" PRIMARY KEY, btree (channel)

-- 5. set the value of that new column
lydiahw5=# UPDATE twitchdata SET peakaverratio = round((peakviewers/averviewers)::numeric,2);
UPDATE 1000
lydiahw5=# Select peakaverratio from twitchdata limit 10;
 peakaverratio 
---------------
          8.00
         12.00
         35.00
         38.00
          9.00
          6.00
          4.00
          3.00
          3.00
         10.00
(10 rows)

-- 6. show only the unique (non duplicates) of a column of your choice
lydiahw5=# SELECT DISTINCT thelanguage FROM twitchdata;
 thelanguage 
-------------
 Turkish
 German
 Italian
 Slovak
 Chinese
 Swedish
 Japanese
 Spanish
 Finnish
 Arabic
 Other
 French
 Portuguese
 Hungarian
 English
 Thai
 Czech
 Korean
 Greek
 Polish
 Russian
(21 rows)

-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group 
lydiahw5=# SELECT thelanguage, count(thelanguage) FROM twitchdata GROUP BY thelanguage;
 thelanguage | count 
-------------+-------
 Turkish     |    22
 German      |    49
 Italian     |    17
 Slovak      |     1
 Chinese     |    30
 Swedish     |     1
 Japanese    |    10
 Spanish     |    68
 Finnish     |     1
 Arabic      |     5
 Other       |     1
 French      |    66
 Portuguese  |    61
 Hungarian   |     2
 English     |   485
 Thai        |    11
 Czech       |     6
 Korean      |    77
 Greek       |     1
 Polish      |    12
 Russian     |    74
(21 rows)
-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups 
                                                              ^
lydiahw5=# SELECT thelanguage, count(thelanguage) FROM twitchdata GROUP BY thelanguage HAVING count(thelanguage)>20;
 thelanguage | count 
-------------+-------
 Turkish     |    22
 German      |    49
 Chinese     |    30
 Spanish     |    68
 French      |    66
 Portuguese  |    61
 English     |   485
 Korean      |    77
 Russian     |    74
(9 rows)

-- 9. show the top 15 channels with largest screamtime
lydiahw5=# SELECT channel, streamtime FROM twitchdata ORDER BY streamtime DESC limit 15;

     channel     | streamtime 
-----------------+------------
 RiffTrax        |     521445
 RelaxBeats      |     521430
 Monstercat      |     519675
 RocketBeansTV   |     518415
 SaltyTeemo      |     517980
 ESL_CSGO        |     517740
 livekiss        |     517260
 Gaules          |     515280
 voicetv         |     514845
 DownToQuest     |     513540
 Japan_ASMR      |     509670
 JohnPitterTV    |     508965
 SaltyBet        |     508140
 BeyondTheSummit |     505080
 Speedrun        |     500010
(15 rows)

-- 10. to show the top top 15 channels with ratio of Watchtime to streamtime
lydiahw5=# SELECT channel, round((watchtime/streamtime)::numeric,2) FROM twitchdata ORDER BY round((watchtime/streamtime)::numeric,2) DESC limit 15;
          channel          |   round   
---------------------------+-----------
 dota2ti                   | 161136.00
 dota2ti_ru                | 131160.00
 auronplay                 |  59396.00
 LCS                       |  46949.00
 Asmongold                 |  44600.00
 Rubius                    |  44420.00
 LCK_Korea                 |  40493.00
 RocketLeague              |  39428.00
 LCK                       |  36396.00
 Call of Duty (callofduty) |  35922.00
 KEEMSTAR                  |  35603.00
 MontanaBlack88            |  35554.00
 StarLadder_cs_en          |  33115.00
 Riot Games (riotgames)    |  33093.00
 OverwatchLeague           |  32890.00
(15 rows)

-- 11. show all channels using Thai language
lydiahw5=# SELECT channel AS channelThai FROM twitchdata WHERE thelanguage='Thai';
   channelthai    
------------------
 RebirthzTV
 boyMinORu
 FPSThailand
 FifaTargrean
 duckmanzch
 NoctisAK47
 iamSometimes
 Esports_Alliance
 voicetv
 Tanxlive
 LightFuryLF
(11 rows)
-- 12. show top 15 channels with largest gained Views

lydiahw5=# SELECT channel FROM twitchdata ORDER BY gainedviews DESC limit 15;
   channel    
--------------
 Fextralife
 Igromania
 ESL_CSGO
 Gaules
 xQcOW
 HGmony
 summit1g
 Destructoid
 Chess
 Tfue
 LCK_Korea
 OgamingLoL
 TwitchRivals
 NBA2KLeague
 BeBePtv
(15 rows)
