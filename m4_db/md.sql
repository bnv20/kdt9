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

--과제5_0508. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.

--과제6_0508. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.

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

--과제8_0508. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 검색하시오

--과제9_0508. 도서를 주문하지 않은 고객의 이름을 검색하시오

--과제10_0508. 주문이 있는 고객의 이름과 주소를 검색하시오