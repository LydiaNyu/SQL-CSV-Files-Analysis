-- write your COPY statement to import a csv here
\copy twitchdata (channel, watchtime, streamtime,peakviewers,averviewers,followers,gainedfo,gainedviews,partnered,mature,thelanguage) FROM '/Users/sirutao/Documents/GitHub/LydiaNyu-homework05/twitchdata-update.csv' csv HEADER NULL AS 'N/A';