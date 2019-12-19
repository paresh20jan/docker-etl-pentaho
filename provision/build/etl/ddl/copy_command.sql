COPY stg.stg_carriers
from 's3://cybctgpareshairline/carriers.csv'
iam_role 'arn:aws:iam::795914468022:role/Paresh_RedShift'
csv
null as '\000'
IGNOREHEADER 1

