-- Superficial analyisis

-- Name

-- As we saw, there are 5 people called the same. We can assume that, since Brandon Jones, Eric Harris and Michael Johnson
-- are pretty common names, they are different people...and maybe our friends Jamake and Daquan are some kind of mistake

select 
	name,
    count(name) as total
from victims
group by name
order by total desc
limit 10
;
-- but maybe it's better to be completely sure...

select *
from victims
where name in ('Brandon Jones','Eric Harris','Jamake Cason Thomas','Michael Johnson','Daquan Antonio Westbrook')
order by name;

-- Ok, comparing the data, we can say the Brandons, Erics and Michaels are different people, but Daquan and Jamake are the same
-- The case of Jamake is easy: we just have to get rid of one of them, since the 2 entries are completely the same (except id)
-- The case of Daquan is different: 2 discrepancies between the entries. Date:2015 or 2016? Threat level:attack or undetermined?
-- Googling daquan, we find he was killed dec. 2015, and that he pointed an officer with his gun...so, the right one is 1129
-- We can get rid of 2158

-- Name null

select *
from victims
where name is null
order by date
;

-- This is our list of John Does...noone of them has age neither,most of them no race...but, we have 4 data to play to know what to do with them:
-- date,armed,gender and city...it´s difficult that 2 people were killed the same day, with the same weapon, same gend)er in the
-- same place. We have to check which are the most reliable columns.
-- For the time being, and for future research, our johns and janes are:
-- 1074,1570,1581,1584,1615,1685,1848,2037,2110,2141,2154,2168,2164,2182,2232,2278,2319,2328,2384

select
	count(id) as total,
    count(date) as dates,
    count(gender) as genders,
    count (city) as cities,
    count(armed) as weapons
from victims;

