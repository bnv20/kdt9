select * from book;
-- Q. ��� ������ �����̸�, ���ǻ縦 �˻��Ͻÿ�.
SELECT bookname, publisher
FROM book;

-- Q. ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
SELECT	bookid, bookname, publisher, price
FROM	Book;

--�ߺ� ����
SELECT DISTINCT publisher
FROM book;

--������ 10,000�� �̻��� ����
select * 
from book
where price >= 10000;

--Q. ������ 10,000�� �̻� 20,000 ������ ������ �˻��Ͻÿ�.
SELECT * 
FROM book
where price >= 10000 and price <= 20000;

SELECT * 
FROM book
where price between 10000 and 20000;

--Q. ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
select * from book
where publisher='�½�����' or publisher='���ѹ̵��';

select * from book
where publisher in('�½�����','���ѹ̵��');

--Q. ���ǻ簡 ���½������� Ȥ�� �����ѹ̵��� �ƴ� ������ �˻��Ͻÿ�.
SELECT * FROM book
WHERE publisher not in('�½�����','���ѹ̵��');

SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '�౸�� ����';

--å�̸��� '�౸'�� ���ԵǾ� �ִ� ������ �˻��Ͻÿ�.
SELECT * FROM book
WHERE bookname LIKE '%�౸%';

--Q. �����̸��� ���� �� ��° ��ġ�� ��������� ���ڿ��� ���� ������ �˻��Ͻÿ�.
SELECT * FROM book
WHERE bookname LIKE '%_��%';

--Q. �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
select * from book
where bookname like'%�౸%' and price>=20000;

--����(default �ø�����)
select * 
from book
order by bookname desc;

--Q. ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�
select *
from book
order by price, bookname;

--Q. ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ ����Ͻÿ�.
select * 
from book
order by price desc, publisher;

select * from orders;

select sum(saleprice) as "�� ����"
from orders;

--Q. custid 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select sum(saleprice)
from orders
where custid = 2;

--����1_0508. orders ���̺��� saleprice�� �հ�, ���, �ּҰ�, �ִ밪�� ���ϼ���.
select sum(saleprice), AVG(saleprice), min(saleprice), max(saleprice)
from orders;

--����2_0508. orders ���̺��� ��������, ���Ǹž��� ���ϼ���.
SELECT count(*) AS "��������", SUM(saleprice) AS "���Ǹž�"
FROM orders;

--����3_0508. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
--having���� group by���� �Բ� ���Ǿ� �׷�ȭ�� ��� ������ ���͸��ϴµ� ����.
--where ���տ� ���� ������ �����ϴ� �ݸ� having���� �����Լ� ����� ���� ������ ����
select custid as "��id", count(*) as "�ֹ� ���� ����"
from orders
where saleprice>=8000
group by custid
having count(*)>=2;

select * 
from customer, orders
where customer.custid=orders.custid
order by orders.custid;

--Q. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
select c.custid,o.custid, name, saleprice
from customer c, orders o
where c.custid=o.custid;

--����4_0508. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT custid, SUM(saleprice) "�� �Ǹž�"
FROM orders
GROUP BY custid
ORDER BY custid;

--����5_0508. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
select c.name, b.bookname 
from customer c, orders o, book b 
where c.custid=o.custid and b.bookid=o.bookid;

--����6_0508. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
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

--�μ� ����
--���� ��� ������ �̸��� ����ϼ���.
select bookname,price
from book
where price=(select MAX(price) from book);

--Q. ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
select * from orders;
select * from customer;
select name 
from customer 
where custid in (select custid from Orders);

--����7_0508. �����ѹ̵����� ������ ������ ������ ���� �̸��� �˻��Ͻÿ�
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book 
WHERE publisher = '���ѹ̵��'));

--����8_0508. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ �˻��Ͻÿ�
select * from book;
select b1.bookname 
from book b1
where b1.price > (select avg(price) 
from book b2 where b2.publisher=b1.publisher);

--����9_0508. ������ �ֹ����� ���� ���� �̸��� �˻��Ͻÿ�
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

