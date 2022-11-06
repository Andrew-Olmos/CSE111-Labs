SELECT nation.n_name, count(DISTINCT(orders.o_orderkey))
FROM customer, nation, orders
WHERE ( customer.c_nationkey = nation.n_nationkey AND
        orders.o_custkey = customer.c_custkey AND
        substr(orders.o_orderdate, 1, 4) = "1995")
GROUP BY orders.o_custkey