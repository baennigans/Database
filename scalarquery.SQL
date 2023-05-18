SELECT ROWNUM AS RNUM
       ,BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
FROM(
     SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
       FROM A_OUT_D
      WHERE INVOICE_NO LIKE '#0%'
        AND ORDER_QTY>=3
      ORDER BY ORDER_QTY DESC, ITEM_CD --ASC
    )
WHERE ROWNUM <= 2 
 
 
 
SELECT COUNT(*)
  FROM A_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2023-01-03' AND '2023-01-04' 
 
 
 
SELECT SUM(ORDER_QTY)
  FROM A_OUT_D
 WHERE BRAND_CD = '1001'
 
 
 
SELECT BRAND_CD, OUTBOUND_DATE, COUNT(INVOICE_NO)
  FROM A_OUT_M
 GROUP BY BRAND_CD, OUTBOUND_DATE
 ORDER BY BRAND_CD, OUTBOUND_DATE
 
 
 
SELECT BRAND_CD, ITEM_CD, SUM(ORDER_QTY)
  FROM A_OUT_D
 GROUP BY BRAND_CD, ITEM_CD 
 ORDER BY BRAND_CD, SUM(ORDER_QTY) DESC
 
 
  
SELECT BRAND_CD, MAX(ORDER_QTY), MIN(ORDER_QTY)
  FROM A_OUT_D
 GROUP BY BRAND_CD
 
 
 
SELECT INVOICE_NO, OUTBOUND_DATE, OUT_TYPE_DIV, OUT_BOX_DIV, OUT_BOX_NM
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-02'
   AND OUT_TYPE_DIV IN ('M15', 'M22')
   AND OUT_BOX_DIV LIKE 'F%'
   AND ORDER_PLACE = '52685'
 ORDER BY OUTBOUND_DATE, INVOICE_NO;
 
 
 
SELECT OUTBOUND_DATE,
       COUNT(OUTBOUND_DATE)          AS TOT_CNT,
       COUNT(DISTINCT OUT_BOX_DIV)   AS OUT_BOX_CNT,
       MIN(OUT_BOX_DIV)              AS OUT_BOX_MIN,
       MAX(OUT_BOX_DIV)              AS OUT_BOX_MAX 
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-02'
   AND OUT_TYPE_DIV  IN ('M15','M22')
   AND OUT_BOX_DIV   LIKE 'F%'
   AND ORDER_PLACE   ='52685'
 GROUP BY OUTBOUND_DATE
 ORDER BY OUTBOUND_DATE;
 
 
 
SELECT COUNT(*)           AS CNT1
      ,COUNT(CD)          AS CNT2
      ,COUNT(DISTINCT CD) AS CNT3
      ,COUNT(QTY)         AS CNT4
      ,COUNT(1)           AS CNT5
  FROM (
        SELECT 'A' AS CD, 1    AS QTY FROM DUAL UNION ALL 
        SELECT 'B' AS CD, 2    AS QTY FROM DUAL UNION ALL 
        SELECT 'C' AS CD, NULL AS QTY FROM DUAL UNION ALL 
        SELECT 'C' AS CD, 4    AS QTY FROM DUAL UNION ALL
        SELECT 'E' AS CD, 5    AS QTY FROM DUAL 
       )
 
 
 
SELECT *
  FROM A_OUT_D
 WHERE (BRAND_CD, INVOICE_NO) IN (
                                 SELECT BRAND_CD, INVOICE_NO
                                 FROM A_OUT_M
                                 WHERE OUTBOUND_DATE = '2023-01-03'      
                                 )
 ORDER BY BRAND_CD, INVOICE_NO;
 
 
 
SELECT *
  FROM A_OUT_D
 WHERE BRAND_CD = '1001'
   AND INVOICE_NO IN (
                      SELECT INVOICE_NO
                        FROM A_OUT_M
                       WHERE OUT_TYPE_DIV LIKE 'M1%'
                     )
 
 
SELECT *
  FROM A_OUT_M
 WHERE (BRAND_CD, INVOICE_NO) IN (
                                 SELECT BRAND_CD, INVOICE_NO
                                 FROM A_OUT_D
                                 GROUP BY BRAND_CD, INVOICE_NO
                                 HAVING SUM(ORDER_QTY) >=3
                                 )
 ORDER BY BRAND_CD, INVOICE_NO
 
 
 
