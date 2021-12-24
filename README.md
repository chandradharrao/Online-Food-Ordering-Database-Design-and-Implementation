# DBMS UE19CS301 Course Project Online Food Ordering System using PERN stack ie PostgreSQL,Express,Ract and Node.

1) How to setup the project?
- Clone the repository
- Remove the package.lock.json from both server and client
- Then do *npm install*.
- Run *npm start* to run.

2) How to use *insert_script_maker.py* file?
- Make one csv file for each of the table with the nomenclature <table_name_here>.csv
- First row of csv file is the table headers (except for the *BIGSERIAL* type column which should be ignored)
- Fill in all the values in the csv
- Finally refer to the schema for the sequence of insertion and in the *order* list in *insert_Script_maker.py* file,append the order
- Run the *.py* file to create *relational_Schema_insert.sql* file
