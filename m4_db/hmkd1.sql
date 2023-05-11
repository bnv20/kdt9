--[DDL]
--Table 생성
create table test1 (
eno number(4),
ename varchar2(20),
esal number(7)
);
desc test1;
drop table member1;

--Table 복사
create table test2 as select * from test1;
insert into test1 values (1, '박찬호', 5);

--Table 구조 복사
--조건절에 거짓 조건을 지정하면 해당 로우를 발견하지 못하기 때문에 빈 테이블을 생성
create table test3 as select * from test1 where 1=0;
select * from test3;
desc test3

--컬럼 추가하기
alter table test1 add(email varchar2(10));

--컬럼 변경하기
alter table test1 modify(email varchar2(40));

--컬럼 삭제하기
alter table test1 drop column email;

--테이블의 모든 로우 삭제
select * from test1;
truncate table test1;

--[테이블 생성 규칙]

--테이블명은 객체를 의미할 수 있는 적절한 이름을 사용한다. 가능한 단수형을 권고한다.--
--테이블명은 다른 테이블의 이름과 중복되지 않아야 한다.--
--한 테이블 내에서는 칼럼명이 중복되게 지정될 수 없다. --
--테이블 이름을 지정하고 각 칼럼들은 괄호 "( )" 로 묶어 지정한다.--
--각 칼럼들은 콤마" ", 로 구분되고, 항상 끝은 세미콜론 ";"으로 끝난다.--
--칼럼에 대해서는 다른 테이블까지 고려하여 데이터베이스 내에서는 일관성 있게 사용하는 것이 좋다. (데이터 표준화 관점)--
--칼럼 뒤에 데이터 유형은 꼭 지정되어야 한다.--
--테이블명과 칼럼명은 반드시 문자로 시작해야 하고, 벤더별로 길이에 대한 한계가 있다.--
--벤더에서 사전에 정의한 예약어(Reserved word)는 쓸 수 없다.--
--A-Z, a-z, 0-9, _, $, # 문자만 허용된다.

--테이블 리스트를 조회
select * from tabs;

CREATE TABLE MEMBER (
ID          VARCHAR2(10),
PWD         VARCHAR2(20),
NAME        VARCHAR2(10),
GENDER      CHAR(1),
AGE         NUMBER(3),
BIRTHDAY    CHAR,
PHONE       VARCHAR2(20),
REGDATE     DATE 
);

INSERT INTO MEMBER (ID, PWD, NAME) VALUES('200901','111','kevin');
SELECT * FROM MEMBER;

--과제12_0509. md에 있는 테이블들을 이용해서 hmkd 서점의 데이터 테이블을 생성하고 주요 특징을
--요약해서 출력하세요.(테이블은 5개 이상)

--Q. MEMBER1 테이블을 생성(모든 데이터 타입 적용)하고 2개의 데이터 입력 및 칼럼 추가, 타입 변경, 
--칼럼 삭제, 제약조건 추가, 삭제한 후 출력하세요.
DROP TABLE MEMBER1;
CREATE TABLE MEMBER1 AS SELECT * FROM MEMBER;
TRUNCATE TABLE MEMBER1;
DESC MEMBER1;
INSERT INTO MEMBER1 (ID, PWD, NAME) VALUES('200901','111','kevin');
INSERT INTO MEMBER1 VALUES('200902','112','park','1',23,'2000-01-01','010-1234-5678',(DATE '2000-01-01'));
SELECT * FROM MEMBER1;
ALTER TABLE MEMBER1 MODIFY(ID NVARCHAR2(10),PWD NVARCHAR2(6));
ALTER TABLE MEMBER1 ADD HOBBY NCLOB;
INSERT INTO MEMBER1 (ID, PWD, NAME, HOBBY) VALUES('200903','113','k','나의 취미는 코딩이다');
ALTER TABLE MEMBER1 DROP COLUMN HOBBY;
ALTER TABLE MEMBER1 ADD CONSTRAINT MEMBER_PK PRIMARY KEY(ID);
ALTER TABLE MEMBER1 DROP CONSTRAINT MEMBER_PK; 

--과제1_0510. MEMBER2 테이블을 생성하여 DDL 전체 명령어를 사용하는 코드를 작성하세요.

--[DML]
--IN : OR 대신 사용
SELECT EMPLOYEE_ID, MANAGER_ID FROM EMPLOYEES;
select * from employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id IN(101,102,103);

--BETWEEN AND : AND 대신 사용 101 ~ 105
select EMPLOYEE_ID, MANAGER_ID from employees where manager_id between 101 and 105;

