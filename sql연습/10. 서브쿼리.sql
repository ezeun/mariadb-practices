--
-- Subquery
--

--
-- 1) select절의 서브쿼리 
select (select 1+1 from dual) from dual;
-- insert into t1 values(null, (select max(no) +1 from t1)); 

--
-- 2) from절의 서브쿼리 
select a.n, a.r
	from(select now() as n, sysdate() as s, 3+1 as r from dual) a;
    
-- 3) where절의 서브쿼리

-- 예) 현재, FaiBale이 근무하는 부서에서 근무하는 직언의 사번, 천제 이름을 출력해보세요
select b.dept_no
	from employees a, dept_emp b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and concat(a.first_name, ' ', a.last_name) = 'Fai Bale'; -- 'd004'
    
select a.emp_no, a.first_name
	from employees a, dept_emp b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and b.dept_no = (select b.dept_no
	from employees a, dept_emp b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and concat(a.first_name, ' ', a.last_name) = 'Fai Bale');
    
-- 3-1) 단일행 연산자: =, >, <, >=, <=, <>, !=
-- 실습문제1
-- 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름과 급여를 출력하세요    
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and b.salary < (select avg(salary)
					from salaries
					where to_date = '9999-01-01')
	order by b.salary desc;

-- 실습문제2
-- 현재, 직책별 평균 급여중에 가장 적은 평균 급여의 직책이름과 그 평균 급여를 출력하세요 
-- 1) 직책별 평균 급여
select b.title, avg(a.salary)
	from salaries a, titles b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
    group by b.title;
-- 2) 직책별 평균 급여
select min(avg_salary)
	from(select b.title, avg(a.salary) as avg_salary
		from salaries a, titles b
		where a.emp_no = b.emp_no
		and a.to_date = '9999-01-01'
		and b.to_date = '9999-01-01'
		group by b.title) a;
-- 3) sol: where절 subquery(=)
select b.title, avg(a.salary)
	from salaries a, titles b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
	group by b.title
    having avg(a.salary) = (select min(avg_salary)
								from(select b.title, avg(a.salary) as avg_salary
									from salaries a, titles b
									where a.emp_no = b.emp_no
									and a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
									group by b.title) a);
-- 4) sol2: top-k
select a.title as '직책', avg(b.salary) as '평균급여'
	from titles a, salaries b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	group by a.title
	order by avg(b.salary) asc
    limit 1;

-- 3-2) 복수행 연산자: in, not in, 비교연산자any, 비교연산자all
-- 1. =any: in
-- 2. >any, >=any: 최소값
-- 3. <any, <=any: 최대값
-- 4. <>any, !=any: not in

-- all 사용법
-- 1. =all: (x)
-- 2. >all, >=all: 최대값
-- 3. <all, <=all: 최소값 
-- 4. <>all, !=all 


-- 실습문제 3
-- 현재 급여가 50000 이상인 직원의 이름과 급여를 출력하세요.
-- 둘리 60000
-- 마이콜 55000

-- sol01
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.salary > 50000
  and b.to_date = '9999-01-01'
order by b.salary asc;
-- sol02
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and (a.emp_no, b.salary) in (select emp_no, salary 
								from salaries 
                                where to_date = '9999-01-01' 
                                and salary > 50000)
order by  b.salary asc;

-- 실습문제 4:
-- 현재, 각 부서별 최고 급여를 받고 있는 직원의 이름, 그 부서 이름, 급여를 출력해 보세요.
select b.dept_no, max(a.salary)
from salaries a, dept_emp b
where a.emp_no = b.emp_no and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
group by b.dept_no;

select a.first_name, d.dept_name, b.salary
from employees a, salaries b, dept_emp c, departments d
where a.emp_no = b.emp_no and b.emp_no = c.emp_no and c.dept_no = d.dept_no
and (c.dept_no, b.salary) in (select b.dept_no, max(a.salary)
                                from salaries a, dept_emp b
                                where a.emp_no = b.emp_no
                                  and a.to_date = '9999-01-01'
                                  and b.to_date = '9999-01-01'
                                group by b.dept_no)
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01';
--
--
select a.dept_no, max(b.salary) as max_salary
	from dept_emp a, salaries b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
    group by a.dept_no;

-- sol01: where in
select *
	from employees a,
		dept_emp b,
        departments c,
        salaries d 
	where a.emp_no = b.emp_no
    and b.dept_no = c.dept_no
    and a.emp_no = d.emp_no
    and b.to_date = '9999-01-01'
    and d.to_date = '9999-01-01'
    and (b.dept_no, d.salary) in (select a.dept_no, max(b.salary)
									from dept_emp a, salaries b
									where a.emp_no = b.emp_no
									and a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
									group by a.dept_no);

-- sol02: from절 subquery & join
select *
	from employees a,
		dept_emp b,
        departments c,
        salaries d,
        (select a.dept_no, max(b.salary) as max_salary
			from dept_emp a, salaries b
			where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
			group by a.dept_no) e
	where a.emp_no = b.emp_no
    and b.dept_no = c.dept_no
    and a.emp_no = d.emp_no
    and b.dept_no = e.dept_no
    and b.to_date = '9999-01-01'
    and d.to_date = '9999-01-01'
    and d.salary = e.max_salary;
