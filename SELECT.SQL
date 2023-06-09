SELECT COUNT(*)
  FROM LO_OUT_D;
  
  
SELECT *
  FROM LO_OUT_M;


SELECT *
  FROM LO_OUT_D;
  
  
SELECT DISTINCT OUTBOUND_BATCH, OUT_TYPE_DIV
  FROM LO_OUT_M;


SELECT INVOICE_NO, OUTBOUND_DATE
  FROM LO_OUT_M;
  
  
SELECT *
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE = '2019-06-03' -- TO_DATE('20190603','YYYY-MM-DD')
   AND OUTBOUND_NO = 'D190603-897837';
       
       
SELECT INVOICE_NO, OUTBOUND_BATCH, SET_TYPE_NM, SET_QTY
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE = TO_DATE('20190603','YYYY-MM-DD')
   AND OUT_TYPE_DIV  IN ('M11', 'M12', 'M13')
   AND WORK_SEQ      BETWEEN 1 AND 2
   AND INVOICE_NO    LIKE '3467247280%'||'%'
 ORDER BY OUTBOUND_BATCH, SET_TYPE_NM;


SELECT DISTINCT ITEM_CD, ITEM_NM
  FROM LO_OUT_D
 WHERE ITEM_NM LIKE '뉴트리플랜'||' %'
   AND ORDER_QTY >50
   AND OUT_TYPE_DIV_D IN ('M12','M15')
 ORDER BY ITEM_NM;   
   
   
SELECT ITEM_CD, ITEM_NM
  FROM LO_OUT_D
 WHERE ITEM_NM LIKE '뉴트리플랜' || '%'
   AND ORDER_QTY > 50
   AND OUT_TYPE_DIV_D IN ('M12', 'M15')
 GROUP BY ITEM_CD, ITEM_NM
 ORDER BY ITEM_NM;
   
   
SELECT OUTBOUND_BATCH, SET_TYPE_NM, SUM(SET_QTY) AS SUM_SET_QTY
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE = TO_DATE('20190603','YYYY-MM-DD')
   AND OUT_TYPE_DIV IN('M11','M12','M13')
   AND WORK_SEQ BETWEEN 1 AND 2
   AND INVOICE_NO LIKE '346724728%'
 GROUP BY OUTBOUND_BATCH, SET_TYPE_NM
HAVING SUM(SET_QTY) = 1
 ORDER BY OUTBOUND_BATCH, SET_TYPE_NM;
   
   
SELECT INVOICE_NO, OUTBOUND_DATE, TO_CHAR(OUTBOUND_DATE, 'YYYY-MM')AS YYYYMM, OUTBOUND_NO, OUTBOUND_BATCH, SET_TYPE_NM
  FROM LO_OUT_M;

   
SELECT 1 AS NO
  FROM DUAL  
UNION ALL   
SELECT 2 AS NO
 FROM DUAL   
   
   
SELECT ROWNUM AS RNK, 
       OUTBOUND_DATE,
       INVOICE_CNT
  FROM (
       SELECT OUTBOUND_DATE,
              COUNT(1) AS INVOICE_CNT
         FROM LO_OUT_M
        WHERE OUTBOUND_DATE BETWEEN :OUTBOUND_DATE1 AND :OUTBOUND_DATE2
        GROUP BY OUTBOUND_DATE
        ORDER BY INVOICE_CNT DESC
      )  
 WHERE ROWNUM <= 5   
   
   
SELECT BRAND_CD, COUNT(*) AS INV_CNT
  FROM A_OUT_M
 GROUP BY BRAND_CD
 ORDER BY BRAND_CD
 
 
SELECT SUM(ORDER_QTY)
FROM A_OUT_D
WHERE BRAND_CD = '1001'
AND ITEM_CD = 'A'


SELECT *
  FROM A_OUT_M
 WHERE OUTBOUND_DATE = '2023-01-03'


SELECT BRAND_CD, INVOICE_NO, OUT_TYPE_DIV, ORDER_NM
  FROM A_OUT_M
 WHERE OUTBOUND_DATE = '2023-01-03'
 ORDER BY BRAND_CD, INVOICE_NO, OUT_TYPE_DIV, ORDER_NM


SELECT *
  FROM A_OUT_M
 WHERE OUTBOUND_DATE = '2023-01-04'
   AND ORDER_NM = '김민기'
   
   
SELECT *
  FROM A_OUT_D
 WHERE ITEM_CD = 'A'
 
 
 SELECT *
   FROM A_OUT_D
  WHERE ITEM_CD = 'C'
    AND ORDER_QTY >= 3
 
 
SELECT *
  FROM A_ITEM
 WHERE BRAND_CD = '1001'
 
 
SELECT BRAND_CD, OUTBOUND_DATE, INVOICE_NO, ORDER_NM
  FROM A_OUT_M
 WHERE OUTBOUND_DATE IN ('2023-01-03','2023-01-04')
    
   
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE BRAND_CD = '1001' 
   AND ITEM_CD IN ('A','B','C') 
   AND ORDER_QTY >=3
 
 
 SELECT BRAND_CD, INVOICE_NO, OUTBOUND_DATE, ORDER_NM
   FROM A_OUT_M
  WHERE OUTBOUND_DATE BETWEEN :OUTBOUND_DATE1 AND :OUTBOUND_DATE2
    AND ORDER_NM IN ('윤현수', '김민기')
   
   
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO IN ('#01', '#02', '#03', '#04', '#05')
   AND ITEM_CD IN ('A','B', 'C')
   AND ORDER_QTY >=3
   
   
SELECT BRAND_CD, INVOICE_NO, OUTBOUND_DATE, ORDER_NM
  FROM A_OUT_M
 WHERE INVOICE_NO BETWEEN '#01' AND '#05'
   AND (ORDER_NM LIKE '전%' OR ORDER_NM LIKE '권%')
   
   
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO LIKE '#0%'
   AND ORDER_QTY >=3
   
   
   
--인보이스가 #0으로 시작하고 주문수량이 3이상인 주문의[브랜드], [인보이스], [상품코드], [주문수량]을 표시하되, 주문수량이 많은 것부터 먼저 표시해 줘!
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO LIKE '#0%'
   AND ORDER_QTY>=3
 ORDER BY ORDER_QTY DESC, ITEM_CD --ASC