--null 값인 것만 출력, null이 아닌 것만 출력
SELECT EMPLOYEE_ID, COMMISSION_PCT FROM EMPLOYEES;
select EMPLOYEE_ID, COMMISSION_PCT from employees where commission_pct is null;
select EMPLOYEE_ID, COMMISSION_PCT from employees where commission_pct is not null;

--ORDER BY
SELECT employee_id, last_name, salary FROM employees;
select employee_id, salary from employees order by salary;
select employee_id, salary from employees order by salary desc;
select employee_id, last_name, salary from employees order by salary,last_name desc;

--dual table
--select 절 다음에 반드시 from 절을 기술해야 한다.
--연산의 경우 select 절 자체적으로 연산이 가능하기 때문에 from 절 뒤에 올 테이블이 필요없다.
--이런 경우 사용할 수 있는 Dummy 테이블이 DUAL 테이블이다.

--mod : 나머지
select employee_id, last_name from employees where mod(employee_id, 2)=1;
select mod( 10, 3 ) from dual;

--round() : 반올림 함수
select round(355.95555) from dual;
select round(355.95555, 2) from dual;
select round(355.95555, -1) from dual;

--trunc() 버림 함수, 지정한 자리수 이하를 버린 결과를 반환
select trunc(45.5555) from dual;
select trunc(45.5555,2) from dual;

--날짜 관련 함수
select sysdate from dual;
select sysdate+1 from dual;
select sysdate-1 from dual;

select last_name, hire_date, sysdate-hire_date 근무일수 from employees;
select last_name, hire_date, add_months(hire_date,6) from employees;
select last_day(sysdate) - sysdate from dual;
select hire_date, next_day(hire_date, '월') from employees;
select last_name, months_between(sysdate,hire_date) from employees;

--형 변환
--to_date : 문자를 날짜로 변환
select to_date('20210101') from dual;
--to_char : 날짜를 문자로 변환
select to_char(sysdate, 'yy/mm/dd') from dual;
select to_char(sysdate, 'yy/mm/dd hh24:mi:ss') from dual;

--형식
--YYYY 		네 자리 연도
--YY		두 자리 연도
--YEAR		연도 영문 표기
--MM		월을 숫자로
--MON		월을 알파벳으로
--DD		일을 숫자로
--DAY		요일 표현
--DY		요일 약어 표현
--D		요일 숫자 표현
--
--AM 또는 PM	오전 오후
--HH 또는 HH12	12시간
--HH24		24시간
--MI		분
--SS		초

--문자 함수
select upper('Hello World') from dual;
select lower('Hello World') from dual;

select last_name, salary from employees where last_name='seo';
select last_name, salary from employees where upper(last_name)='SEO';
--첫글자만 대문자
select job_id, initcap(job_id) from employees;

--length()
select job_id, length(job_id) from employees;

--instr(문자열, 찾을 문자, 찾을 위치, 찾은 문자 중 몇 번 째)	
select instr('Hello World', 'o', 3, 2) from dual;

--substr(문자열, 시작위치, 개수)
select substr('Hello World', 3, 3) from dual;
select substr('Hello World', -3, 3) from dual;

--lpad(), rpad() 왼쪽, 오른쪽 정렬 후 문자를 채운다.
select lpad('Hello World',20,'#') from dual;
select rpad('Hello World',20,'#') from dual;

--ltrim(), rtrim() 앞, 뒤의 특정 문자 제거
select ltrim('aaaHello Worldaaa', 'a') from dual;
select rtrim('aaaHello Worldaaa', 'a') from dual;

--trim() : 앞뒤의 특정 문자 제거
select last_name, trim('A' from last_name) new_name from employees;

--nvl() : null을 0 또는 다른 값으로 변환
select salary, nvl(commission_pct,0) from employees;
select last_name, manager_id from employees;
select last_name, nvl(to_char(manager_id),'ceo') from employees;

--decode(): if문이나 case문과 같이 여러 경우를 선택할 수 있도록 하는 함수
select last_name, department_id,
decode(department_id,
90, '경영지원실',
60, '프로그래머',
100, '인사부') 부서명
from employees;

--case() : decode() 함수와 동일하나 decode() 함수는 조건이 동일한 경우만 가능하지만
--case() 함수는 다양한 비교연산자로 조건을 제시
select last_name, department_id,
case when department_id=90 then '경영지원실'
     when department_id=60 then '프로그래머'
     when department_id=100 then '인사부'
     when department_id=30 then '영업부'
     when department_id=50 then '관리부' end as 부서명
from employees;

--first_value() over() : 그룹의 첫번째 값을 구한다.
select first_name 이름, salary 연봉,
first_value(salary) over(order by salary desc) 최고연봉
from employees;

