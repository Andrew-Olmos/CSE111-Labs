SELECT orders.o_orderpriority, COUNT(DISTINCT orders.o_orderkey)
FROM orders, lineitem
WHERE
(julianday(l_commitdate) - julianday(l_receiptdate)) > 0 AND -- if greater than 0 then received earlier
orders.o_orderdate BETWEEN '1997-10-00' AND '1997-12-31' AND --4th quarter
lineitem.l_orderkey = orders.o_orderkey
GROUP BY orders.o_orderpriority