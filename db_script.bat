rem Create the database and the tables
set SQLITE=C:\Users\guilh\Applications\SQLite\sqlite3.exe
rem winget install SQLite.SQLite
%SQLITE% .\db\meteomarche.db < .\sql\db_structures.sql
