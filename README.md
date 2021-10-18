# Online-Food-Ordering-Database-Design-and-Implementation

1) How to use *insert_script_maker.py* file?
- Make one csv file for each of the table with the nomenclature <table_name_here>.csv
- First row of csv file is the table headers (except for the *BIGSERIAL* type column which should be ignored)
- Fill in all the values in the csv
- Finally refer to the schema for the sequence of insertion and in the *order* list in *insert_Script_maker.py* file,append the order
- Run the *.py* file to create *relational_Schema_insert.sql* file
