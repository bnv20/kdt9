select * from book;
-- Q. 모든 도서의 도서이름, 출판사를 검색하시오.
SELECT bookname, publisher
FROM book;

-- Q. 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT	bookid, bookname, publisher, price
FROM	Book;

--중복 제외
SELECT DISTINCT publisher
FROM book;

--가격이 10,000원 이상인 도서
select * 
from book
where price >= 10000;

--Q. 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT * 
FROM book
where price >= 10000 and price <= 20000;

SELECT * 
FROM book
where price between 10000 and 20000;

--Q. 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
select * from book
where publisher='굿스포츠' or publisher='대한미디어';

select * from book
where publisher in('굿스포츠','대한미디어');

--Q. 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’가 아닌 도서를 검색하시오.
SELECT * FROM book
WHERE publisher not in('굿스포츠','대한미디어');

SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '축구의 역사';

--책이름에 '축구'가 포함되어 있는 도서를 검색하시오.
SELECT * FROM book
WHERE bookname LIKE '%축구%';

--Q. 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT * FROM book
WHERE bookname LIKE '%_구%';

--Q. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
select * from book
where bookname like'%축구%' and price>=20000;

--정렬(default 올림차순)
select * 
from book
order by bookname desc;

--Q. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
select *
from book
order by price, bookname;

--Q. 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오.
select * 
from book
order by price desc, publisher;

select * from orders;

select sum(saleprice) as "총 매출"
from orders;

--Q. custid 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
select sum(saleprice)
from orders
where custid = 2;

--과제1_0508. orders 테이블에서 saleprice의 합계, 평균, 최소값, 최대값을 구하세요.
select sum(saleprice), AVG(saleprice), min(saleprice), max(saleprice)
from orders;

--과제2_0508. orders 테이블에서 도서수량, 총판매액을 구하세요.
SELECT count(*) AS "도서수량", SUM(saleprice) AS "총판매액"
FROM orders;

--과제3_0508. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
--having절은 group by절과 함께 사용되어 그룹화된 결과 집합을 필터링하는데 사용됨.
--where 집합에 대한 조건을 지정하는 반면 having절은 집계함수 결과에 대한 조건을 지정
select custid as "고객id", count(*) as "주문 도서 수량"
from orders
where saleprice>=8000
group by custid
having count(*)>=2;

select * 
from customer, orders
where customer.custid=orders.custid
order by orders.custid;

--Q. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
select c.custid,o.custid, name, saleprice
from customer c, orders o
where c.custid=o.custid;

--과제4_0508. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT custid, SUM(saleprice) "총 판매액"
FROM orders
GROUP BY custid
ORDER BY custid;

--과제5_0508. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select c.name, b.bookname 
from customer c, orders o, book b 
where c.custid=o.custid and b.bookid=o.bookid;

--과제6_0508. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid=B.bookid AND B.price = 20000;

--JOIN : inner join vs outer join
select c.custid,o.custid, c.name, o.saleprice
from customer c, orders o
where c.custid=o.custid;

select c.custid,o.custid, c.name, o.saleprice
from customer c, orders o
where c.custid=o.custid(+);

select c.custid,o.custid, c.name, o.saleprice
from customer c left outer join orders o on c.custid=o.custid;

--부속 질의
--가장 비싼 도서의 이름을 출력하세요.
select bookname,price
from book
where price=(select MAX(price) from book);

--Q. 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
select * from orders;
select * from customer;
select name 
from customer 
where custid in (select custid from Orders);

--과제7_0508. ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 검색하시오
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book 
WHERE publisher = '대한미디어'));

--과제8_0508. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 검색하시오
select * from book;
select b1.bookname 
from book b1
where b1.price > (select avg(price) 
from book b2 where b2.publisher=b1.publisher);

--과제9_0508. 도서를 주문하지 않은 고객의 이름을 검색하시오
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

--과제10_0508. 주문이 있는 고객의 이름과 주소를 검색하시오
SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM orders);