-- Every entry has date and city, and we have just one gender missing..and he is someone without a name to (has we can see if we check
-- the null names list. This case we can treat it apart...we can extract from here that, to check if this null names entries are
-- an error, we can rely on date, city and gender, but we have 6 missing weapons...let´s try with three first

select name,date,gender,city
from victims

where (date = '2015-12-10' and gender = 'M' and city = 'Hemet')
or
(date = '2016-05-26' and gender = 'M' and city = 'San Antonio')
or
(date = '2016-05-26' and gender = 'F' and city = 'Sneads')
or
(date = '2016-06-01' and gender = 'M' and city = 'Phoenix')
or
(date = '2016-06-09' and gender = 'M' and city = 'Somerton')
or
(date = '2016-07-04' and gender = 'M' and city = 'Rosser')
or
(date = '2016-09-01' and gender = 'M' and city = 'Huntington Park')
or
(date = '2016-11-11' and gender = 'M' and city = 'East Point')
or
(date = '2016-12-08' and gender = 'M' and city = 'Allen')
or
(date = '2016-12-20' and gender = 'M' and city = 'Brawley')
or
(date = '2016-12-21' and gender = 'M' and city = 'Stockton')
or
(date = '2016-12-23' and gender = 'M' and city = 'El Monte')
or
(date = '2016-12-24' and gender = 'M' and city = 'Gadsden')
or
(date = '2016-12-30' and gender = 'M' and city = 'Pensacola')
or
(date = '2017-01-18' and gender = 'M' and city = 'Los Angeles')
or
(date = '2017-01-31' and gender = 'M' and city = 'Hollywood')
or
(date = '2017-02-09' and gender = 'M' and city = 'Crownpoint')
or
(date = '2017-02-12' and gender = 'M' and city = 'Terrell')
or
(date = '2017-02-25' and city = 'Lumpkin')

order by date
;

-- from here we can see that there are no missing entries that are similar (as it happened with the repeated names)

-- Since we have 19 cases, we will have to go one by one. The only thing we can do is avoid all of this being a typo.
-- I mean, we will have to check dates and cities. The procedure is the same, changing data, so I can copy to go faster changing
-- date and city as required. We will have to use the -- thing to go through each query

-- 1: 1074, from Hemet,2015-12-10

select * from victims where city = 'Hemet' order by name desc;
select * from victims where date = '2015-12-10' order by name desc;


-- In the city query, we have discovered Nick Hamilton, with race missing, and 'other' in attack and flee. The date can be a typo...
-- or not...2016-12-20 vs 2015-12-10
-- The data query shows us no possible typo in the city entry
-- Googling says us they are 2 different cases, no typo, and indeed 1074 is a case
-- As a resume, man on parole with a felony warrant, brandishing a handgun in a parking slot of a mall, name not released by the police
-- KilledByPolice sheds no light on this case
-- We will have to think in creating a John Doe

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************

-- 2: 1570, from San Antonio, 2016-05-26

select * from victims where city = 'San Antonio' order by name desc;
select * from victims where date = '2016-05-26' order by name desc;

-- Here the city is messy, because is a big city. We have 16 cases. But the only possible typo in the dates is Joe Angel Cisneros,
-- possible typo in the date 2015-06-26 vs 2016-05-26...but the flee are different
-- In the date query we have two things: no typo possible, and the 1581 case (our next). Just to clarify, they are not the same
-- different weapon,gender,city.
-- Googling, though, gives us interesting info. Angel Daniel Navarro, killed for hijacking with a gun, n the Interstate 25, between
-- San Antonio and Socorro...again, we will have to drop this loose end, since, it's another S.Antonio, not the one in Texas,
-- and the Socorro guy was fleeing by car. We wil have to live with the fact that the Sanantonio.gov web says something
-- about the incident...but the page is not working.
-- Killed by police shares two things: the man was 45,latin, and according to the news, the police stated he was shot and tased, not just shot
-- So, we have another John Doe, but we can add some info

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************

-- 3: 1581, from Sneads, 2016-05-26

select * from victims where city = 'Sneads' order by name desc;

-- No typo in the city, has we said in the previous case, so we can spare this query. The city query offers this has been
-- the only victim in Sneads.
-- Googling says the case indeed happened, no name released. Woman try to attack in a case of domestic violence with a knife
-- in the presence of an officer.
-- According to Killed by police, she was Tonnia Reshelle Jarvis, 48, white

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************

-- 4: 1584, from Phoenix,2016-06-01

select * from victims where city = 'Phoenix' order by name desc;
select * from victims where date = '2016-06-01' order by name desc;

-- Another tricky case in a very big city. 24 entries to try to see if there is a typo in the date: no typo
-- Date query: no typo in the city
-- Google says the name of the victim involved is Kevin T. Marshall, 30.
-- Killed by police adds white
-- Curiosly, the same day in phoenix a guy was struck and killed by a police car, 18-year-old Jordan Black (accident, not counted
-- in these lists)

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************

-- 5: 1615, from Somerton, 2016-06-09

select * from victims where city = 'Somerton' order by name desc;
select * from victims where date = '2016-06-09' order by name desc;
select * from victims where armed = 'baton' order by name desc;

-- In Somerton there has been not other killing but this one.
-- No typo on the city
-- Since the weapon is kind of particular, we do a 3rd query, but to typo there
-- Google says nothing. Killed by police conts on the 10 june an unkown guy,killed in Somerton, carrying a baton he stole from
-- the agent...he was an unknown mexican citizen, he was latin

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************

-- 6: 1685, from Rosser,2016-07-04

select * from victims where city = 'Rosser' order by name desc;
select * from victims where date = '2016-07-04' order by name desc;

-- Only one guy from Rosser
-- No typo on the city
-- Google says it happened, a knife wielding suspect killed after he stabbed 3 people
-- Killed by police says nothing more
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************



-- 7: 1848,from Huntington Park,2016-09-01

select * from victims where city = 'Huntington Park' order by name desc;
select * from victims where date = '2016-09-01' order by name desc;
select * from victims where armed = 'pipe' order by name desc;

-- Only victim from Huntington Park
-- Not a typo in the city neither
-- Only guy armed with a pipe
-- Google says he was in his 35-40, when he was detained he was armed with rocks, and that he was previously tased
-- Killed by police says he was latin
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************




-- 8: 2037,from East Point,2016-11-11

select * from victims where city = 'East Point' order by name desc;
select * from victims where date = '2016-11-11' order by name desc;

-- No typo in the date
-- No typo in the city
-- Google says that he was unarmed, not fleeing
-- Killed by police says he was Andrew Depeiza, 30 , Black
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************



-- 9: 2110, from Allen,2016-12-08

select * from victims where city = 'Allen' order by name desc;
select * from victims where date = '2016-12-08' order by name desc;

-- No typo in the date
-- No typo in the city
-- Google says in his 60s
-- Killed by police says  in his 60s
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************



-- 10: 2141, from Brawley,2016-12-20

select * from victims where city = 'Brawley' order by name desc;
select * from victims where date = '2016-12-20' order by name desc;

-- No typo in the date
-- No typo in the city
-- Google says maybe the date is 19th
-- Killed by police says Walter Ricardo Pimentel , Latin
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************


-- 11: 2154, from Stockton,2016-12-21

select * from victims where city = 'Stockton' order by name desc;
select * from victims where date = '2016-12-21' order by name desc;

-- No typo in the date
-- No typo in the city
-- Google says Luis Ambrosio-Aguilar, 30, latin
-- Killed by police says
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************


-- 12: 2168, from El Monte,2016-12-23

select * from victims where city = 'El Monte' order by name desc;
select * from victims where date = '2016-12-23' order by name desc;
select * from victims where armed = 'vehicle' and state = 'CA' and (extract(year from date)=2016) order by name desc;

-- No typo in the date
-- No typo in the city
-- Searching for an error within the same state, year and weapon: 
-- Google says Jose Sanchez, 30 latin
-- Killed by police says
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************



-- 13: 2164, from Gadsden,2016-12-24

select * from victims where city = 'Gadsden' order by name desc;
select * from victims where date = '2016-12-24' order by name desc;

-- No typo in the date
-- No typo in the city
-- Google says Orande Kandie Hayes
-- Killed by police says
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************



-- 14: 2182,from Pensacola,2016-12-30

select * from victims where city = 'Pensacola' order by name desc;
select * from victims where date = '2016-12-30' order by name desc;

-- No typo in the date
-- Possible confussion with Jamal Rollins
-- Google says
-- Killed by police says Daniel Ralph Daily, 34 , white
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************



-- 15: 2232, from Los Angeles,2017-01-18

select * from victims where city = 'Los Angeles' order by name desc;
select * from victims where date = '2017-01-18' order by name desc;
select * from victims where armed = 'hatchet' order by name desc;

-- Impossible to fins a typo in the date...a lot of entries in LA
-- No typo in the city
-- Strange guy fleeing by car with an hatchet...no light neither
-- Google says
-- Killed by police says David Darnell Stroughter, 50 , Black, Westchester (neighbourhood of LA?)
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************


-- 16: 2278 ,from Hollywood,2017-01-31

select * from victims where city = 'Hollywood' order by name desc;
select * from victims where date = '2017-01-31' order by name desc;


-- No typo in the date
-- No typo in the city
-- Google says
-- Killed by police says Solomon Picart, 37, Black
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************


-- 17: 2319,from Crownpoint,2017-02-09

select * from victims where city = 'Crownpoint' order by name desc;
select * from victims where date = '2017-02-09' order by name desc;

-- No typo in the date
-- No typo in the city
-- Google says nothing
-- Killed by police says nothing
-- 

-- ******************************************************************************************************************************
-- ******************************************************************************************************************************


-- 18: 2328, from Terrell,2017-02-12

select * from victims where city = 'Terrell' order by name desc;
select * from victims where date = '2017-02-12' order by name desc;

-- No typo in the date
-- No typo in the city
-- Google says nothing
-- Killed by police says nothing
-- 
-- ******************************************************************************************************************************
-- ******************************************************************************************************************************



-- 19: 2384, from Lumpkin,2017-02-25

select * from victims where city = 'Lumpkin' order by name desc;
select * from victims where date = '2017-02-25' order by name desc;

-- No typo in the date
-- No typo in the city
-- Google says William Dwayne Darby, 39, White
-- Killed by police says
-- 