--3줄 위의 값까지 중 첫번째 값
select first_name 이름, salary 연봉,
first_value(salary) over(order by salary desc rows 3 preceding) 최고연봉
from employees;

--연봉 + 2000 까지 중 첫번째 값
select first_name 이름, salary 연봉,
first_value(salary) over(order by salary desc range 2000 preceding) 최고연봉
from employees;

--sum() over() : 정렬에 따라 그룹의 누적 합계를 구한다.
select department_id, last_name, sum(salary) over(order by department_id) 
from employees;

--INSERT
--테이블에 데이터를 입력하는 방법은 두 가지 유형이 있으며 한 번에 한 건만 입력된다.
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUMN_LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);
select * from member;
desc member;
insert into member (id, pwd, name) values ('200903','113','김연아');
insert into member values ('200904','113','김태성','0',20,'2001-12-30','010-1234-5678',sysdate);

--UPDATE
--UPDATE 다음에 수정되어야 할 칼럼이 존재하는 테이블명을 입력하고,
--SET 다음에 수정되어야 할 칼럼명과 해당 칼럼 수정 값으로 변경이 이루어진다.
--UPDATE 테이블명 SET 수정되어야 할 칼럼명 = 수정되기를 원하는 새로운 값;
--[예제] UPDATE PLAYER SET POSITION = 'MF’;

select * from member;
update member set name='추신수' where id = '200902';

--update한 사항을 db에 반영
commit;
--DELETE
--DELETE FROM 다음에 삭제를 원하는 자료가 저장되어 있는 테이블명을 입력하고 실행한다. 
--이때 FROM 문구는 생략이 가능한 키워드이다. 
--DELETE [FROM] 삭제를 원하는 정보가 있는 테이블명;
--[예제] DELETE FROM PLAYER;
delete member where id='200901';
insert into member (id) values('200902');
alter table member add constraint member_pk primary key (id);
delete member where pwd='111';
desc member;

--UNION
--UNION( 합집합 ) INTERSECT( 교집합 ) MINUS( 차집합 ) UNION ALL( 겹치는 것까지 포함 )
--두 개의 쿼리문을 사용해야 한다. 데이터 타입을 일치 시켜야 한다.
select first_name 이름, hire_date 입사일, salary 급여 from employees 
where salary < 5000
union
select first_name 이름, hire_date 입사일,salary 급여 from employees 
where hire_date < '05/01/01'
order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees 
where salary < 5000
intersect
select first_name 이름, hire_date 입사일,salary 급여 from employees 
where hire_date < '05/01/01'
order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees 
where salary < 5000
minus
select first_name 이름, hire_date 입사일,salary 급여 from employees 
where hire_date < '05/01/01'
order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees 
where salary < 5000
union all
select first_name 이름, hire_date 입사일,salary 급여 from employees 
where hire_date < '05/01/01'
order by 입사일;

create table test5(
id varchar2(10),
name varchar2(10),
eng number
);
insert into test5 values('111','james',90);
insert into test5 values('112','susan',60);
insert into test5 values('113','tom',85);
insert into test5 values('114','jean',70);
insert into test5 values('115','dick',75);

select * from test5;

create table test6(
id varchar2(10),
math number,
age number
);
insert into test6 values('111',90,20);
insert into test6 values('112',60,20);
insert into test6 values('113',85,20);
insert into test6 values('114',70,20);
insert into test6 values('115',75,20);

select * from test6;

--inner join
select t5.id, t5.name, t5.eng, t6.math, t6.age
from test5 t5
join test6 t6 on t5.id = t6.id;

--left outer join
select t5.id, t5.name, t5.eng, t6.math, t6.age
from test5 t5
join test6 t6 on t5.id = t6.id(+);

--right outer join
select t5.id, t5.name, t5.eng, t6.math, t6.age
from test5 t5
join test6 t6 on t5.id(+) = t6.id;
--full outer join
select t5.id, t5.name, t5.eng, t6.math, t6.age
from test5 t5
full outer join test6 t6 on t5.id = t6.id;

--과제2_0510. test5, test6의 합집합, 교집합, 차이를 where를 이용해서 구하세요. 
select * from test5;
select * from test6;
SELECT ID FROM test5
WHERE ENG > 80
UNION
SELECT ID FROM test6
WHERE MATH > 70;

SELECT ID  FROM test5
WHERE ENG > 80
UNION ALL
SELECT ID FROM test6
WHERE MATH > 70;

SELECT ID  FROM test5
WHERE ENG > 80
INTERSECT
SELECT ID FROM test6
WHERE MATH > 70;

