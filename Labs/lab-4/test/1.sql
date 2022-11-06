SELECT customer.c_name, sum(orders.o_totalprice)
FROM customer
INNER JOIN nation ON customer.c_nationkey = nation.n_nationkey
INNER JOIN orders ON orders.o_custkey = customer.c_custkey
WHERE(substr(orders.o_orderdate, 1, 4) = "1995" AND nation.n_name = "FRANCE")
GROUP BY orders.o_custkey