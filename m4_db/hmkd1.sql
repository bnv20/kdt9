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








