#!/bin/bash

# ~/sa/oracle/load_ydata.bash

# I use this script to load data from CSV files into table, ydata.

# This script is only a demo.
# If I want to load hundreds of tickers, instead of just four,
# I use SQL to build a script and then I run that.

# I already ran the wget script below so I comment it out.
# You might find it useful to run it here:
# ~/sa/wget_ydata.bash
# If you did run the above wget script,
# you should have four CSV files in /tmp/ydata/

# I add tkr values to the CSV data and create one large CSV file.

rm -f /tmp/ydata/ydata.csv
grep -v Date /tmp/ydata/DD.csv  | sed '1,$s/^/DD,/'  >> /tmp/ydata/ydata.csv
grep -v Date /tmp/ydata/DIS.csv | sed '1,$s/^/DIS,/' >> /tmp/ydata/ydata.csv
grep -v Date /tmp/ydata/IBM.csv | sed '1,$s/^/IBM,/' >> /tmp/ydata/ydata.csv
grep -v Date /tmp/ydata/KO.csv  | sed '1,$s/^/KO,/'  >> /tmp/ydata/ydata.csv

echo 'Here is head and tail of the CSV file I want to load:'
head -3 /tmp/ydata/ydata.csv
tail -3 /tmp/ydata/ydata.csv

# Assume I have an Oracle user created with this SQL command:
# GRANT DBA TO trade IDENTIFIED BY t;
# Assume I used that user to create 
# a table named ydata using this script: cr_ydata.sql

# Time to call sqlldr, 
# assume that ydata.ctl is in my current working directory (CWD).
# I like to work in this directory: ~/sa/oracle/
# useful shell command:    mkdir -p ~/sa/oracle/
sqlldr trade/t bindsize=20971520 readsize=20971520 rows=123456 control=ydata.ctl log=/tmp/ydata/ydata.log.txt bad=/tmp/ydata/ydata.bad.txt

echo 'Here is the load report:'
grep loaded /tmp/ydata/ydata.log.txt

sqlplus trade/t <<EOF
SELECT MIN(ydate),COUNT(tkr),MAX(ydate) FROM ydata;

SELECT tkr, MIN(ydate),COUNT(tkr),MAX(ydate) FROM ydata GROUP BY tkr ORDER BY tkr ;
EOF

# Since I am about to UPDATE the closing_price column,
# I will backup the data in it.
echo 'The command below should issue an error:'
echo 'ORA-00942: table or view does not exist'
sqlplus trade/t <<EOF
DROP   TABLE ydata_copy;
-- Above command should give error:
-- ORA-00942: table or view does not exist

CREATE TABLE ydata_copy COMPRESS AS
SELECT
tkr
,ydate   
,opn     
,mx      
,mn      
,closing_price
,vol     
,adjclse 
,closing_price AS closing_price_orig
FROM ydata
ORDER BY tkr,ydate
;

DROP   TABLE ydata;
RENAME ydata_copy TO ydata;

EOF


# So, now I have the data loaded.  Usually my next step is to cd ../
# and call 
#  ../cr_upd_cp.bash 
# to create 
#  ../update_closing_price.sql.
# Then, I call update_closing_price.sql to UPDATE closing_price in ydata.

# Another thing I might do is look for abrupt, abnormal 
# changes in closing_price using ../qry_abrupt.sql
# After I UPDATE, those abrupt changes (due to stock splits) 
# should be gone.

exit
