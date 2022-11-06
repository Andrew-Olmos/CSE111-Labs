SELECT part.p_name
FROM partsupp, supplier, nation, part, region
WHERE
supplier.s_nationkey = nation.n_nationkey AND
region.r_regionkey = nation.n_regionkey AND
supplier.s_suppkey = partsupp.ps_suppkey AND
partsupp.ps_partkey = part.p_partkey AND
nation.n_name = 'UNITED STATES' AND
partsupp.ps_supplycost * partsupp.ps_availqty =
    (SELECT (partsupp.ps_supplycost * partsupp.ps_availqty )
    FROM partsupp, supplier, nation, part, region
    where 
        supplier.s_nationkey = nation.n_nationkey AND
        region.r_regionkey = nation.n_regionkey AND
        supplier.s_suppkey = partsupp.ps_suppkey AND
        partsupp.ps_partkey = part.p_partkey AND
        nation.n_name = 'UNITED STATES' 
ORDER BY partsupp.ps_supplycost * partsupp.ps_availqty DESC LIMIT (
    SELECT COUNT(*) * 0.01 FROM partsupp))