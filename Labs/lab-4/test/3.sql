SELECT nation.n_name, count(orders.o_orderkey)
FROM orders
INNER JOIN customer on orders.o_custkey = customer.c_custkey
INNER JOIN nation on nation.n_nationkey = customer.c_nationkey
INNER JOIN region on nation.n_regionkey = region.r_regionkey
WHERE region.r_name = "AMERICA"
GROUP BY nation.n_nationkey