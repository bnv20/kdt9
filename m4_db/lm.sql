--DEMOGRAPHIC DATA
SELECT COUNT(*) 
FROM DEMO
ORDER BY ����ȣ;

--���޻纰 ����� �̿���Ȳ
SELECT * FROM COMPET;

--�����
SELECT * FROM MEMBERSHIP;

--��ǰ�з�
SELECT * FROM PRODCL;

--���ŵ�����
SELECT COUNT(*) FROM PURPROD;
SELECT * FROM PURPROD;

--�����հ�
SELECT SUM(���űݾ�)
FROM PURPROD;

--PURPROD ����
CREATE TABLE PURPROD1 AS SELECT * FROM PURPROD;

--������ �����հ�
ALTER TABLE PURPROD1 ADD YEAR DATE;
ALTER TABLE PURPROD1 MODIFY YEAR VARCHAR2(20);
UPDATE PURPROD1 SET YEAR=SUBSTR(��������,1,4);
COMMIT;

SELECT YEAR, SUM(���űݾ�) ���ž�
FROM PURPROD1
GROUP BY YEAR;

CREATE TABLE AMT14
AS SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ� 
FROM PURPROD
WHERE �������� < 20150101
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

select * from amt14;

CREATE TABLE AMT15
AS SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ� 
FROM PURPROD
WHERE �������� > 20141231
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

select * from amt15;

--FULL OUTER JOIN ���̺� ����
CREATE TABLE AMT_YEAR_FOJ
AS SELECT A4.����ȣ, A4.���޻�, A4.���űݾ� ����14, A5.���űݾ� ����15
FROM AMT14 A4 FULL OUTER JOIN AMT15 A5
ON (A4.����ȣ=A5.����ȣ AND A4.���޻�=A5.���޻�);

--FULL OUTER JOIN ����� ���� ���
SELECT ����ȣ,���޻�, NVL(����14,0) ����14, NVL(����15,0) ����15,
(NVL(����15,0)-NVL(����14,0)) ����
FROM AMT_YEAR_FOJ A;

--�ݱ⺰ ���űݾ�
ALTER TABLE PURPROD1 ADD MONTH VARCHAR2(20);
UPDATE PURPROD1 SET MONTH=SUBSTR(��������,1,6);
COMMIT;

DESC PURPROD1;
ALTER TABLE PURPROD1 ADD HYEAR VARCHAR2(20);

UPDATE PURPROD1 
SET HYEAR=
CASE WHEN MONTH <=201406 THEN '20141H'
WHEN MONTH <=201412 THEN '20142H'
WHEN MONTH <=201506 THEN '20151H'
ELSE '20152H' 
END;
COMMIT;
SELECT * FROM PURPROD1;

SELECT HYEAR, ROUND((SUM(���űݾ�)/1000000)) �ݱⱸ��_�鸸, ROUND(AVG(���űݾ�)) ��ձ��� 
FROM PURPROD1
GROUP BY HYEAR
ORDER BY HYEAR;

DESC PURPROD1;

--���� �����հ�
SELECT ����ȣ, SUM(���űݾ�) ���ž�
FROM PURPROD1
GROUP BY ����ȣ
ORDER BY ����ȣ;

--���� ���޻纰 ���� �հ�
SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���ž�
FROM PURPROD1
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

--���� ���޻纰 ��ǰ��з� ���� �հ�
SELECT ����ȣ, ���޻�, ��з��ڵ�, SUM(���űݾ�) ���ž�
FROM PURPROD1
GROUP BY ����ȣ, ���޻�, ��з��ڵ�
ORDER BY ����ȣ;

--����8_0511. lm ������ ���̺� 6���� l���� ���� ��Ȳ�� �ľ��� �� �ִ� ��� ���̺��� 
--5�� �̻� �����ϰ� �����ϼ���.

--���̺� ���� : DEMO + PURPROD
SELECT d.����ȣ, SUM(p.HYEAR='201406'), sum(p.HYEAR='201412') 
FROM DEMO d, PURPROD1 p
WHERE d.����ȣ = p.����ȣ
GROUP BY d.����ȣ;

--���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ����
SELECT * FROM PURPROD1;

CREATE TABLE CUSPUR
AS SELECT ����ȣ, 
SUM(CASE WHEN HYEAR='20141H' THEN ���űݾ� ELSE 0 END) AS H1,
SUM(CASE WHEN HYEAR='20142H' THEN ���űݾ� ELSE 0 END) AS H2,
SUM(CASE WHEN HYEAR='20151H' THEN ���űݾ� ELSE 0 END) AS H3,
SUM(CASE WHEN HYEAR='20152H' THEN ���űݾ� ELSE 0 END) AS H4
FROM PURPROD1
GROUP BY ����ȣ
ORDER BY ����ȣ;
SELECT * FROM CUSPUR;

--DEMO�� CUSPUR ����ȣ ���� ���� : CUSDP
DESC DEMO;
DROP TABLE CUSDP;
CREATE TABLE CUSDP
AS SELECT CP.*, D.����, D.���ɴ�, D.��������
FROM CUSPUR CP, DEMO D 
WHERE D.����ȣ = CP.����ȣ;

CREATE TABLE CUSDEPU
AS SELECT * 
FROM CUSDP
ORDER BY ����ȣ;

SELECT * FROM CUSDEPU;

--����1_0512. LM ��� ������ �ľ��� �� �ִ� ��ü, ��, ��ǰ�� ���̺��� 3�� �̻� �ۼ��ϼ���.
