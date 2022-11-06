select region.r_name, count(supplier.s_suppkey)
from supplier
inner join nation on supplier.s_nationkey = nation.n_nationkey
inner join region on nation.n_regionkey = region.r_regionkey
inner join (
    select region.r_name as innerRegionName, avg(supplier.s_acctbal) as r_avg_acctbal
    from supplier
    inner join nation on supplier.s_nationkey = nation.n_nationkey
    inner join region on region.r_regionkey = nation.n_regionkey
    group by region.r_name
)as avg_table on avg_table.innerRegionName = region.r_name
where supplier.s_acctbal < avg_table.r_avg_acctbal
group by region.r_name;