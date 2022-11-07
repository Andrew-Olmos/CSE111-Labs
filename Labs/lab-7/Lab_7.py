import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")
    try:
        sql = """CREATE TABLE warehouse (
                    w_warehousekey decimal(9,0) NOT NULL,
                    w_name char(100) NOT NULL,
                    w_capacity decimal(6,0) NOT NULL,
                    w_suppkey decimal(9,0) NOT NULL,
                    w_nationkey decimal(2,0) NOT NULL) """
        _conn.execute(sql)

        _conn.commit()
    except Error as e:
        _conn.rollback()
        print("create table error:", e)

    print("Create table: success")
    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")

    try:
        sql = "DROP TABLE warehouse"
        _conn.execute(sql)

        _conn.commit()
        print("Drop Table: success")

    except Error as e:
        _conn.rollback()
        print("drop table error: ",e)

    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")

    cur = _conn.cursor()
    cur.execute("Select s_suppkey FROM supplier")
    suppkeys = cur.fetchall()
    counter = 1
    for suppkey in suppkeys:
        cur.execute(f"""
            SELECT n_nationkey, n_name, s_suppkey, s_name, 
                    count(*) as cnt, sum(p_size) as capacity
            FROM supplier, lineitem, part, orders, customer, nation
            WHERE
                l_suppkey = s_suppkey AND
                l_partkey = p_partkey AND
                l_orderkey = o_orderkey AND
                c_custkey = o_custkey AND
                n_nationkey = c_nationkey AND
                s_suppkey = "{suppkey[0]}"
            GROUP BY n_nationkey
            ORDER BY cnt DESC, n_name
        """)
        results = cur.fetchall()
        nationkey1, cname1, suppkey1, sname1, __, _ = results[0]
        nationkey2, cname2, suppkey2, sname2, __, _ = results[1]

        wname1 = f"{sname1}___{cname1}"
        wname2 = f"{sname2}___{cname2}"

        maxCap = max([result[-1] for result in results])
        sharedCap = maxCap*2
        cur.execute(f""" INSERT INTO warehouse VALUES ({counter}, "{wname1}", {sharedCap}, {suppkey1}, {nationkey1}); """)
        cur.execute(f""" INSERT INTO warehouse VALUES ({counter+1}, "{wname2}", {sharedCap}, {suppkey2}, {nationkey2}); """)
        counter +=2

    print("++++++++++++++++++++++++++++++++++")

#Q1 Done
def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    cur = _conn.cursor()
    cur.execute(f"""
        SELECT *
        FROM warehouse
        ORDER BY w_warehousekey
        """)
    myCur = cur.fetchall()
    f = open('output/1.out', 'w')
    f.write("{:>10} {:>10} {:>40} {:>10} {:>10} \n".format("wId", "wName", "wCap", "sId", "nId"))
    for i in myCur:
        j = ("{:>10} {:>10} {:>20} {:>10} {:>10} \n".format(i[0], i[1], i[2], i[3], i[4]))
        f.write(j)
    f.close()
        
        
    print("++++++++++++++++++++++++++++++++++")

#Q2 Done
def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    cur = _conn.cursor()
    cur.execute(f"""
        SELECT n_name, COUNT(w_warehousekey), SUM(w_capacity)
        FROM nation, warehouse
        WHERE
            w_nationkey = n_nationkey 
        GROUP BY n_name
        ORDER BY COUNT(w_warehousekey) DESC, SUM(w_capacity) DESC;""")
    myCur = cur.fetchall()

    f = open('output/2.out', 'w')
    f.write("{:>10} {:>10} {:>30} \n".format("nation", "numW", "totCap"))
    for i in myCur:
        j = ("{:>10} {:>10} {:>30} \n".format(i[0], i[1], i[2]))
        #print(j)
        f.write(j)
    f.close()

    print("++++++++++++++++++++++++++++++++++")

#Q3 Done
def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    
    with open("input/3.in","r") as g:
        nation = g.read()
    cur = _conn.cursor()
    cur.execute(f'''
        SELECT s_name, N2.n_name, w_name
        FROM supplier, nation N1, nation N2, warehouse, region
        WHERE
            N1.n_regionkey = r_regionkey AND
            s_suppkey = w_suppkey AND
            w_nationkey = N1.n_nationkey AND
            s_nationkey = N2.n_nationkey AND
            N1.n_name = '{nation}'
        ''')
    myCur = cur.fetchall()

    f = open('output/3.out', 'w')
    f.write("{:>0} {:>20} {:>20} \n".format("supplier", "nation", "warehouse"))
    for i in myCur:
        j = ("{:>10} {:>10} {:>30} \n".format(i[0], i[1], i[2]))
        print(j)
        f.write(j)
    f.close()

    print("++++++++++++++++++++++++++++++++++")

#Q4 done, figure out writing inputs
def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    
    for i in (0,2):    
        with open("input/3.in","r") as g:
            nation = g.readline()
            capacity = g.readline()
    print(nation)
    cur = _conn.cursor()
    cur.execute(f'''
        SELECT w_name, w_capacity
        FROM warehouse, region, nation
        WHERE
            r_name = '{nation}' AND
            r_regionkey = n_regionkey AND
            n_nationkey = w_nationkey
        GROUP BY w_name
        HAVING w_capacity > '{capacity}'
        ORDER BY w_capacity DESC
        ''')
    myCur = cur.fetchall()

    f = open('output/4.out', 'w')
    f.write("{:>10} {:>40}\n".format("warehouse", "capacity"))
    for i in myCur:
        j = ("{:>10} {:>20} \n".format(i[0], i[1]))
        print(j)
        f.write(j)
    f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    
    with open("input/5.in","r") as g:
        nation = g.read().splitlines()
    #print(nation)
    cur = _conn.cursor()
    cur.execute(f'''
        SELECT w_name, w_capacity
        FROM warehouse, region, nation
        WHERE
            r_name = 'ASIA' AND
            r_regionkey = n_regionkey AND
            n_nationkey = w_nationkey
        GROUP BY w_name
        HAVING w_capacity > 2000
        ORDER BY w_capacity DESC
        ''')
    myCur = cur.fetchall()

    f = open('output/4.out', 'w')
    f.write("{:>10} {:>40}\n".format("warehouse", "capacity"))
    for i in myCur:
        j = ("{:>10} {:>20} \n".format(i[0], i[1]))
        #print(j)
        f.write(j)
    f.close()

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        #Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
