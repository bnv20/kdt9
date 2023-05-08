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

--����5_0508. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.

--����6_0508. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.

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

--����8_0508. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ �˻��Ͻÿ�

--����9_0508. ������ �ֹ����� ���� ���� �̸��� �˻��Ͻÿ�

--����10_0508. �ֹ��� �ִ� ���� �̸��� �ּҸ� �˻��Ͻÿ