select count(distinct(supplier.s_name))
from supplier, part, partsupp
where (
    partsupp.ps_partkey = part.p_partkey AND
    supplier.s_suppkey = partsupp.ps_suppkey AND
    part.p_retailprice = (
        select MAX(part.p_retailprice)
        from part, supplier, partsupp
        where (
            partsupp.ps_partkey = part.p_partkey AND
            supplier.s_suppkey = partsupp.ps_suppkey
        )
    )
)