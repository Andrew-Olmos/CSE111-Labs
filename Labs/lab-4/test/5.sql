SELECT customer.c_name, count(orders.o_orderkey)
FROM orders
INNER JOIN customer ON orders.o_custkey = customer.c_custkey
INNER JOIN nation on nation.n_nationkey = customer.c_nationkey
WHERE
nation.n_name = "GERMANY" AND substr(orders.o_orderdate, 1, 4)="1993"
GROUP BY customer.c_custkey;