SELECT ID  FROM test5
WHERE ENG > 70
MINUS
SELECT ID FROM test6
WHERE MATH > 90;


--과제3_0510. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력.
--join~on, where 로 조인하는 두 가지 방법 모두 사용.

SELECT E.employee_id, E.last_name, E.job_id, J.job_title
FROM employees E, jobs J
WHERE E.job_id = J.job_id AND E.employee_id = 120;

SELECT employee_id, last_name, E.job_id, job_title
FROM employees E JOIN jobs J ON E.job_id=J.job_id 
WHERE employee_id=120;

--과제4_0510. employees, jobs, departments 세개의 테이블을 연결해서 employee_id, job_title, 
--department_name을 출력하세요.
select job_id,employee_id,last_name from employees;
select * from jobs;
select * from departments;
SELECT employee_id, job_title, department_name 
FROM employees E, jobs J, departments D
WHERE E.job_id = J.job_id
AND E.department_id = D.department_id;

--과제5_0510. hr에 포함되는 6개의 테이블들을 분석해서 인사이트를 얻을 수 있는
--결과물을 5개 이상 출력하세요. 
--(예 : 부서별 평균 SALARY 순위)
SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY)) AVG
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;

--rank() within group( order by 컬럼명 정렬 )
select COMMISSION_PCT from employees
order by COMMISSION_PCT desc;

--rank 1위가 73번째
select rank( 0.4 ) within group( order by COMMISSION_PCT desc ) from employees;
select rank( 3000 ) within group( order by salary asc ) from employees;

--count()
--null은 제외하고 중복은 개수로 센다.
select count( commission_pct ) from employees;
select count( distinct commission_pct ) from employees;
--전체행의 수
select count( * ) from employees;		

--GROUP BY  
--*주의*	select 뒤에는 그룹으로 묶을 수 있는 컬럼만 올 수 있다.
select department_id, round(avg( salary )) from employees group by department_id;
select job_id, avg( salary ) from employees group by job_id;

select job_id, avg( salary ), max( salary ), min( salary ) 
from employees 
group by job_id;

--Q. 평균연봉이 5000이상인 부서들에 대해서 job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력
--HAVING
--group by 적용 뒤에 나온 결과에 특정 조건을 부여한다.
select job_id, sum( salary ), avg( salary ), max( salary ), min( salary ) 
from employees 
group by job_id 
having avg(salary)>=5000;

--Q. 평균연봉이 10000이상인 부서들에 대해서 job_id 별로 연봉평균 부서인원 출력
--(연봉평균 기준 내림차순 정렬)
select job_id 업무, avg( salary ) 연봉평균, 
count( employee_id ) 부서인원
from employees
group by job_id
having avg( salary ) >= 10000
order by avg( salary ) desc;

--서브 쿼리
--Seo 라는 사람의 부서명을 얻어 오려면 두 번 검색해야 한다.
select department_id from employees where last_name='Seo';
select department_name from departments where department_id=50;

select department_id,department_name from departments 
where department_id=(select department_id from employees where last_name='Seo');

--평균보다 많은 급여를 받는 직원 검색
select last_name, salary from employees where salary > 
( select avg( salary ) from employees );

--'Seo' 는 한명이기 때문에 단일행 서브 쿼리	
select last_name, hire_date, department_id from employees 
where department_id = ( select department_id 
from employees where last_name='Seo' );

--'King'은 두명이기 때문에 다중행 서브 쿼리
select last_name, hire_date, department_id from employees 
where department_id in ( select department_id 
from employees where last_name='King' );

--다중행	
select last_name, salary from employees where salary > all 
( select salary from employees where department_id = 100 );

--단일행	
select last_name, salary from employees where salary >  
( select max( salary ) from employees where department_id = 100 );

--특정부서보다 먼저 입사
select last_name 이름, salary 연봉, department_id 부서, hire_date 입사일
from employees
where hire_date < all
( select hire_date from employees where department_id = 100 );

select last_name, salary from employees where salary > any 
( select salary from employees where  department_id = 100 );

--과제1_0511. 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'

--과제2_0511. 부서별 연봉 순위를 출력하세요.


--과제3_0511. employees 테이블에서 employee_id와 salary만 추출해서 employee_salary 테이블을 생성하세요.


--과제4_0511. employees_salary 테이블에 first_name, last_name 컬럼을 추가하세요.


--과제5_0511. last_name을 name으로 변경하세요.


--과제6_0511. employees_salary 테이블의 employee_id에 기본키를 적용하고 CONSTRAINT_NAME을 ES_PK로 지정 후 
--출력하세요.


