-- write your table creation sql here!
CREATE TABLE twitchdata(
channel text primary key,
watchtime bigint,
streamtime integer,
peakviewers integer,
averviewers integer,
followers integer,
gainedfo integer,
gainedviews integer,
partnered boolean,
mature boolean,
thelanguage text);

