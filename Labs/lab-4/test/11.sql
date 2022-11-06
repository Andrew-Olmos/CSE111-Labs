select region.r_name, supplier.s_name, max(supplier.s_acctbal)
from supplier
INNER JOIN nation ON nation.n_nationkey = supplier.s_nationkey
INNER JOIN region ON region.r_regionkey = nation.n_regionkey
where (supplier.s_acctbal)
group by region.r_name