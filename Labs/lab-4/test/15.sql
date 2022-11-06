select count(DISTINCT(orders.o_orderkey))
from orders, supplier, customer, lineitem
where (customer.c_acctbal > 0 AND
        supplier.s_acctbal < 0 AND
        orders.o_custkey = customer.c_custkey AND
        lineitem.l_suppkey = supplier.s_suppkey AND
        lineitem.l_orderkey = orders.o_orderkey)
