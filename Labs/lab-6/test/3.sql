select count(*)
from part
where (
    part.p_name IN 
    (
        select part.p_name
        from part, supplier, nation, region, partsupp
        where(
            region.r_regionkey = nation.n_regionkey AND
            supplier.s_nationkey = nation.n_nationkey AND
            partsupp.ps_suppkey = supplier.s_suppkey AND
            partsupp.ps_partkey = part.p_partkey AND
            nation.n_name = 'UNITED STATES'
        )
        GROUP BY part.p_name
        HAVING count(*) = 2
    )
)