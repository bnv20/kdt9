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








