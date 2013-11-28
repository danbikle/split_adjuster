oracle/readme_authentication.txt

To setup my authentication for Oracle I follow these steps:

First, I understand that I must have access to the database host.

I depend on sqlldr to load data.

According to my experience, sqlldr needs to run on database host.

If I am running Oracle in a Linux VM on my laptop, then I am all set.

After I login to the database host, I find out which account owns/runs
the Oracle server.

Usually that account is oracle.

Next, I login to that account using either
ssh oracle@localhost
or
su - oracle

Then, I connect to the server with a shell command like this:

sqlplus '/as sysdba'

Then I issue a command to create a user account inside of Oracle.

I use syntax like this:

GRANT DBA TO trade IDENTIFIED BY t;

Then I exit sqlplus.

Next I test that I can connect to Oracle using a shell command like this:

sqlplus trade/t

I should see something like this:


oracle@z3:~/sa$ 
oracle@z3:~/sa$ sqlplus trade/t

SQL*Plus: Release 11.2.0.1.0 Production on Thu Nov 28 06:50:46 2013

Copyright (c) 1982, 2009, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

06:50:46 SQL> ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

Session altered.

Elapsed: 00:00:00.00
06:50:46 SQL> 
06:50:49 SQL> exit
Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
oracle@z3:~/sa$ 
oracle@z3:~/sa$ 