--과제7_0511. employees_salary 테이블의 employee_id에서 CONSTRAINT_NAME을 삭제후 삭제 여부를 확인하세요.



--[DCL]
DROP USER c##hmkd1 CASCADE; 
CREATE USER c##hmkd1 IDENTIFIED BY hmkd1 DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##hmkd1;
GRANT CREATE VIEW, CREATE SYNONYM TO c##hmkd1;
GRANT UNLIMITED TABLESPACE TO c##hmkd1;
ALTER USER c##hmkd1 ACCOUNT UNLOCK;
--사용자와 해당 사용자에게 부여된 모든 객체와 권한을 함께 삭제하도록 "CASCADE" 옵션을 사용하여 
--사용자를 삭제합니다. 이는 해당 사용자를 완전히 삭제하려는 경우에 유용합니다.
-- "c##hmkd1"이라는 사용자를 생성합니다. "IDENTIFIED BY" 키워드 다음의 "hmkd1"은 해당 사용자의 
--암호를 지정 
--"DEFAULT TABLESPACE" 키워드 다음의 "users"는 해당 사용자가 기본적으로 사용할 테이블 스페이스를 지정
--"TEMPORARY TABLESPACE" 키워드 다음의 "temp"는 해당 사용자가 일시적으로 사용할 테이블 스페이스를 지정
--"PROFILE DEFAULT"는 해당 사용자의 프로필을 "DEFAULT"로 설정합니다.
--"CONNECT"와 "RESOURCE" 권한을 "c##hmkd1" 사용자에게 부여. 
--"CONNECT" 권한은 해당 사용자가 데이터베이스에 연결할 수 있는 권한을 부여하고 
--"RESOURCE" 권한은 해당 사용자가 테이블, 시퀀스, 프로시저 등을 만들 수 있는 권한을 부여
--"CREATE VIEW"와 "CREATE SYNONYM" 권한을 "c##hmkd1" 사용자에게 부여
--"CREATE VIEW" 권한은 해당 사용자가 뷰를 생성할 수 있는 권한을 부여하고 
--"CREATE SYNONYM" 권한은 해당 사용자가 시노님을 생성할 수 있는 권한을 부여합니다.
--"UNLIMITED TABLESPACE" 권한을 "c##hmkd1" 사용자에게 부여 이 권한은 해당 사용자가 무제한으로 
--테이블 스페이스를 사용할 수 있는 권한을 부여
--"c##hmkd1" 사용자의 계정 잠금을 해제. 계정 잠금은 일정 시간 동안 로그인 실패가 발생하면 자동으로 
--발생하는 보안 기능. 계정 잠금을 해제하여 해당 사용자가 로그인할 수 있도록 합니다.

CREATE USER C##USER01
IDENTIFIED BY USERPASS

--DROP USER : 사용자 삭제
--DROP USER 사용자 ID
DROP USER C##USER01;

--권한 종류 확인
SELECT * FROM dba_sys_privs;

--트랜잭션

--트랜잭션은 데이터베이스의 논리적 연산단위이다. 
--트랜잭션(TRANSACTION)이란 밀접히 관련되어 분리될 수 없는 한 개 이상 의 데이터베이스 조작을 가리킨다. 
--하나의 트랜잭션에는 하나 이상의 SQL 문장이 포함된다.
--트랜잭션은 의미적으로 분할할 수 없는 최소의 단위이다. 그렇기 때문에 전부 적용하거나 전부 취소한다. 
--즉, TRANSACTION 은  ALL OR NOTHING의 개념인 것이다.
--[사례] 계좌이체라는 작업단위는 두개의 스텝이 모두 성공적으로 완료되었을 때 종료된다. 
--둘 중 하나라도 실패할 경우 계좌이체는 원래의 금액을 유지하고 있어야만 한다.
--STEP1. 100번 계좌의 잔액에서 10,000원을 뺀다. 
--STEP2. 200번 계좌의 잔액에 10,000원을 더한다

--TCL
--트랜잭션을 콘트롤하는 TCL(TRANSACTION CONTROL LANGUAGE)
--커밋(COMMIT) :
--COMMIT 명령어는 INSERT 문장, UPDATE 문장, DELETE 문장 사용 후에 일련의 변경 작업이 완료 
--되었음을 데이터베이스 알려 주기 위해 사용
--"변경된 데이터를 데이터베이스에 영구적으로 반영하라"
--롤백(ROLLBACK) : 
--"변경된 데이터가 문제가 있으니 변경 전 데이터로 복귀하라“
--저장점(SAVEPOINT) :
--"데이터 변경을 사전에 지정한 저장점까지만 롤백하라"

