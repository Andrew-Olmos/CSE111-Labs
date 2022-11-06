select count(customer.c_custkey)
from customer, region, nation
where (
    nation.n_nationkey = customer.c_nationkey and
    region.r_regionkey = nation.n_regionkey and
    region.r_name != "EUROPE" and
    region.r_name != "ASIA" and
    region.r_name != "AFRICA"
);