SELECT supplier.s_name, count(part.p_partkey)
FROM part
INNER JOIN nation ON nation.n_nationkey = supplier.s_nationkey
INNER JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
INNER JOIN partsupp ON part.p_partkey = partsupp.ps_partkey
WHERE (part.p_size < 20 AND nation.n_name = "CANADA")
GROUP BY supplier.s_suppkey