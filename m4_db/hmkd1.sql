--[DDL]
--Table ����
create table test1 (
eno number(4),
ename varchar2(20),
esal number(7)
);
desc test1;
drop table member1;

--Table ����
create table test2 as select * from test1;
insert into test1 values (1, '����ȣ', 5);

--Table ���� ����
--�������� ���� ������ �����ϸ� �ش� �ο츦 �߰����� ���ϱ� ������ �� ���̺��� ����
create table test3 as select * from test1 where 1=0;
select * from test3;
desc test3

--�÷� �߰��ϱ�
alter table test1 add(email varchar2(10));

--�÷� �����ϱ�
alter table test1 modify(email varchar2(40));

--�÷� �����ϱ�
alter table test1 drop column email;

--���̺��� ��� �ο� ����
select * from test1;
truncate table test1;

--[���̺� ���� ��Ģ]

--���̺���� ��ü�� �ǹ��� �� �ִ� ������ �̸��� ����Ѵ�. ������ �ܼ����� �ǰ��Ѵ�.--
--���̺���� �ٸ� ���̺��� �̸��� �ߺ����� �ʾƾ� �Ѵ�.--
--�� ���̺� �������� Į������ �ߺ��ǰ� ������ �� ����. --
--���̺� �̸��� �����ϰ� �� Į������ ��ȣ "( )" �� ���� �����Ѵ�.--
--�� Į������ �޸�" ", �� ���еǰ�, �׻� ���� �����ݷ� ";"���� ������.--
--Į���� ���ؼ��� �ٸ� ���̺���� ����Ͽ� �����ͺ��̽� �������� �ϰ��� �ְ� ����ϴ� ���� ����. (������ ǥ��ȭ ����)--
--Į�� �ڿ� ������ ������ �� �����Ǿ�� �Ѵ�.--
--���̺��� Į������ �ݵ�� ���ڷ� �����ؾ� �ϰ�, �������� ���̿� ���� �Ѱ谡 �ִ�.--
--�������� ������ ������ �����(Reserved word)�� �� �� ����.--
--A-Z, a-z, 0-9, _, $, # ���ڸ� ���ȴ�.

--���̺� ����Ʈ�� ��ȸ
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

--����12_0509. md�� �ִ� ���̺���� �̿��ؼ� hmkd ������ ������ ���̺��� �����ϰ� �ֿ� Ư¡��
--����ؼ� ����ϼ���.(���̺��� 5�� �̻�)

--Q. MEMBER1 ���̺��� ����(��� ������ Ÿ�� ����)�ϰ� 2���� ������ �Է� �� Į�� �߰�, Ÿ�� ����, 
--Į�� ����, �������� �߰�, ������ �� ����ϼ���.
DROP TABLE MEMBER1;
CREATE TABLE MEMBER1 AS SELECT * FROM MEMBER;
TRUNCATE TABLE MEMBER1;
DESC MEMBER1;
INSERT INTO MEMBER1 (ID, PWD, NAME) VALUES('200901','111','kevin');
INSERT INTO MEMBER1 VALUES('200902','112','park','1',23,'2000-01-01','010-1234-5678',(DATE '2000-01-01'));
SELECT * FROM MEMBER1;
ALTER TABLE MEMBER1 MODIFY(ID NVARCHAR2(10),PWD NVARCHAR2(6));
ALTER TABLE MEMBER1 ADD HOBBY NCLOB;
INSERT INTO MEMBER1 (ID, PWD, NAME, HOBBY) VALUES('200903','113','k','���� ��̴� �ڵ��̴�');
ALTER TABLE MEMBER1 DROP COLUMN HOBBY;
ALTER TABLE MEMBER1 ADD CONSTRAINT MEMBER_PK PRIMARY KEY(ID);
ALTER TABLE MEMBER1 DROP CONSTRAINT MEMBER_PK; 

--����1_0510. MEMBER2 ���̺��� �����Ͽ� DDL ��ü ��ɾ ����ϴ� �ڵ带 �ۼ��ϼ���.

--[DML]
--IN : OR ��� ���
SELECT EMPLOYEE_ID, MANAGER_ID FROM EMPLOYEES;
select * from employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id IN(101,102,103);

