use project1;

-- Retrive total number of orders 
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales

select round(sum(o.quantity * p.price),2) as total_revenue 
from order_details as o
join pizzas as p
on p.pizza_id = o.pizza_id;

-- identify the highest-priced pizza

-- select pt.name, max(p.price) as price
select pt.name, p.price
from pizza_types as pt
join pizzas as p
on pt.pizza_type_id = p.pizza_type_id
-- group by name;
order by p.price DESC limit 1;

-- Identify the most common pizza size ordered

select p.size, count(o.order_details_id) as order_count
from pizzas as p
join order_details as o
on p.pizza_id = o.pizza_id
group by p.size
order by order_count DESC;

-- list the top most 5 ordered pizza types along with their quantities

select pt.name, sum(o.quantity) as quantity
from pizza_types as pt
join pizzas as p
on pt.pizza_type_id = p.pizza_type_id
join order_details as o
on o.pizza_id = p.pizza_id
group by pt.name
order by quantity DESC limit 5;









