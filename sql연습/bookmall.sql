SELECT * FROM user;
SELECT * FROM book;
SELECT * FROM cart;
SELECT * FROM category;
SELECT * FROM orders;
SELECT * FROM orders_book;
desc cart;
desc orders;

insert into user values (null, "이름", "이메일", "비번", "전번");

insert into category values (null, "이름");

insert into book values (null, 1, "제목", 123);

insert into cart values (1, 1, 3, 1000);

insert into orders values (null, 1, "2024", "배송중", 300, "용인");

insert into orders_book values (1,1,3,1000);

delete from orders_book where order_no = 1;