--BETWEEN AND : AND ��� ��� 101 ~ 105
select EMPLOYEE_ID, MANAGER_ID from employees where manager_id between 101 and 105;

--null ���� �͸� ���, null�� �ƴ� �͸� ���
SELECT EMPLOYEE_ID, COMMISSION_PCT FROM EMPLOYEES;
select EMPLOYEE_ID, COMMISSION_PCT from employees where commission_pct is null;
select EMPLOYEE_ID, COMMISSION_PCT from employees where commission_pct is not null;

--ORDER BY
SELECT employee_id, last_name, salary FROM employees;
select employee_id, salary from employees order by salary;
select employee_id, salary from employees order by salary desc;
select employee_id, last_name, salary from employees order by salary,last_name desc;

--dual table
--select �� ������ �ݵ�� from ���� ����ؾ� �Ѵ�.
--������ ��� select �� ��ü������ ������ �����ϱ� ������ from �� �ڿ� �� ���̺��� �ʿ����.
--�̷� ��� ����� �� �ִ� Dummy ���̺��� DUAL ���̺��̴�.

--mod : ������
select employee_id, last_name from employees where mod(employee_id, 2)=1;
select mod( 10, 3 ) from dual;

--round() : �ݿø� �Լ�
select round(355.95555) from dual;
select round(355.95555, 2) from dual;
select round(355.95555, -1) from dual;

--trunc() ���� �Լ�, ������ �ڸ��� ���ϸ� ���� ����� ��ȯ
select trunc(45.5555) from dual;
select trunc(45.5555,2) from dual;

--��¥ ���� �Լ�
select sysdate from dual;
select sysdate+1 from dual;
select sysdate-1 from dual;

select last_name, hire_date, sysdate-hire_date �ٹ��ϼ� from employees;
select last_name, hire_date, add_months(hire_date,6) from employees;
select last_day(sysdate) - sysdate from dual;
select hire_date, next_day(hire_date, '��') from employees;
select last_name, months_between(sysdate,hire_date) from employees;

--�� ��ȯ
--to_date : ���ڸ� ��¥�� ��ȯ
select to_date('20210101') from dual;
--to_char : ��¥�� ���ڷ� ��ȯ
select to_char(sysdate, 'yy/mm/dd') from dual;
select to_char(sysdate, 'yy/mm/dd hh24:mi:ss') from dual;

--����
--YYYY 		�� �ڸ� ����
--YY		�� �ڸ� ����
--YEAR		���� ���� ǥ��
--MM		���� ���ڷ�
--MON		���� ���ĺ�����
--DD		���� ���ڷ�
--DAY		���� ǥ��
--DY		���� ��� ǥ��
--D		���� ���� ǥ��
--
--AM �Ǵ� PM	���� ����
--HH �Ǵ� HH12	12�ð�
--HH24		24�ð�
--MI		��
--SS		��

--���� �Լ�
select upper('Hello World') from dual;
select lower('Hello World') from dual;

select last_name, salary from employees where last_name='seo';
select last_name, salary from employees where upper(last_name)='SEO';
--ù���ڸ� �빮��
select job_id, initcap(job_id) from employees;

--length()
select job_id, length(job_id) from employees;

--instr(���ڿ�, ã�� ����, ã�� ��ġ, ã�� ���� �� �� �� °)	
select instr('Hello World', 'o', 3, 2) from dual;

--substr(���ڿ�, ������ġ, ����)
select substr('Hello World', 3, 3) from dual;
select substr('Hello World', -3, 3) from dual;

--lpad(), rpad() ����, ������ ���� �� ���ڸ� ä���.
select lpad('Hello World',20,'#') from dual;
select rpad('Hello World',20,'#') from dual;

--ltrim(), rtrim() ��, ���� Ư�� ���� ����
select ltrim('aaaHello Worldaaa', 'a') from dual;
select rtrim('aaaHello Worldaaa', 'a') from dual;

--trim() : �յ��� Ư�� ���� ����
select last_name, trim('A' from last_name) new_name from employees;

--nvl() : null�� 0 �Ǵ� �ٸ� ������ ��ȯ
select salary, nvl(commission_pct,0) from employees;
select last_name, manager_id from employees;
select last_name, nvl(to_char(manager_id),'ceo') from employees;

