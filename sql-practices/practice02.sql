-- 집계(통계) SQL 문제입니다.

-- 문제 1. 
-- 최고임금(salary)과  최저임금을 "최고임금", "최저임금" 프로젝션 타이틀로 함께 출력하세요.
-- 그리고 두 임금의 차이는 얼마인가요? "최고임금 – 최저임금" 이란 타이틀로 출력하세요.
select max(salary) as '최고임금', min(salary) as '최저임금',  max(salary)-min(salary) as '최고임금-최저임금'
	from salaries;

-- 문제2.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력하세요
-- 예) 2014년 07월 10일
select date_format(max(hire_date), '%Y년 %m월 %d일') as '마지막으로 신입사원이 들어온 날'
	from employees;

-- 문제3.
-- 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력하세요.
-- 예) 2014년 07월 10일
select date_format(min(hire_date), '%Y년 %m월 %d일') as '가장 오래 근속한 직원의 입사일'
	from employees;

-- 문제4.
-- 현재, 이 회사의 평균 연봉은 얼마입니까?
select avg(salary) as '현재 평균 연봉'
	from salaries
    where to_date like '9999%';

-- 문제5.
-- 현재, 이 회사의 최고/최저 연봉은 각각 얼마입니까?
select max(salary) as '현재 최고 연봉', min(salary) as '현재 최저 연봉'
	from salaries
    where to_date like '9999%';

-- 문제6.
-- 현재, 근무중인 사원 중 나이가 제일 어린 사원과 제일 많은 사원의 나이를 각각 출력하세요.
select date_format(curdate(), '%Y') - date_format(max(e.birth_date), '%Y') as '나이가 제일 어린 사원', 
		date_format(curdate(), '%Y') - date_format(min(e.birth_date), '%Y') as '나이가 제일 많은 사원'
	from employees e, salaries s
    where e.emp_no = s.emp_no and s.to_date like '9999%';
