SELECT part.p_name
FROM lineitem, part
WHERE
lineitem.l_partkey = part.p_partkey AND
lineitem.l_shipdate > julianday(1996-10-02) AND
lineitem.l_extendedprice * (1 - lineitem.l_discount) = 
(
select MIN(lineitem.l_extendedprice * (1 - lineitem.l_discount)) 
from lineitem, part
where 
lineitem.l_partkey = part.p_partkey and
lineitem.l_shipdate > julianday(1996-10-02)
)