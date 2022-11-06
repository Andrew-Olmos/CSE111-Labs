select count(*)
from customer
where ( customer.c_name in
    (
        select customer.c_name
        from customer, orders
        where (
            customer.c_custkey = orders.o_custkey AND
            orders.o_orderdate BETWEEN '1995-11-01' AND '1995-11-30'
        )
        GROUP BY customer.c_name
        HAVING count(*) >= 3
    )
)