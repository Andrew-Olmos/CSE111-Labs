SELECT COUNT(DISTINCT orders.o_custkey)
FROM orders, customer
WHERE
customer.c_custkey = orders.o_custkey AND
orders.o_orderkey NOT IN 
(SELECT DISTINCT o_orderkey 
FROM orders, region
inner join lineitem on lineitem.l_suppkey = supplier.s_suppkey
inner join nation on nation.n_regionkey = region.r_regionkey
inner join supplier on supplier.s_nationkey = nation.n_nationkey
WHERE 
    orders.o_orderkey = lineitem.l_orderkey AND  
    region.r_name NOT IN('AMERICA')
    )