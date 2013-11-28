#!/bin/bash

# ~/sa/wget_ydata.bash

# I use this script to wget some yahoo stock prices.

mkdir -p /tmp/ydata/
cd       /tmp/ydata/

wget --output-document=DD.csv  http://ichart.finance.yahoo.com/table.csv?s=DD
wget --output-document=DIS.csv http://ichart.finance.yahoo.com/table.csv?s=DIS
wget --output-document=IBM.csv http://ichart.finance.yahoo.com/table.csv?s=IBM
wget --output-document=KO.csv  http://ichart.finance.yahoo.com/table.csv?s=KO

exit
