~/sa/postgres/readme_authentication.txt

Postgres offers me a variety of ways to authorize myself to the server.

If I am working in a Linux account named dan,
I follow these steps ensure my authentication will be easy:

First, I login to the postgres linux account using either

ssh postgres@localhost
or
su - postgres

After I am in the postgres linux account,
I type in the command:

psql

Then I use the three commands listed below:

CREATE USER dan SUPERUSER;
ALTER  USER dan PASSWORD 'dan';
CREATE DATABASE dan;

Then I logout of psql.
And  I logout of postgres Linux account.
I login to linux as dan.

I try this command:

psql

The above command should connect me to the Postgres server as dan.
And any tables I create will land in the dan database.
