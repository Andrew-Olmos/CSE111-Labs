select min(lineitem.l_discount)
from lineitem
inner join orders on orders.o_orderkey = lineitem.l_orderkey
where (
    substr(orders.o_orderdate, 1, 7 ) = "1996-10" AND
    lineitem.l_discount > (
        select avg(lineitem.l_discount)
        from lineitem, orders
        where (
            orders.o_orderkey = lineitem.l_orderkey
        )
    )
)