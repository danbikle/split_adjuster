--
-- ~/sa/oracle/cr_ydata.sql
--

-- I use this script to create table ydata which holds price data from yahoo.

CREATE TABLE ydata
(
tkr VARCHAR2(9)
,ydate   DATE
,opn     NUMBER
,mx      NUMBER
,mn      NUMBER
,closing_price NUMBER
,vol     NUMBER
,adjclse NUMBER
,closing_price_orig NUMBER
)
;
