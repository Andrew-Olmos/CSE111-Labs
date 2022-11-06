SELECT n_name, COUNT(DISTINCT customer.c_name), COUNT(DISTINCT supplier.s_name)
FROM nation, region, supplier, customer
WHERE(
    customer.c_nationkey = nation.n_nationkey AND
    supplier.s_nationkey = nation.n_nationkey AND
    nation.n_regionkey = region.r_regionkey AND
    region.r_name == 'AFRICA'
)
GROUP BY nation.n_name