SELECT supplier.s_name, part.p_size, MIN(partsupp.ps_supplycost)
FROM supplier, partsupp, part, nation, region
WHERE(
    region.r_regionkey = nation.n_regionkey AND
    nation.n_nationkey = supplier.s_nationkey AND
    supplier.s_suppkey = partsupp.ps_suppkey AND
    partsupp.ps_partkey = part.p_partkey AND
    part.p_type LIKE '%STEEL%' AND
    region.r_name = 'ASIA' 
)
GROUP BY p_size
ORDER BY s_name