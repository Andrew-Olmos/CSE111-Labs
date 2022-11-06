select nation.n_name
from nation, customer, orders
where
nation.n_nationkey = customer.c_nationkey AND
orders.o_custkey = customer.c_custkey
group by nation.n_name
having count(orders.o_totalprice) = (
    Select count(orders.o_totalprice)
    from customer, nation, orders
    where
    nation.n_nationkey = customer.c_nationkey AND
    orders.o_custkey = customer.c_custkey
    group by nation.n_name
    order by count(orders.o_totalprice) asc
    limit 1
)