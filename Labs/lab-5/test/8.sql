SELECT COUNT(DISTINCT s_name)
FROM supplier, partsupp, part
WHERE (
    p_size IN (3, 23, 36, 49) AND
    s_suppkey == ps_suppkey AND
    ps_partkey == p_partkey AND
    p_type LIKE '%POLISHED%'
)