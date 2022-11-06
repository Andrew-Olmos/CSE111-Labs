#Tyler Armstrong
#Sept 11
all: 
	./test.sh

sql: 
	sqlite3 tpch.sqlite

sql1: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/1.sql"
	make -s expect
	make -s sql1res

sql1res: 
	cat results/1.res 

sql2: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/2.sql"
	make -s expect
	make -s sql2res

sql2res: 
	cat results/2.res 

sql3: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/3.sql"
	make -s expect
	make -s sql3res

sql3res: 
	cat results/3.res 

sql4: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/4.sql"
	make -s expect
	make -s sql4res

sql4res: 
	cat results/4.res 

sql5:
	make -s youres
	sqlite3 tpch.sqlite ".read test/5.sql"
	make -s expect
	make -s sql5res

sql5res: 
	cat results/5.res 

sql6: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/6.sql"
	make -s expect
	make -s sql6res

sql6res: 
	cat results/6.res 

sql7: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/7.sql"
	make -s expect
	make -s sql7res

sql7res: 
	cat results/7.res 

sql8: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/8.sql"
	make -s expect
	make -s sql8res

sql8res: 
	cat results/8.res 

sql9: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/9.sql"
	make -s expect
	make -s sql9res

sql9res: 
	cat results/9.res 

sql10: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/10.sql"
	make -s expect
	make -s sql10res

sql10res: 
	cat results/10.res 

sql11: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/11.sql"
	make -s expect
	make -s sql11res

sql11res: 
	cat results/11.res 

sql12: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/12.sql"
	make -s expect
	make -s sql12res

sql12res: 
	cat results/12.res 

sql13: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/13.sql"
	make -s expect
	make -s sql13res

sql13res: 
	cat results/14.res 

sql14: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/14.sql"
	make -s expect
	make -s sql14res

sql14res: 
	cat results/14.res 

sql15: 
	make -s youres
	sqlite3 tpch.sqlite ".read test/15.sql"
	make -s expect
	make -s sql15res

sql15res: 
	cat results/15.res 

youres:
	$(info ===================Your test output===================)

expect:
	$(info ===================Expected output====================)