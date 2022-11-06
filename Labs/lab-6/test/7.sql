SELECT COUNT(*)
FROM supplier
WHERE supplier.s_name IN(
    SELECT supplier.s_name 
    FROM nation, supplier, orders, customer, lineitem 
    WHERE 
    supplier.s_suppkey = lineitem.l_suppkey AND
    lineitem.l_orderkey = orders.o_orderkey AND
    orders.o_custkey = customer.c_custkey AND
    customer.c_nationkey = nation.n_nationkey AND
    nation.n_name IN ('GERMANY', 'FRANCE') 
    GROUP BY supplier.s_name
    HAVING COUNT(orders.o_orderkey) <= 50
)