SELECT M1.BRAND_CD
      ,M1.ITEM_CD
      ,(
       SELECT S1.ITEM_NM
         FROM A_ITEM S1
        WHERE S1.BRAND_CD = M1.BRAND_CD
          AND S1.ITEM_CD = M1.ITEM_CD
       ) AS ITEM_NM
       ,SUM(M1.ORDER_QTY) AS SUM_QTY
  FROM A_OUT_D M1
 GROUP BY M1.BRAND_CD, M1.ITEM_CD   
 ORDER BY M1.BRAND_CD  
       
       
       
SELECT DISTINCT OUTBOUND_DATE
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN :OUTBOUND_DATE AND :OUTBOUND_DATE + 9
 ORDER BY OUTBOUND_DATE
 
 
SELECT *
  FROM (
       SELECT TO_DATE('20190615','YYYY-MM-DD')+ NO AS OUT_DATE
         FROM CS_NO
        WHERE NO<=10
       ) M1
 WHERE EXISTS (
              SELECT 1
                FROM LO_OUT_M S1
               WHERE S1.OUTBOUND_DATE = M1.OUT_DATE
              )
       
       
--------------------------------------------------------------       
SELECT INVOICE_NO
      ,OUT_TYPE_DIV
      ,OUT_BOX_DIV
      ,(
        SELECT MAX(ORDER_QTY)
          FROM LO_OUT_D S1
         WHERE S1.INVOICE_NO = M1.INVOICE_NO
       )    AS MAX_ORDER_QTY
       ,SUBSTR(OUT_TYPE_DIV,1,2) AS SUB_VAL
       , 1                       AS VAL1
       ,'A'                      AS VAL2
       ,OUT_TYPE_DIV ||'-'||OUT_BOX_DIV AS AAA
       ,LENGTH(INVOICE_NO)              AS BBB
       ,TO_CHAR(OUTBOUND_DATE,'YYYYMMDD') AS CCC
       ,TO_CHAR(OUTBOUND_DATE,'YY-MM')  AS DDD
       ,TO_CHAR(OUTBOUND_DATE,'WW')     AS EEE
       ,TO_CHAR(OUTBOUND_DATE,'Q') AS FFF
  FROM LO_OUT_M M1
 WHERE OUTBOUND_DATE = '2019-06-03'
   AND OUTBOUND_NO BETWEEN 'D190603-897353' AND 'D190603-897360'
   
----------------------------------------------------------------    
SELECT SYSDATE                     AS CUR_DATETIME
      ,TRUNC(SYSDATE)              AS CUR_DATE
      ,SYSDATE+1                   AS TOMORROW
      ,SUBSTR('ABCD1234',3,5)      AS VAL1
      ,LPAD(34,10,'7')             AS LEFT_PADDING
      ,SUBSTR(LPAD(34,10,'7'),5,5) AS LEFT_PADDING_SUBSTR1
  FROM DUAL     
----------------------------------------------------------------       
       
       
SELECT INVOICE_NO
      ,OUT_TYPE_DIV
      ,OUT_BOX_DIV
      ,TO_NUMBER(SUBSTR(VAL,1,10))  AS MAX_ORDER_QTY 
      ,TO_NUMBER(SUBSTR(VAL,12,10)) AS MAX_LINE_NO
  FROM(
       SELECT INVOICE_NO
             ,OUT_TYPE_DIV
             ,OUT_BOX_DIV     
             ,(
              SELECT MAX(LPAD(ORDER_QTY,10,'0')) ||'-'|| MAX(LPAD(LINE_NO,10,'0'))
                FROM LO_OUT_D S1
               WHERE S1.INVOICE_NO = M1.INVOICE_NO
              ) AS VAL
         FROM LO_OUT_M M1
        WHERE OUTBOUND_DATE = '2019-06-03'
          AND OUTBOUND_NO BETWEEN 'D190603-897353' AND 'D190603-897360'
      )
       
       
       
       
SELECT BRAND_CD
      ,ITEM_CD
      ,ITEM_NM
      ,QTY_IN_BOX
      ,(
      SELECT SUM(ORDER_QTY)
        FROM A_OUT_D S1
       WHERE S1.ITEM_CD = M1.ITEM_CD
      )   AS SUM_ORDER_QTY
  FROM A_ITEM M1
 
 
 
 
