
--Project Data Bases. Kryukova Svetlana


--PART I/ create tables and put data to insert :

--1. table City:
create table city (city_id number(3) constraint Pk_city_id primary key,city_name varchar2(20));

--2. table Pilot:
create table pilot (pilot_id number(3) constraint pilot_id_pk primary key, last_name varchar2(20), first_name varchar2(20),
city_id number(3) constraint city_id_fk references city(city_id), salary number(7,2) constraint salary_check_con check (salary between 5000 and 7500));


--3. table Plane:
create table plane (pla_id number(2)constraint pla_id_pk primary key, pla_desc varchar2(20), max_passenger number(3) constraint maxpas_check_con 
check (max_passenger <=500), city_id number(3)constraint plane_city_id_fk references city(city_id));

--4. table Flight:
create table flight (flight_id number(3),
pilot_id number(3) constraint pil_id_con_fk references pilot(pilot_id),
pla_id number(2)constraint plane_id_con_fk references plane(pla_id),
city_dep number(3), city_arr number(3), dep_date date, dep_time number(4), arr_time number(4),
constraint flight_date_pk_con primary key (flight_id, dep_date), constraint dep_arrival_check_con check (dep_time < arr_time));

----1. insert data in to table City
insert into city values (100,	'OTTAWA');
insert into city values (101,	'QUEBEC');
insert into city values (102,	'MONTREAL');
insert into city values (103,	'TORONTO');
insert into city values (104,	'VICTORIA');
insert into city values (105,	'EDMONTON');

---2. insert data in to table Pilot
insert into pilot values (1,	'FANTASSO',	'ALBERT', 100,	7000);
insert into pilot values (2,	'PETERS',	'FRANK',	101,	7000);
insert into pilot values (3,	'ROSS',	'PAUL',	102,	6000);
insert into pilot values (4,	'MIRANDA',	'SERGE',	100,	5800);
insert into pilot values (5,	'TALADOIRE',	'GILLES',	101,	6200);
insert into pilot values (6,	'BONFILS',	'GERARD',	101,	6000);
insert into pilot values (7,	'LAHRIRE',	'PHILLIPE',	103,	5200);
insert into pilot values (8,	'MARCENAC',	'PIERRE',	102,	5800);
insert into pilot values (9,	'CAVARERO',	'ERIC',	102,	6000);
insert into pilot values (10,	'TAYLOR',	'ROBERT',	100,	6800);

---3. insert data in to table Plane
insert into plane values (1,	'A300',	300,	102);
insert into plane values (2,	'A310',	300,	102);
insert into plane values (3,	'B727',	250,	100);
insert into plane values (4,	'A300',	280,	103);
insert into plane values (5,	'CONCORDE',	160,	102);
insert into plane values (6,	'B747',	460,	100);
insert into plane values (7,	'B727',	250,	100);
insert into plane values (8,	'A310',	300,	101);
insert into plane values (9,	'B737',	350,	103);
insert into plane values (10,	'CONCORDE',	160,	100);

---4. insert data in to table FLIGHT

insert into flight values (100,	1,	1,	102,	103, to_date('12-oct-2015', 'DD-MONTH-YYYY'), 1100,	1430);
insert into flight values (101, 1,	8,	100,	103, to_date('12-oct-2015', 'DD-MONTH-YYYY'), 1700,	2000);
insert into flight values (102,	2,	1,	101,	103, to_date('10-nov-2015', 'DD-MONTH-YYYY'), 1400,	1600);
insert into flight values (103,	5,	3,	101,	103, to_date('05-may-2015', 'DD-MONTH-YYYY'), 1800,	2000);
insert into flight values (104,	9,	1,	100,	102, to_date('14-apr-2015', 'DD-MONTH-YYYY'), 0645,	0730);
insert into flight values (105,	10,	2,	103,	102, to_date('12-jan-2014', 'DD-MONTH-YYYY'), 1100,	1400);
insert into flight values (106,	1,	4,	102,	103, to_date('31-dec-2014', 'DD-MONTH-YYYY'), 0800,	1100);
insert into flight values (107,	8,	4,	102,	100, to_date('25-feb-2015', 'DD-MONTH-YYYY'), 0715,	0800);
insert into flight values (108,	1,	8,	104,	103, to_date('13-jun-2015', 'DD-MONTH-YYYY'), 0900,	1300);
insert into flight values (109,	9,	2,	102,	100, to_date('18-aug-2015', 'DD-MONTH-YYYY'), 1215,	1300);
insert into flight values (110,	4,	5,	100,	103, to_date('04-sep-2015', 'DD-MONTH-YYYY'), 1500,	1800);
insert into flight values (111,	1,	2,	103,	104, to_date('13-aug-2015', 'DD-MONTH-YYYY'), 1630,	2030);
insert into flight values (112,	4,	5,	102,	105, to_date('15-nov-2015', 'DD-MONTH-YYYY'), 1100,	1420);
insert into flight values (113,	3,	5,	105,	100, to_date('18-oct-2015', 'DD-MONTH-YYYY'), 1500,	1800);
insert into flight values (114,	8,	9,	100,	101, to_date('26-dec-2015', 'DD-MONTH-YYYY'), 1700,	1830);
insert into flight values (115,	7,	5,	100,	101, to_date('14-nov-2015', 'DD-MONTH-YYYY'), 1800,	1930);

