select region.r_name
from region, lineitem, nation, supplier, orders, customer
where (
    nation.n_nationkey = supplier.s_nationkey AND
    nation.n_regionkey = region.r_regionkey AND
    lineitem.l_orderkey = orders.o_orderkey AND
    lineitem.l_suppkey = supplier.s_suppkey AND
    customer.c_nationkey = supplier.s_nationkey AND
    customer.c_custkey = orders.o_custkey
)
group by region.r_name
ORDER BY MIN(lineitem.l_extendedprice) DESC
LIMIT 1