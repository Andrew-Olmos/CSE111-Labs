SELECT c_mktsegment, sum(c_acctbal)
FROM customer
GROUP BY c_mktsegment;