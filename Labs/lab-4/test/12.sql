select nation.n_name, max(supplier.s_acctbal)
from supplier, nation, region, lineitem
where ( nation.n_nationkey = supplier.s_nationkey AND
        region.r_regionkey = nation.n_regionkey AND
        lineitem.l_suppkey = supplier.s_suppkey AND
        supplier.s_acctbal > 9000)
group by nation.n_name