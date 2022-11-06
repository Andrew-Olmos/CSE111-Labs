SELECT count(DISTINCT(orders.o_clerk))
from orders, supplier, nation, lineitem
where (supplier.s_nationkey = nation.n_nationkey AND 
        nation.n_name = "UNITED STATES" AND
        lineitem.l_orderkey = orders.o_orderkey AND
        lineitem.l_suppkey = supplier.s_suppkey)
