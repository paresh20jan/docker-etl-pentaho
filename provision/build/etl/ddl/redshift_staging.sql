Create schema stg;

Create schema dwh;

CREATE TABLE IF NOT EXISTS stg.stg_airports
(
	iata VARCHAR(50)   ENCODE lzo
	,airport VARCHAR(50)   ENCODE lzo
	,city VARCHAR(50)   ENCODE lzo
	,state VARCHAR(50)   ENCODE lzo
	,country VARCHAR(50)   ENCODE lzo
	,lat VARCHAR(50)   ENCODE lzo
	,long VARCHAR(50)   ENCODE lzo
);

CREATE TABLE IF NOT EXISTS stg.stg_carriers
(
	code VARCHAR(50)   ENCODE lzo
	,description VARCHAR(200)   ENCODE lzo
);


CREATE TABLE IF NOT EXISTS stg.stg_ontime
(
	"year" VARCHAR(50)   ENCODE lzo
	,"month" VARCHAR(50)   ENCODE lzo
	,dayofmonth VARCHAR(50)   ENCODE lzo
	,dayofweek VARCHAR(50)   ENCODE lzo
	,deptime VARCHAR(50)   ENCODE lzo
	,crsdeptime VARCHAR(50)   ENCODE lzo
	,arrtime VARCHAR(50)   ENCODE lzo
	,crsarrtime VARCHAR(50)   ENCODE lzo
	,uniquecarrier VARCHAR(50)   ENCODE lzo
	,flightnum VARCHAR(50)   ENCODE lzo
	,tailnum VARCHAR(50)   ENCODE lzo
	,actualelapsedtime VARCHAR(50)   ENCODE lzo
	,crselapsedtime VARCHAR(50)   ENCODE lzo
	,airtime VARCHAR(50)   ENCODE lzo
	,arrdelay VARCHAR(50)   ENCODE lzo
	,depdelay VARCHAR(50)   ENCODE lzo
	,origin VARCHAR(50)   ENCODE lzo
	,dest VARCHAR(50)   ENCODE lzo
	,distance VARCHAR(50)   ENCODE lzo
	,taxiin VARCHAR(50)   ENCODE lzo
	,taxiout VARCHAR(50)   ENCODE lzo
	,cancelled VARCHAR(50)   ENCODE lzo
	,cancellationcode VARCHAR(50)   ENCODE lzo
	,diverted VARCHAR(50)   ENCODE lzo
	,carrierdelay VARCHAR(50)   ENCODE lzo
	,weatherdelay VARCHAR(50)   ENCODE lzo
	,nasdelay VARCHAR(50)   ENCODE lzo
	,securitydelay VARCHAR(50)   ENCODE lzo
	,lateaircraftdelay VARCHAR(50)   ENCODE lzo
);

CREATE TABLE IF NOT EXISTS stg.stg_planes
(
	tailnum VARCHAR(50)   ENCODE lzo
	,"type" VARCHAR(50)   ENCODE lzo
	,manufacturer VARCHAR(50)   ENCODE lzo
	,issue_date DATE   ENCODE lzo
	,model VARCHAR(50)   ENCODE lzo
	,status VARCHAR(50)   ENCODE lzo
	,aircraft_type VARCHAR(50)   ENCODE lzo
	,engine_type VARCHAR(50)   ENCODE lzo
	,"year" VARCHAR(50)   ENCODE lzo
);


