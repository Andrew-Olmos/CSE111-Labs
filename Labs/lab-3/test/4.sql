SELECT count(l_orderkey)
FROM lineitem
WHERE (l_shipdate = l_commitdate);