--����10_0508. �ֹ��� �ִ� ���� �̸��� �ּҸ� �˻��Ͻÿ�
SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM orders);

SELECT name, address
FROM customer cs
WHERE EXISTS(SELECT * FROM orders od 
WHERE cs.custid = od.custid);

--���
SELECT ABS(-78), ABS(+78) FROM dual;
SELECT ROUND(4.875, 1) FROM dual;

--Q.���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
select custid, round(sum(saleprice)/count(*),-2) as ��ձݾ�
from orders
group by custid;

--Q.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���ϼ���.
select bookid, replace(bookname,'�߱�','��') bookname, price 
from book;

--Q.���½����������� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���ϼ���.
select bookname ����, length(bookname) ���ڼ�, lengthb(bookname) ����Ʈ��
from book
where publisher='�½�����';

--������ �Է�
INSERT INTO Customer VALUES (6, '����ȣ', '���ѹα� ����', NULL);

--Q.���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���ϼ���
select substr(name, 1, 1) ��, count(*) �ο�
from customer
group by substr(name, 1, 1);

--Q.���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���ϼ���.
select * from orders;
select orderid,orderdate as "�ֹ���", orderdate+10 as "�ֹ� Ȯ����"
from orders;

--���� ��¥
select sysdate from dual;
--TO_CHAR �Լ��� ����Ͽ� SYSDATE ���� ���ڿ� �������� ��ȯ
select sysdate, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') sysdate1 from dual;

--����1_0509.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� 
--��� ���ϼ���. ��, �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'YYYY-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '2020-07-07';

--����2_0509. DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

--NVL �Լ��� �ΰ��� �μ��� ���ϰ� COALESCE �Լ��� ���� �μ��� ���ϰ� ù��° NULL�� �ƴ� �μ��� 
--������ Ÿ������ ����� ��ȯ
--����3_0509. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� 
--ǥ���ϼ���.(NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�.
--�Լ�  :  NVL("��", "������") 
select * from customer;
SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
FROM customer;

SELECT NAME �̸�, PHONE, COALESCE(PHONE,'����ó����') ��ȭ��ȣ
FROM CUSTOMER;

--����4_0509. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̼���.
SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM <= 2;

--����5_0509. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̼���.
select orderid, saleprice
from orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--����6_0509. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, 
--�ݾ��� ���̽ÿ�.
select orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
from orders o1
where o1.saleprice > (SELECT AVG(o2.saleprice) FROM orders o2 WHERE o1.custid=o2.custid);

--����7_0509.�����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���ϼ���.
select sum(saleprice)
from orders o
where custid in (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

--����8_0509. 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.

--����9_0509. EXISTS �����ڸ� ����Ͽ� �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.

--����10_0509. ���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)
select * from customer;

select c.name ���̸�, nvl(sum(o.saleprice),0) "���� �Ǹž�"
from customer c, orders o
where c.custid = o.custid(+)
group by c.name;

--update set
update customer
set phone='010-1234-5678'
where custid=1;

--����11_0509. ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)

-- View�� ������ ���̺��̶�� �ߴµ�, ���״�� �����ʹ� ����, SQL�� ����Ǿ��ִ� object
--������� ���� �⺻ ���̺��� �⺻Ű(�Ӽ�)�� �����Ͽ� �並 �����ϸ� ����, ����, ����, ������ ���� �մϴ�. 
--���� �ѹ� ���ǰ� �� ���� ��� �ٸ� ���� �⺻ �����Ͱ� �� �� ������, �信 ���ǵǾ� �ִ� �⺻ ���̺��̳� �並 ���� �ϰ� �Ǹ� 
--�ش� �����͸� ���ʷ��� �ٸ� ����� �ڵ����� ������ �˴ϴ�.�信���� ALTER ��ɾ ��� �� �� �����ϴ�. 
select * from customer;
--Q.�ּҿ� �����ѹα����� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�.
create view vw_customer
as select * 
from customer
where address like '%���ѹα�%';

select * from vw_customer;

drop view vw_customer;