-- 문자열 함수

-- upper
select upper('seoul'), ucase('SeouL') from dual;
select upper(first_name) from employees;

-- lower
select lower('SEOUL'), lcase('SeouL') from dual;
select lower(first_name) from employees;

-- substring(문자열, index, length)
select substring('hello world', 3, 2) from dual; -- index를 1부터 셈 

-- 예제: employee 테이블에서 1989년에 입사한 직원의 이름, 입사일 출력
select first_name, hire_date
	from employees
    where substring(hire_date, 1,4) = '1989';
    
-- lpad, rpad
select lpad('1234', 10, '-'), rpad('1234', 10, '-') from dual; -- 정렬시 사용

-- trim, ltrim, rtrim
select concat('---', ltrim('  hello  '), '---'), 
		concat('---', rtrim('  hello  '), '---'),
		concat('---', trim(leading 'x' from 'xxhelloxx'), '---'),
		concat('---', trim(trailing 'x' from 'xxhelloxx'), '---'),
		concat('---', trim(both 'x' from 'xxhelloxx'), '---')
        from dual;

select length('Hello World') from dual;