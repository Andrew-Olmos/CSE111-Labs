SELECT supplier.s_name, orders.o_orderpriority, count(part.p_partkey)
FROM part, nation, supplier, partsupp, orders
WHERE (nation.n_nationkey = supplier.s_nationkey AND
        partsupp.ps_suppkey = supplier.s_suppkey AND
        part.p_partkey = partsupp.ps_partkey AND
        nation.n_name = "CANADA")
GROUP BY supplier.s_name
