select * from project1.orders;

alter table orders
change column date order_date datetime not null;

alter table orders
change column time order_time text not null;

