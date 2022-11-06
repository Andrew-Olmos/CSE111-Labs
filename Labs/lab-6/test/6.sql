select supplier.s_name, customer.c_name, orders.o_totalprice
from supplier, orders, customer, lineitem
where (
    customer.c_custkey = orders.o_custkey AND
    lineitem.l_orderkey = orders.o_orderkey AND
    lineitem.l_suppkey = supplier.s_suppkey AND
    orders.o_totalprice = (
        select min(orders.o_totalprice)
        from supplier, orders, customer, lineitem
        where (
            customer.c_custkey = orders.o_custkey AND
            lineitem.l_orderkey = orders.o_orderkey AND
            lineitem.l_suppkey = supplier.s_suppkey AND
            orders.o_orderstatus = 'F'
        )
    )
)