--PART II / Answer to the following questions :


--1) Type the SQL command that displays the description and the capacity of the AIRBUS planes.
--   (Plane’s description  that starts with A is AIRBUS, B is BOEING,C is CONCORDE)
select pla_desc, max_passenger from plane where pla_desc like 'A%';
select pla_desc, max_passenger from plane where pla_desc like 'B%';
select pla_desc, max_passenger from plane where pla_desc like 'C%';

--2) Type the SQL command displays the pilots (identification) who do more than two 
--   flights (>=) from Montreal (departure city name).
select distinct pilot_id, count(flight_id) from flight , city  where city.city_id = flight.city_dep and city_name = 'MONTREAL' 
group by pilot_id having count(flight_id) >= 2;

--3) Type the SQL command that displays the planes (plane id, its description, 
--   localization(city name ) and the total number of passenger) that are located in 
--   OTTAWA and its max passenger is greater than 200(>=) (display the result in the 
--   descending order of their max of passenger)
select pla_id, pla_desc, city_name, sum (max_passenger) from plane , city  where plane.city_id = city.city_id
       and city_name = 'OTTAWA' group by pla_id, pla_desc, city_name 
       having sum(max_passenger) >=200 order by sum (max_passenger) desc;

--4) Type the SQL command that displays the pilots (pilot id and name) who do 
--   at least one departure flight from MONTREAL.(city name not city id):

select flight.pilot_id, last_name, first_name, city_name, count(flight_id) from pilot, city, flight 
       where pilot.CITY_ID = city.CITY_ID and pilot.pilot_id = flight.pilot_id group by flight.pilot_id, last_name, first_name, city_name
       having count(flight_id) >= 1 and city_name = 'MONTREAL'; 

--5) Type the SQL command that displays the pilots (pilot id, name and plane description) who pilot a BOEING.
select pilot.pilot_id, pilot.last_name, pilot.first_name, plane.pla_desc
from pilot, plane, flight where pilot.pilot_id = flight.pilot_id and plane.pla_id = flight.pla_id and plane.pla_desc like 'B%';

--6) Type the SQL command that displays the pilots (id and name) who earn the 
--   same salary as PETERS’s or LAHRIRE’s salary. (PETER and LAHRIRE are not included)

select pilot_id, last_name, salary from pilot where salary in (select salary from pilot where last_name = 'PETERS' or last_name = 'LAHRIRE')
and Last_name!='PETERS' and last_name!='LAHRIRE';

--7) Type the SQL command that displays the pilots ( pilot name and city name )
--   who live in the same city as AIRBUS localization city.

select distinct pilot.last_name, city.city_name from pilot, city, plane 
where pilot.city_id = city.city_id and city.city_id = plane.city_id and plane.pla_desc like 'A%';

--8) Type the SQL command that displays the planes (description and maximum of 
--   passenger) that its max passenger is greater (>) than the max passenger of each 
--   plane located in Montreal.

select pla_desc, max_passenger, city_name from plane, city where plane.CITY_ID=city.CITY_ID 
       and max_passenger > (select  max(max_passenger) from plane, city  where plane.CITY_ID=city.CITY_ID and city_name = 'MONTREAL');

--9) Type the SQL command that displays the total number of pilots in service.
--  (pilot in service is pilot who performs at least one flight)

select count (distinct flight.pilot_id) as total_number_of_pilots  from flight;

--10) For each AIRBUS in service during the afternoon(arr_time>=1200), type the SQL command that displays its id, description, the departures and arrivals 
--    cities.(city name not city id)

select flight.pla_id, pla_desc, city_dep, c_dep.city_name, city_arr, c_arr.city_name
from flight join plane on flight.pla_id = plane.pla_id join city c_dep on flight.city_dep = c_dep.city_id
            join city c_arr on flight.city_arr = c_arr.city_id and pla_desc like 'A%' and arr_time >=1200;

--11) Create a view containing the pilots(names) who are not in service

create view V1_PILOT (pilot_id, last_name, first_name) as select last_name, first_name, count(pilot.pilot_id) from pilot 
       where pilot.pilot_id not in (select flight.pilot_id from flight) group by last_name, first_name; 

--12) Create a view which returns the pilot’s id, name, salary as well as the plane’s description that he pilots.

create or REPLACE view V2_PILOT as select flight.pilot_id, last_name, first_name, salary, pla_desc from pilot 
join flight on pilot.pilot_id = flight.pilot_id
join plane on flight.pla_id = plane.pla_id; 

---13) Type the SQL command that displays the pilot id, the name, and the total number of times he pilot
select flight.pilot_id, last_name, first_name, count(flight.pilot_id)as total_number 
from flight join pilot on pilot.pilot_id = flight.pilot_id  group by flight.pilot_id, last_name, first_name order by flight.pilot_id;


