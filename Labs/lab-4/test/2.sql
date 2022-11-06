SELECT region.r_name, count(supplier.s_suppkey)
from supplier
INNER JOIN nation ON nation.n_nationkey = supplier.s_nationkey
INNER JOIN region ON region.r_regionkey = nation.n_regionkey
GROUP BY region.r_regionkey