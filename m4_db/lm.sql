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