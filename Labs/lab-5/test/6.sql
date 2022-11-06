select part.p_mfgr
from part, partsupp, supplier
WHERE(
    part.p_partkey = partsupp.ps_partkey and 
    partsupp.ps_suppkey = supplier.s_suppkey and 
    supplier.s_name = "Supplier#000000010" and
    partsupp.ps_availqty = (
        select min(partsupp.ps_availqty)
        from part, partsupp, supplier
        where (
            part.p_partkey = partsupp.ps_partkey and 
            partsupp.ps_suppkey = supplier.s_suppkey and 
            supplier.s_name = "Supplier#000000010"
        )
    )
)