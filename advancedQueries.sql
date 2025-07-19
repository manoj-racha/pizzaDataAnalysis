use project1;

-- calculate the percentage contribution of each pizzatype to total revenue

-- total revenue 
select round(sum(o.quantity * p.price)) as revenue
from pizza_types as pt
join pizzas as p
on p.pizza_type_id = pt.pizza_type_id
join order_details as o
on p.pizza_id = o.pizza_id;

select pt.category as category, round(sum(o.quantity * p.price)) as revenue, round(
	sum(o.quantity * p.price) * 100 / (
		select round(sum(o.quantity * p.price),0)
		from pizza_types as pt
		join pizzas as p on p.pizza_type_id = pt.pizza_type_id
		join order_details as o on p.pizza_id = o.pizza_id
	),
	2
) as percentage_contribution
from pizza_types as pt
join pizzas as p
on p.pizza_type_id = pt.pizza_type_id
join order_details as o
on p.pizza_id = o.pizza_id
group by category;


-- Analyze the cumulative revenue generated over time 

select odd, 
sum(revenue) over(order by odd) as cum_revenue 
from
	(select o.order_date as odd,  round(sum(od.quantity * p.price),2) as revenue
	from pizzas as p
	join order_details as od
	on p.pizza_id = od.pizza_id
	join orders as o
	on o.order_id = od.order_id
	group by odd) as sales;
    
    
-- Determine the top 3 most ordered pizza types based on revenue 
-- for each pizza category. 

-- select pt.name as pizza_type
-- from (
-- Revenue of each pizza category
SELECT category, name AS pizza_type, revenue, rnk
FROM (
select pt.name as name, pt.category as category, round((sum(o.quantity * p.price)),2) as revenue,
ROW_NUMBER() OVER (PARTITION BY pt.category ORDER BY SUM(o.quantity * p.price) DESC) AS rnk
from pizza_types as pt
join pizzas as p
on p.pizza_type_id = pt.pizza_type_id
join order_details as o
on p.pizza_id = o.pizza_id
group by name,category
) AS ranked
WHERE rnk <= 3;


    