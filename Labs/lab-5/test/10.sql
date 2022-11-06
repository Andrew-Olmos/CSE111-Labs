SELECT region.r_name, COUNT(DISTINCT customer.c_name)
FROM customer, orders, region, nation
WHERE (
    customer.c_nationkey = nation.n_nationkey AND
    nation.n_regionkey = region.r_regionkey AND
    customer.c_custkey NOT IN (SELECT orders.o_custkey FROM orders) AND -- comparing custKeys with orderKeys
    customer.c_acctbal < (SELECT AVG(c_acctbal) FROM customer) -- seeing if c_acctbal is less than the avg acct bal
)
GROUP BY region.r_name