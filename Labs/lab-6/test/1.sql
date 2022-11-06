select strftime('%m', l_shipdate), sum(l_quantity)
from lineitem
where (
    lineitem.l_shipdate BETWEEN '1995-01-01' AND '1995-12-31'
)
group by strftime('%m', l_shipdate)