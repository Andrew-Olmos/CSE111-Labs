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

    f = open('1.out', 'w')
    for i in myCur:
        j = ("{:>10} {:>10} {:>30}".format(i[0], i[1], i[2], i[3], i[4]))
        print(j)
        f.write(j)
    f.close()
        
        
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    cur = _conn.cursor()
    cur.execute(f"""
        SELECT n_name, COUNT(warehouse.w_warehousekey), SUM(warehouse.w_capacity)
        FROM nation, warehouse
        WHERE 
            n_nationkey = w_nationkey
        """)
    myCur = cur.fetchall()

    f = open('2.out', 'w')
    for i in myCur:
        j = ("{:>10} {:>10} {:>30}".format(i[0], i[1], i[2]))
        print(j)
        f.write(j)
    f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

       # Q1(conn)
        Q2(conn)
       #Q3(conn)
        #Q4(conn)
        #Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
