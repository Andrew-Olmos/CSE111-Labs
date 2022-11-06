select nation.n_name
from nation, region, supplier, lineitem, orders
where (
    nation.n_regionkey = region.r_regionkey AND
    supplier.s_suppkey = lineitem.l_suppkey AND
    lineitem.l_orderkey = orders.o_orderkey AND
    supplier.s_nationkey = nation.n_nationkey AND
    lineitem.l_shipdate BETWEEN '1994-00-00' AND '1994-12-32'
)
GROUP BY nation.n_name
ORDER BY sum(lineitem.l_extendedprice) DESC
LIMIT 1