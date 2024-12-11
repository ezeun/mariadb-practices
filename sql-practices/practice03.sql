-- 테이블 조인(JOIN) SQL 문제입니다.
select * from employees;

-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select a.emp_no, a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date  = '9999-01-01'
    order by b.salary desc;
    
-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, b.title
	from employees a, titles b
    where a.emp_no = b.emp_no
    and b.to_date  = '9999-01-01'
    order by name;

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, c.dept_name
	from employees a, dept_emp b, departments c 
    where a.emp_no = b.emp_no
    and b.dept_no = c.dept_no
    and b.to_date  = '9999-01-01'
    order by name;

-- 문제4.
-- 현재 근무중인 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, b.salary, c.title, e.dept_name
	from employees a, salaries b, titles c, dept_emp d, departments e 
    where a.emp_no = b.emp_no
    and a.emp_no = c.emp_no
    and a.emp_no = d.emp_no
    and d.dept_no = e.dept_no
    and b.to_date  = '9999-01-01'
    and c.to_date  = '9999-01-01'
    and d.to_date  = '9999-01-01'
	order by name;

-- 문제5.
-- 'Technique Leader'의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
-- (현재 'Technique Leader'의 직책으로 근무하는 사원은 고려하지 않습니다.)
select distinct(a.emp_no), concat(a.first_name,' ',a.last_name) as name
	from employees a, titles b
    where a.emp_no = b.emp_no
    and b.title='Technique Leader'
    and b.to_date < '9999-01-01';

-- 문제6.
-- 직원 이름(last_name) 중에서 S로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
select concat(a.first_name,' ',a.last_name) as name, c.dept_name, d.title
	from employees a, dept_emp b, departments c, titles d
    where a.emp_no = b.emp_no
    and b.dept_no = c.dept_no
    and a.emp_no = d.emp_no
    and a.last_name like 'S%';

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40,000 이상인 사원들의 사번, 이름, 급여 그리고 타이틀을 급여가 큰 순서대로 출력하세요.
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, b.salary, c.title
	from employees a, salaries b, titles c 
    where a.emp_no = b.emp_no
    and a.emp_no = c.emp_no
    and b.to_date  = '9999-01-01'
    and c.to_date  = '9999-01-01'
    and c.title = 'Engineer'
    and b.salary >= 40000
    order by b.salary desc;

-- 문제8.
-- 현재, 평균급여가 50,000이 넘는 직책을 직책과 평균급여을 평균급여가 큰 순서대로 출력하세요.
select a.title, avg(b.salary) as avg_salary
	from titles a, salaries b
    where a.emp_no = b.emp_no
    and a.to_date  = '9999-01-01'
    and b.to_date  = '9999-01-01'
    group by a.title 
    having avg_salary > 50000
    order by avg_salary desc;

-- 문제9.
-- 현재, 부서별 평균급여를 평균급여가 큰 순서대로 부서명과 평균연봉을 출력 하세요.
select c.dept_name, avg(a.salary) as avg_salary
	from salaries a, dept_emp b, departments c
    where a.emp_no = b.emp_no
    and b.dept_no = c.dept_no
    and a.to_date  = '9999-01-01' 
    and b.to_date  = '9999-01-01' 
    group by c.dept_name
    order by avg_salary desc;

-- 문제10.
-- 현재, 직책별 평균급여를 평균급여가 큰 직책 순서대로 직책명과 그 평균연봉을 출력 하세요.
select a.title, avg(b.salary) as avg_salary
	from titles a, salaries b
    where a.emp_no = b.emp_no
    and a.to_date  = '9999-01-01'  
    and b.to_date  = '9999-01-01' 
    group by a.title
    order by avg_salary desc;
    