SELECT M1.BRAND_CD
      ,M1.ITEM_CD
      ,C1.ITEM_NM
      ,C1.QTY_IN_BOX
      ,SUM(M1.ORDER_QTY)
  FROM A_OUT_D M1
       JOIN A_ITEM C1 ON C1.BRAND_CD = M1.BRAND_CD
                     AND C1.ITEM_CD = M1.BRAND_CD
 GROUP BY M1.BRAND_CD, M1.ITEM_CD
 ORDER BY M1.BRAND_CD, M1.ITEM_CD 
 
 
 
 
SELECT L1.BRAND_CD
      ,L1.ITEM_CD
      ,L1.SUM_QTY
      ,(
       SELECT S1.ITEM_NM
         FROM A_ITEM S1
        WHERE S1.BRAND_CD = L1.BRAND_CD
          AND S1.ITEM_CD = L1.ITEM_CD
       )AS VAL
      ,(
       SELECT S1.QTY_IN_BOX
         FROM A_ITEM S1
        WHERE S1.BRAND_CD = L1.BRAND_CD
          AND S1.ITEM_CD = L1.ITEM_CD
       )AS VAL2
  FROM(
       SELECT M1.BRAND_CD
             ,M1.ITEM_CD
             ,SUM(M1.ORDER_QTY) AS SUM_QTY
         FROM A_OUT_D M1
        GROUP BY M1.BRAND_CD, M1.ITEM_CD
        ORDER BY M1.BRAND_CD, M1.ITEM_CD
      ) L1
      
      
      
---------------------------------------------------------------------------------------
SELECT *
  FROM (
      SELECT BRAND_CD
            ,ITEM_CD
            ,ITEM_NM
            ,SUM_QTY
            ,QTY_IN_BOX
            ,TRUNC(SUM_QTY/QTY_IN_BOX) AS BOX_CNT
            ,MOD(SUM_QTY,QTY_IN_BOX)   AS PCS_CNT
        FROM (
              --4)박스입수와 상품명을 분리함   
              SELECT BRAND_CD
                    ,ITEM_CD
                    ,SUM_QTY
                    ,TO_NUMBER(SUBSTR(VAL,1,3))   AS QTY_IN_BOX
                    ,SUBSTR(VAL,4,100)            AS ITEM_NM
                FROM(--3)박스입수와 상품명을 연결하여 하나의 컬럼으로 가져옴          
                     SELECT L1.BRAND_CD
                           ,L1.ITEM_CD
                           ,L1.SUM_QTY
                           ,(--2)삼품명과 박스입수를 가져오는 스칼라쿼리       
                           SELECT LPAD(S1.QTY_IN_BOX,3,'0') || S1.ITEM_NM
                             FROM A_ITEM S1
                            WHERE S1.BRAND_CD = L1.BRAND_CD
                              AND S1.ITEM_CD = L1.ITEM_CD
                            )AS VAL
                       FROM(--1)브랜드/상품별 주문수량 합계를 구함
                           SELECT M1.BRAND_CD                                       
                                 ,M1.ITEM_CD
                                 ,SUM(M1.ORDER_QTY) AS SUM_QTY
                             FROM A_OUT_D M1
                            GROUP BY M1.BRAND_CD, M1.ITEM_CD
                            ORDER BY M1.BRAND_CD, M1.ITEM_CD
                           ) L1
                     ) 
             ) 
        ORDER BY BOX_CNT DESC     
       )
  WHERE ROWNUM <=3
---------------------------------------------------------------------------------------      
     
      
SELECT ROWNUM AS RNK
      ,L1.*
      ,CEIL(ORDER_QTY/QTY_IN_BOX) AS BOX_CNT_TOT
  FROM (
        SELECT ITEM_CD
              ,QTY_IN_BOX
              ,ORDER_QTY
              ,TRUNC(ORDER_QTY/QTY_IN_BOX) AS BOX_CNT
              ,MOD(ORDER_QTY,QTY_IN_BOX)   AS PCS_CNT
          FROM (
                SELECT ITEM_CD
                      ,QTY_IN_BOX
                      ,SUM(ORDER_QTY) AS ORDER_QTY
                  FROM LO_OUT_D                    
                 WHERE INVOICE_NO BETWEEN '346724706262' AND '346724706762'
                 GROUP BY ITEM_CD, QTY_IN_BOX
                 ORDER BY ORDER_QTY DESC
               )  
         WHERE ROWNUM <=5  
       ) L1     
  
  
  
  