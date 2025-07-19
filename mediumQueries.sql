use project1;

-- join the necessary tables to find the 
-- total quantity of each pizza category ordered

select pt.category, 
sum(o.quantity) as quantity
from pizza_types as pt
join pizzas as p
on pt.pizza_type_id = p.pizza_type_id
join order_details as o
on o.pizza_id = p.pizza_id
group by category
order by quantity desc;

-- Determine the Distributions of orders by hour of the day

select hour(order_time) as hour, count(order_id) as order_count
from orders
group by hour(order_time);

-- join the relavant tables to find the category 
-- wise distributions of pizzas

select category, count(pt.category) as count
from pizza_types as pt
group by category;

select category, count(*) from pizza_types as pt
group by category;

-- Group the orders by date and 
-- calculate the average number of pizzas ordered per day

select round(avg(quantity),0) as average_number_of_pizzas from (select o.order_date as o_date, sum(od.quantity) as quantity
from orders as o 
join order_details as od
on o.order_id = od.order_id
group by o_date) as order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue

select pt.name as name, round(sum(o.quantity * p.price),2) as revenue 
from order_details as o
join pizzas as p
on p.pizza_id = o.pizza_id
join pizza_types as pt
on pt.pizza_type_id = p.pizza_type_id
group by name
order by revenue desc limit 3;
