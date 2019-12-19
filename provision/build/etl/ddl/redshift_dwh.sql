CREATE TABLE IF NOT EXISTS DWH.dim_carrier
(
  carrierkey int primary key encode lzo,
	carriercode VARCHAR(50)   ENCODE lzo
	,carrierdescription VARCHAR(200)   ENCODE lzo,
	loadtimestamp timestamp encode lzo default current_timestamp,
	loaduserid text encode lzo
	
);

CREATE TABLE IF NOT EXISTS  DWH.dim_orgairport
(
  orgairportkey int primary key,
	iata VARCHAR(50)   ENCODE lzo
	,airportname VARCHAR(50)   ENCODE lzo
	,city VARCHAR(50)   ENCODE lzo
	,state VARCHAR(50)   ENCODE lzo
	,country VARCHAR(50)   ENCODE lzo
	,lattitude VARCHAR(50)   ENCODE lzo
	,longitude VARCHAR(50)   ENCODE lzo
	,start_date timestamp,
  end_date timestamp,
  flag int ,
  loadtimestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  loaduserid varchar(50) encode lzo default null
);

CREATE TABLE IF NOT EXISTS  DWH.dim_destairport
(
  destairportkey int primary key,
	iata VARCHAR(50)   ENCODE lzo
	,airportname VARCHAR(50)   ENCODE lzo
	,city VARCHAR(50)   ENCODE lzo
	,state VARCHAR(50)   ENCODE lzo
	,country VARCHAR(50)   ENCODE lzo
	,lattitude VARCHAR(50)   ENCODE lzo
	,longitude VARCHAR(50)   ENCODE lzo
	,start_date timestamp,
  end_date timestamp,
  flag int ,
  loadtimestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  loaduserid varchar(50) encode lzo default null
);

CREATE TABLE  DWH.dim_plane
(
  planekey integer primary key   ENCODE lzo,
  tailnum character varying(20) NOT NULL  ENCODE lzo,
  planetype character varying(20)  ENCODE lzo,
  manufacturer character varying(50)  ENCODE lzo,
  issuedate date  ENCODE lzo,
  model character varying(20)  ENCODE lzo,
  status character varying(20)  ENCODE lzo,
  aircrafttype character varying(50)  ENCODE lzo,
  enginetype character varying(15)  ENCODE lzo,
  mfgyear character varying(4)  ENCODE lzo,
  loadtimestamp timestamp without time zone DEFAULT current_timestamp  ENCODE lzo,
  loaduserid varchar(50)  ENCODE lzo
);

CREATE TABLE DWH.dim_date
(
  datekey integer primary key,
  fulldatealternatekey date NOT NULL,
  daynumberofweek smallint NOT NULL,
  daynameofweek character varying(10) NOT NULL,
  daynumberofmonth smallint NOT NULL,
  daynumberofyear smallint NOT NULL,
  weeknumberofyear smallint NOT NULL,
  monthname character varying(10) NOT NULL,
  monthnumberofyear smallint NOT NULL,
  calendarquarter smallint NOT NULL,
  calendarsemester smallint NOT NULL,
  calendaryear smallint NOT NULL,
  loadtimestamp timestamp without time zone NOT NULL DEFAULT now(),
  loaduserid varchar(50)
 
);

CREATE TABLE  DWH.fact_ontime
(
  fact_key integer ,
  fk_carrier_key integer,
  fk_planekey integer,
  fk_orgairportkey integer,
  fk_destairportkey integer,
  fk_datekey integer,
  flight_year integer,
  flightmonth integer,
  dayofmonth integer,
  dayofweek integer,
  deptime integer,
  crsdeptime integer,
  arrtime integer,
  crsarrtime integer,
  uniquecarrier character varying(20),
  flightnum integer,
  tailnum character varying(20),
  actualelapsedtime integer,
  crselapsedtime integer,
  airtime integer,
  arrdelay integer,
  depdelay integer,
  origin character varying(20),
  dest character varying(20),
  distance integer,
  taxiin integer,
  taxiout integer,
  cancelled integer DEFAULT 0,
  cancellationcode character varying(20),
  diverted integer DEFAULT 0,
  carrierdelay character varying(20),
  weatherdelay character varying(20),
  nasdelay character varying(20),
  securitydelay character varying(20),
  lateaircraftdelay character varying(20),
  loadtimestamp timestamp without time zone DEFAULT current_timestamp,
  loaduserid varchar(50),
  CONSTRAINT fact_key_primary PRIMARY KEY (fact_key)
);
DISTSTYLE KEY
DISTKEY(flight_year);
