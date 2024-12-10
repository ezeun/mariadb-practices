select version(), current_date, current_date(), now() FROM dual;

-- 수학함수, 사칙연산
select sin(pi()/4), 1+2*3-4/5 from dual;

-- 대소문자 구분 없음
select VERSION(), current_DATE, NOW() from dual;

-- table 생성
create table pet(
	name varchar(100),
	owner varchar(20),
    species varchar(20),
    gender char(1),
    birth date,
    death date
);

-- schema 확인
describe pet;
desc pet;  

-- table 삭제
drop table pet;

-- insert(C)
insert
	into pet
    values('뽀삐', '이지은', '말티즈', 'm', '2012-12-25', null);

-- select (R)
select * from pet;

-- update (U)
update pet set name='복순이' where name = '뽀삐';
-- update pet set death=null where death = '0000-00-00';

-- delete (D)
delete from pet where name ='복순이';

-- load data: mysqql(CLI) Local 전용
load data local infile '/home/leeju/pet.txt' into table pet;

-- select 연습
select name, species, birth
	from pet
    where birth >= '1998-01-01';

select name, species, gender
	from pet
    where species='dog'
    and	gender='f';

select name, species
	from pet
    where species='snake'
    or species='bird';
    
select name, birth, death
		from pet
        where death is null;
        
select name 
	from pet
    where name like '%fy';
    
select name 
	from pet
    where name like '%w%';
    
select name 
	from pet
    where name like '____';
    -- 와일드카드 (글자수가 4자리)
    
select name 
	from pet
    where name like 'b____';
    -- b로 시작하고 4글자 더 있음
    
select count(*), max(birth) from pet;

        
        
        
        
        
        
    