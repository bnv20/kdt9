--DEMOGRAPHIC DATA
SELECT COUNT(*) 
FROM DEMO
ORDER BY 고객번호;

--제휴사별 경쟁사 이용현황
SELECT * FROM COMPET;

--멤버십
SELECT * FROM MEMBERSHIP;

--상품분류
SELECT * FROM PRODCL;

--구매데이터
SELECT COUNT(*) FROM PURPROD;
SELECT * FROM PURPROD;

--구매합계
SELECT SUM(구매금액)
FROM PURPROD;

--PURPROD 복사
CREATE TABLE PURPROD1 AS SELECT * FROM PURPROD;

--연도별 구매합계
ALTER TABLE PURPROD1 ADD YEAR DATE;
ALTER TABLE PURPROD1 MODIFY YEAR VARCHAR2(20);
UPDATE PURPROD1 SET YEAR=SUBSTR(구매일자,1,4);
COMMIT;

SELECT YEAR, SUM(구매금액) 구매액
FROM PURPROD1
GROUP BY YEAR;

--고객별 구매합계
SELECT 고객번호, SUM(구매금액) 구매액
FROM PURPROD1
GROUP BY 고객번호
ORDER BY 고객번호;

--고객별 제휴사별 기준 합계
SELECT 고객번호, 제휴사, SUM(구매금액) 구매액
FROM PURPROD1
GROUP BY 고객번호, 제휴사
ORDER BY 고객번호;

--고객별 제휴사별 상품대분류 기준 합계
SELECT 고객번호, 제휴사, 대분류코드, SUM(구매금액) 구매액
FROM PURPROD1
GROUP BY 고객번호, 제휴사, 대분류코드
ORDER BY 고객번호;

--과제8_0511. lm 데이터 테이블 6개로 l사의 비즈 현황을 파악할 수 있는 요약 테이블을 
--5개 이상 생성하고 설명하세요.