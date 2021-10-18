import csv

#first time when script is run
f=open("relational_Schema_insert.sql","w")
f.write('\c foodsystem\n')
f.close()

#exe order
order = ['Address','Customer','Restaurant_admin','Dish_category','Dish','Cooks']


for c0,file in enumerate(order):
    try:
        f = open(f"{file}.csv")
        reader = csv.reader(f)
        header = next(reader)

        headings = ''
        for c,i in enumerate(header):
            if c!= len(header)-1:
                i+=','
            headings+=i

        rows = []
        for row in reader:
            rows.append(row)

        values = ''
        for c1,row in enumerate(rows):
            res = '('
            for c2,i in enumerate(row):
                if c2 != len(row)-1:
                    res += f'{i},'
                else:
                    res += f'{i})'
            if c1 != len(rows)-1:
                res += ',\n\t'
            else:
                res += ';'
            values += res

        cmd = f'''INSERT INTO\n\t{file} ({headings})\nVALUES\n\t{values}\n'''

        f1 = open("relational_Schema_insert.sql","a")
        f1.write(cmd)
        f1.close()
        print(f"Finished inserting values into {file}")

    except:
        print("File not found,skipping...")

        
        