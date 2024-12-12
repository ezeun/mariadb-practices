--
-- DDL/DML 연습
-- 
drop table member;

create table member(
	id int not null auto_increment,
    email varchar(200) not null,
    password varchar(64) not null,
    name varchar(50) not null,
    department varchar(100),
    primary key(id)
);

desc member;

-- 컬럼 추가 
alter table member add column juminbunho char(13) not null;
-- 컬럼 삭제 
alter table member drop juminbunho;
-- 컬럼 추가(위치 지정)
alter table member add column juminbunho char(13) not null after email;
-- 컬럼 변경
alter table member change column department dept varchar(100) not null;

alter table member add column profile text;

alter table member drop juminbunho;

-- insert 
insert 
	into member
    values (null, 'leeju1013@gmail.com', password('1234'), '이지은', '개발팀', null);
    
select * from member;

insert
	into member(id, email, name, password, dept)
    values(null, 'leeju@gmail.com', '리쥬', password('1234'), '개발팀');

-- update 
update member
	set email = 'leeju@naver.com',
		password = password('12345')
	where id=2;

-- delete
delete 
	from member
    where id =2;

-- transaction(tx)
 select id, email from member;
 
 select @@autocommit; -- 1
 insert into member values(null, 'gusdk2@gmail.com', '김현아2', password('123'), '개발팀2', null);
 select id, email from member;
 
 -- tx:begin
 set autocommit = 0;
 select @@autocommit; -- 0
 insert into member values(null, 'gusdk2@gmail.com', '김현아3', password('123'), '개발팀2', null);
 select id, email from member;
 
 -- tx:end
 commit;
 -- rollback;
 select id, email from member;



