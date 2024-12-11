-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 

-- 문제1.
-- 현재 전체 사원의 평균 급여보다 많은 급여를 받는 사원은 몇 명이나 있습니까?
select count(*)
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date  = '9999-01-01' 
    and b.salary >= (select avg(s.salary)
						from salaries s);
    
-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 급여을 조회하세요. 단 조회결과는 급여의 내림차순으로 정렬합니다.
-- sol01: where in
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, d.salary
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
									group by a.dept_no)
	order by d.salary desc;

-- sol02: from절 subquery & join
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, d.salary
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
    and d.salary = e.max_salary
	order by d.salary desc;

-- 문제3.
-- 현재, 사원 자신들의 부서의 평균급여보다 급여가 많은 사원들의 사번, 이름 그리고 급여를 조회하세요 
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, b.salary
	from employees a, salaries b, dept_emp c,
		(select a.dept_no, avg(b.salary) as avg_salary
			from dept_emp a, salaries b
			where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
			group by a.dept_no) d
    where a.emp_no = b.emp_no
    and a.emp_no = c.emp_no
    and c.dept_no = d.dept_no
    and b.to_date = '9999-01-01'
    and c.to_date = '9999-01-01'
    and b.salary >= d.avg_salary
    order by b.salary desc;  
    
-- 문제4.
-- 현재, 사원들의 사번, 이름, 그리고 매니저 이름과 부서 이름을 출력해 보세요. -- 매니저이름???????????
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, b.dept_name
	from employees a, departments b, dept_manager c
    where a.emp_no = c.emp_no
    and b.dept_no = c.dept_no
    and c.to_date = '9999-01-01';

-- 문제5.
-- 현재, 평균급여가 가장 높은 부서의 사원들의 사번, 이름, 직책 그리고 급여를 조회하고 급여 순으로 출력하세요.
select a.emp_no, concat(a.first_name,' ',a.last_name) as name, c.title, d.salary
	from employees a, dept_emp b, titles c, salaries d
    where a.emp_no = b.emp_no
    and a.emp_no = c.emp_no
    and a.emp_no = d.emp_no
    and b.dept_no = (select a.dept_no
						from dept_emp a, salaries b
						where a.emp_no = b.emp_no
						and a.to_date = '9999-01-01'
						and b.to_date = '9999-01-01'
						order by b.salary desc
						limit 1)
	order by d.salary;

-- 문제6.
-- 현재, 평균 급여가 가장 높은 부서의 이름 그리고 평균급여를 출력하세요.
select c.dept_name, avg(b.salary) as avg_salary
	from dept_emp a, salaries b, departments c
	where a.emp_no = b.emp_no
    and a.dept_no = c.dept_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
	group by a.dept_no
    having avg_salary = (select max(avg_salary)
							from (select a.dept_no, avg(b.salary) as avg_salary
									from dept_emp a, salaries b
									where a.emp_no = b.emp_no
									and a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
									group by a.dept_no) a);

-- 문제7.
-- 현재, 평균 급여가 가장 높은 직책의 타이틀 그리고 평균급여를 출력하세요.
select b.title, avg(a.salary) as avg_salary
	from salaries a, titles b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
	group by b.title
    having avg(a.salary) = (select max(avg_salary)
								from(select b.title, avg(a.salary) as avg_salary
									from salaries a, titles b
									where a.emp_no = b.emp_no
									and a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
									group by b.title) a);