--decode(): if���̳� case���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
select last_name, department_id,
decode(department_id,
90, '�濵������',
60, '���α׷���',
100, '�λ��') �μ���
from employees;

--case() : decode() �Լ��� �����ϳ� decode() �Լ��� ������ ������ ��츸 ����������
--case() �Լ��� �پ��� �񱳿����ڷ� ������ ����
select last_name, department_id,
case when department_id=90 then '�濵������'
     when department_id=60 then '���α׷���'
     when department_id=100 then '�λ��'
     when department_id=30 then '������'
     when department_id=50 then '������' end as �μ���
from employees;

--first_value() over() : �׷��� ù��° ���� ���Ѵ�.
select first_name �̸�, salary ����,
first_value(salary) over(order by salary desc) �ְ���
from employees;

--3�� ���� ������ �� ù��° ��
select first_name �̸�, salary ����,
first_value(salary) over(order by salary desc rows 3 preceding) �ְ���
from employees;

--���� + 2000 ���� �� ù��° ��
select first_name �̸�, salary ����,
first_value(salary) over(order by salary desc range 2000 preceding) �ְ���
from employees;

--sum() over() : ���Ŀ� ���� �׷��� ���� �հ踦 ���Ѵ�.
select department_id, last_name, sum(salary) over(order by department_id) 
from employees;

--INSERT
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);
select * from member;
desc member;
insert into member (id, pwd, name) values ('200903','113','�迬��');
insert into member values ('200904','113','���¼�','0',20,'2001-12-30','010-1234-5678',sysdate);

--UPDATE
--UPDATE ������ �����Ǿ�� �� Į���� �����ϴ� ���̺���� �Է��ϰ�,
--SET ������ �����Ǿ�� �� Į����� �ش� Į�� ���� ������ ������ �̷������.
--UPDATE ���̺�� SET �����Ǿ�� �� Į���� = �����Ǳ⸦ ���ϴ� ���ο� ��;
--[����] UPDATE PLAYER SET POSITION = 'MF��;

select * from member;
update member set name='�߽ż�' where id = '200902';

--update�� ������ db�� �ݿ�
commit;
--DELETE
--DELETE FROM ������ ������ ���ϴ� �ڷᰡ ����Ǿ� �ִ� ���̺���� �Է��ϰ� �����Ѵ�. 
--�̶� FROM ������ ������ ������ Ű�����̴�. 
--DELETE [FROM] ������ ���ϴ� ������ �ִ� ���̺��;
--[����] DELETE FROM PLAYER;
delete member where id='200901';
insert into member (id) values('200902');
alter table member add constraint member_pk primary key (id);
delete member where pwd='111';
desc member;

--UNION
--UNION( ������ ) INTERSECT( ������ ) MINUS( ������ ) UNION ALL( ��ġ�� �ͱ��� ���� )
--�� ���� �������� ����ؾ� �Ѵ�. ������ Ÿ���� ��ġ ���Ѿ� �Ѵ�.
select first_name �̸�, hire_date �Ի���, salary �޿� from employees 
where salary < 5000
union
select first_name �̸�, hire_date �Ի���,salary �޿� from employees 
where hire_date < '05/01/01'
order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees 
where salary < 5000
intersect
select first_name �̸�, hire_date �Ի���,salary �޿� from employees 
where hire_date < '05/01/01'
order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees 
where salary < 5000
minus
select first_name �̸�, hire_date �Ի���,salary �޿� from employees 
where hire_date < '05/01/01'
order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees 
where salary < 5000
union all
select first_name �̸�, hire_date �Ի���,salary �޿� from employees 
where hire_date < '05/01/01'
order by �Ի���;

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

--����2_0510. test5, test6�� ������, ������, ���̸� where�� �̿��ؼ� ���ϼ���. 

--����3_0510. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���.
--join~on, where �� �����ϴ� �� ���� ��� ��� ���.

--����4_0510. employees, jobs, departments ������ ���̺��� �����ؼ� employee_id, job_title, 
--department_name�� ����ϼ���.

--����5_0510. hr�� ���ԵǴ� 6���� ���̺���� �м��ؼ� �λ���Ʈ�� ���� �� �ִ�
--������� 5�� �̻� ����ϼ���. 
--(�� : �μ��� ��� SALARY ����)
SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY)) AVG
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;