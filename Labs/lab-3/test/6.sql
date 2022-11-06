SELECT DISTINCT nation.n_name
FROM orders
INNER JOIN customer ON orders.o_custkey = customer.c_custkey
INNER JOIN nation ON customer.c_nationkey = nation.n_nationkey
WHERE (o_orderdate = "1994-09-09" AND o_orderdate = "1994-09-11");