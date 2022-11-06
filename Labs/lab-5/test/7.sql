SELECT orders.o_orderpriority, COUNT(orders.o_orderkey)
FROM orders, lineitem
WHERE(
    orders.o_orderkey == lineitem.l_orderkey AND
    (julianday(lineitem.l_receiptdate) - julianday(lineitem.l_commitdate)) > 0 AND
    orders.o_orderdate BETWEEN '1997-00-00' AND '1997-12-31' --entire year of 1997
)
GROUP BY orders.o_orderpriority