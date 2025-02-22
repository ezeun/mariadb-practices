-- 1) 집계 쿼리 : select 절에 집계 함수(count, max, min, avg, variance, strdev, sum, ...)
select avg(salary), sum(salary) 
	from salaries;

-- 2) select절에 집계함수(그룹함수)가 있는 경우, 어떤 컬럼도 select절에 올 수 없다
-- 		emp_no는 아무 의미가 없다
-- 		오류!
select emp_no, avg(salary)
	from salaries;
    
-- 3) query 순서
-- 1. from: 접근 테이블 확인
-- 2. where: 조건에 맞는 row를 확인 선택 (임지 테이블)
-- 3. 집계 (결과 테이블)
-- 4. projection
select avg(salary)
	from salaries
    where emp_no = 10060;
    
-- 4) group by에 참여하고 있는 컬럼은 projection이 가능함: select절에 올 수 있음
-- 예제: 사원별 평균 연봉은?
select avg(salary)
	from salaries
    group by emp_no;
    
-- 5) having
-- 집계결과 (결과테이블)에서 row 를 선택해야 하는 경우 
-- 이미 where절은 실행이 되었기 때뮨에 having절에서 이 조건을 주어야 함 
-- 예제: 평균 월급이 60000 이상인 사원의 사번과 평균 연봉을 출력하세요
select avg(salary) as avg_salary
		from salaries
        group by emp_no
        having avg(salary)>60000;
    
-- 6) order by
-- 	order by 항상 맨 마지막 출력(projection) 전에 함 
select avg(salary) as avg_salary
	from salaries
	group by emp_no
	having avg(salary)>60000
	order by avg(salary) asc;
    
-- 주의) 사번이 10060인 사원의 사번, 평균 급여, 급여 총합을 출력하세요

-- 의미적으로는 맞지만 문법적으로 옳지 않음
select emp_no, avg(salary), sum(salary)
	from salaries
    where emp_no = 10060;

-- 문법적으로 옳음
select emp_no, avg(salary), sum(salary)
	from salaries
    group by emp_no
    having emp_no = 10060;
    
    
    