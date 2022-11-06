select nation.n_name
from nation, customer
where
nation.n_nationkey = customer.c_nationkey
group by nation.n_name
having count(customer.c_custkey) = (
    Select count(customer.c_custkey)
    from customer, nation
    where
    nation.n_nationkey = customer.c_nationkey
    group by nation.n_name
    order by count(customer.c_custkey) ASC
    limit 1
)