SELECT name, address
FROM customer cs
WHERE EXISTS(SELECT * FROM orders od 
WHERE cs.custid = od.custid);

--계산
SELECT ABS(-78), ABS(+78) FROM dual;
SELECT ROUND(4.875, 1) FROM dual;

--Q.고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
select custid, round(sum(saleprice)/count(*),-2) as 평균금액
from orders
group by custid;

--Q.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 구하세요.
select bookid, replace(bookname,'야구','농구') bookname, price 
from book;

--Q.‘굿스포츠’에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 구하세요.
select bookname 제목, length(bookname) 글자수, lengthb(bookname) 바이트수
from book
where publisher='굿스포츠';

--데이터 입력
INSERT INTO Customer VALUES (6, '박찬호', '대한민국 공주', NULL);

--Q.마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하세요
select substr(name, 1, 1) 성, count(*) 인원
from customer
group by substr(name, 1, 1);

--Q.마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하세요.
select * from orders;
select orderid,orderdate as "주문일", orderdate+10 as "주문 확정일"
from orders;

--현재 날짜
select sysdate from dual;
--TO_CHAR 함수를 사용하여 SYSDATE 값을 문자열 형식으로 변환
select sysdate, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') sysdate1 from dual;

--과제1_0509.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 
--모두 구하세요. 단, 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
SELECT orderid 주문번호, TO_CHAR(orderdate, 'YYYY-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = '2020-07-07';

--과제2_0509. DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

--NVL 함수는 두개의 인수만 비교하고 COALESCE 함수는 여러 인수를 비교하고 첫번째 NULL이 아닌 인수의 
--데이터 타입으로 결과를 반환
--과제3_0509. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 
--표시하세요.(NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다.
--함수  :  NVL("값", "지정값") 
select * from customer;
SELECT name 이름, NVL(phone, '연락처없음') 전화번호
FROM customer;

SELECT NAME 이름, PHONE, COALESCE(PHONE,'연락처없음') 전화번호
FROM CUSTOMER;

--과제4_0509. 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이세요.
SELECT ROWNUM 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE ROWNUM <= 2;

--과제5_0509. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이세요.
select orderid, saleprice
from orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--과제6_0509. 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 
--금액을 보이시오.
select orderid 주문번호, custid 고객번호, saleprice 금액
from orders o1
where o1.saleprice > (SELECT AVG(o2.saleprice) FROM orders o2 WHERE o1.custid=o2.custid);

--과제7_0509.‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하세요.
select sum(saleprice)
from orders o
where custid in (SELECT custid FROM customer WHERE address LIKE '%대한민국%');

--과제8_0509. 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.

--과제9_0509. EXISTS 연산자를 사용하여 ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.

--과제10_0509. 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력)
select * from customer;

select c.name 고객이름, nvl(sum(o.saleprice),0) "고객별 판매액"
from customer c, orders o
where c.custid = o.custid(+)
group by c.name;

--update set
update customer
set phone='010-1234-5678'
where custid=1;

--과제11_0509. 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)

-- View는 가상의 테이블이라고 했는데, 말그대로 데이터는 없고, SQL만 저장되어있는 object
--만들어진 뷰의 기본 테이블의 기본키(속성)을 포함하여 뷰를 생성하면 삽입, 삭제, 갱신, 연산이 가능 합니다. 
--또한 한번 정의가 된 뷰의 경우 다른 뷰의 기본 데이터가 될 수 있으며, 뷰에 정의되어 있는 기본 테이블이나 뷰를 삭제 하게 되면 
--해당 데이터를 기초로한 다른 뷰들이 자동으로 삭제가 됩니다.뷰에서는 ALTER 명령어를 사용 할 수 없습니다. 
select * from customer;
--Q.주소에 ‘대한민국’을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.
create view vw_customer
as select * 
from customer
where address like '%대한민국%';

select * from vw_customer;

drop view vw_customer;