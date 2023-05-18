----------------------------조인 기본----------------------------------

--PDF
SELECT M1.INVOICE_NO
      ,M1.OUTBOUND_DATE
      ,M1.OUT_TYPE_DIV
      ,M2.LINE_NO
      ,M2.ITEM_CD
      ,M2.ORDER_QTY
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
 WHERE M1.INVOICE_NO IN ('346724703834', '346724722535', '346724717915')

 
 
 
--조인기본 PAGE13-1
SELECT M1.BRAND_CD
      ,M1.OUTBOUND_DATE
      ,M1.INVOICE_NO
      ,M2.LINE_NO
      ,M2.ORDER_QTY
  FROM A_OUT_M M1
       JOIN A_OUT_D M2 ON M1.INVOICE_NO = M2.INVOICE_NO
                      AND M1.BRAND_CD = M2.BRAND_CD
                      AND M2.ITEM_CD IN ('B','D')
 WHERE M1.OUTBOUND_DATE = '2023-01-04'
   
 
 
 
--조인기본 PAGE13-2
SELECT M1.BRAND_CD
      ,M2.OUTBOUND_DATE
      ,M1.ITEM_CD
      ,SUM(ORDER_QTY)    AS SUM_QTY
  FROM A_OUT_D M1
       JOIN A_OUT_M M2 ON M1.INVOICE_NO = M2.INVOICE_NO
                      AND M1.BRAND_CD = M2.BRAND_CD 
 WHERE M2.OUTBOUND_DATE BETWEEN '2023-01-03' AND '2023-01-04'
   AND M1.ITEM_CD IN('B','D')
 GROUP BY M1.BRAND_CD
         ,M2.OUTBOUND_DATE
         ,M1.ITEM_CD
 ORDER BY M1.BRAND_CD
         ,M2.OUTBOUND_DATE
         
         
         
SELECT M1.BRAND_CD
      ,M1.OUTBOUND_DATE
      ,M2.ITEM_CD
      ,SUM(M2.ORDER_QTY)  AS SUM_QTY
  FROM A_OUT_M M1
       JOIN A_OUT_D M2 ON M2.BRAND_CD = M1.BRAND_CD
                      AND M2.INVOICE_NO = M1.INVOICE_NO 
                      AND ITEM_CD IN ('B','D')
 WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-03' AND '2023-01-04'       
 GROUP BY M1.BRAND_CD
         ,M1.OUTBOUND_DATE
         ,M2.ITEM_CD
 ORDER BY M1.BRAND_CD
         ,M1.OUTBOUND_DATE        
         
         
         
        
--조인기본 PAGE13-3 
SELECT *
  FROM (
        SELECT M1.INVOICE_NO
              ,M1.ORDER_NM
              ,SUM(M2.ORDER_QTY)    AS SUM_QTY
          FROM A_OUT_M M1
               JOIN A_OUT_D M2 ON M1.BRAND_CD = M2.BRAND_CD
                              AND M1.INVOICE_NO = M2.INVOICE_NO
         WHERE M1.BRAND_CD = '1001'
           AND M1.OUTBOUND_DATE BETWEEN '2023-01-04' AND '2023-01-05'        
         GROUP BY M1.INVOICE_NO
                 ,M1.ORDER_NM
         ORDER BY SUM_QTY DESC
       )  
 WHERE ROWNUM = 1 
 
 
 
 
--조인기본 PAGE14-1
SELECT M1.BRAND_CD
      ,M1.OUTBOUND_DATE
      ,M1.INVOICE_NO
      ,M2.ITEM_CD
      ,M3.ITEM_NM
      ,M2.ORDER_QTY
  FROM A_OUT_M M1
       JOIN A_OUT_D M2 ON M2.BRAND_CD   = M1.BRAND_CD
                      AND M2.INVOICE_NO = M1.INVOICE_NO
                      AND M2.ORDER_QTY >= 3
       JOIN A_ITEM  M3 ON M3.BRAND_CD   = M1.BRAND_CD
                      AND M3.ITEM_CD    = M2.ITEM_CD
 WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'




--조인기본 PAGE14-2
SELECT M1.BRAND_CD
      ,M2.ITEM_CD
      ,SUM(M2.ORDER_QTY)   AS SUM_QTY
      ,M3.ITEM_NM
      ,M3.QTY_IN_BOX
  FROM A_OUT_M M1
       JOIN A_OUT_D M2 ON M2.BRAND_CD   = M1.BRAND_CD
                      AND M2.INVOICE_NO = M1.INVOICE_NO
       JOIN A_ITEM M3  ON M3.BRAND_CD   = M1.BRAND_CD
                      AND M3.ITEM_CD    = M2.ITEM_CD
 WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
 GROUP BY M1.BRAND_CD
         ,M2.ITEM_CD
         ,M3.ITEM_NM
         ,M3.QTY_IN_BOX
 ORDER BY BRAND_CD
         ,M2.ITEM_CD
         
         
         
SELECT M1.BRAND_CD
      ,M1.ITEM_CD
      ,M3.ITEM_NM
      ,M3.QTY_IN_BOX
      ,M1.SUM_QTY
  FROM (
        SELECT M1.BRAND_CD
              ,M2.ITEM_CD
              ,SUM(M2.ORDER_QTY)   AS SUM_QTY         
          FROM A_OUT_M M1
               JOIN A_OUT_D M2 ON M2.BRAND_CD = M1.BRAND_CD
                              AND M2.INVOICE_NO = M1.INVOICE_NO      
         WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
         GROUP BY M1.BRAND_CD
                  ,M2.ITEM_CD
       ) M1
       JOIN A_ITEM M3  ON M3.BRAND_CD = M1.BRAND_CD
                      AND M3.ITEM_CD  = M1.ITEM_CD
 ORDER BY M1.BRAND_CD, M1.ITEM_CD
 
 
 
 
--조인기본 PAGE14-3,4
SELECT L2.*
  FROM (
        SELECT L1.*
              ,TRUNC(SUM_QTY/QTY_IN_BOX)   AS BOX_CNT
              ,MOD(SUM_QTY,QTY_IN_BOX)     AS PCS_CNT
          FROM (
                SELECT M1.BRAND_CD
                      ,M1.ITEM_CD
                      ,M3.ITEM_NM
                      ,M3.QTY_IN_BOX
                      ,M1.SUM_QTY
                  FROM (
                        SELECT M1.BRAND_CD
                              ,M2.ITEM_CD
                              ,SUM(M2.ORDER_QTY)   AS SUM_QTY         
                          FROM A_OUT_M M1
                               JOIN A_OUT_D M2 ON M2.BRAND_CD = M1.BRAND_CD
                                              AND M2.INVOICE_NO = M1.INVOICE_NO      
                         WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
                         GROUP BY M1.BRAND_CD
                                  ,M2.ITEM_CD
                       ) M1
                       JOIN A_ITEM M3  ON M3.BRAND_CD = M1.BRAND_CD
                                      AND M3.ITEM_CD  = M1.ITEM_CD
                 ORDER BY M1.BRAND_CD, M1.ITEM_CD
               ) L1
          ORDER BY BOX_CNT DESC     
       ) L2
 WHERE ROWNUM <=3
 
 
 
 
--PDF
SELECT LEVEL + TO_DATE('2023-04-07','YYYY-MM-DD') AS DY
  FROM DUAL
CONNECT BY LEVEL <=10



SELECT CASE NO WHEN 1 THEN INVOICE_NO ELSE '합계' END AS INVOICE_NO
      ,CASE NO WHEN 1 THEN LINE_NO    ELSE 0      END AS LINE_NO 
      ,CASE NO WHEN 1 THEN ITEM_CD    ELSE '-'    END AS ITEM_CD
      ,SUM(ORDER_QTY)                                 AS SUM_QTY
      ,NO
  FROM LO_OUT_D M1
       JOIN CS_NO C1 ON C1.NO <= 2
 WHERE INVOICE_NO = '346724706214'
 GROUP BY CASE NO WHEN 1 THEN INVOICE_NO ELSE '합계' END 
         ,CASE NO WHEN 1 THEN LINE_NO    ELSE 0      END
         ,CASE NO WHEN 1 THEN ITEM_CD    ELSE '-'    END
         ,NO
 ORDER BY NO
 
 
 
SELECT INVOICE_NO
      ,LINE_NO
      ,ITEM_CD
      ,ORDER_QTY
      ,NO
  FROM LO_OUT_D M1
       JOIN CS_NO C1 ON C1.NO <= 3
 WHERE INVOICE_NO = '346724706214'
 
 

SELECT INVOICE_NO, LINE_NO, ITEM_CD, ORDER_QTY, NO
  FROM LO_OUT_D M1
       JOIN CS_NO C1 ON C1.NO <= M1.ORDER_QTY
 WHERE INVOICE_NO = '346724706214'
 ORDER BY LINE_NO, NO


 
 
--조인기본 PAGE16-1
SELECT M1.INVOICE_NO
      ,M1.OUTBOUND_DATE
      ,M1.OUT_TYPE_DIV
      ,M1.LINE_NO
      ,M1.ITEM_CD
      ,M2.ITEM_NM
      ,M1.ORDER_QTY
  FROM (
        SELECT M1.INVOICE_NO
              ,M1.OUTBOUND_DATE
              ,M1.OUT_TYPE_DIV
              ,M2.LINE_NO
              ,M2.ITEM_CD
              ,M2.ORDER_QTY
          FROM LO_OUT_M M1
               JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
         WHERE M1.INVOICE_NO IN ('346724703834','346724722535','346724717915')  
       ) M1
       JOIN CM_ITEM M2 ON M2.ITEM_CD = M1.ITEM_CD
 ORDER BY INVOICE_NO
         ,LINE_NO
       
       
       

--조인기본 PAGE17-1
SELECT L2.INVOICE_NO
      ,L2.OUTBOUND_DATE
      ,L2.OUT_TYPE_DIV
      ,L2.ITEM_CD
      ,L2.ITEM_NM
      ,L2.ORDER_QTY
      ,L2.CODE_NM       AS TEMP_NM
      ,M5.CODE_NM       AS OUT_TYPE_NM
  FROM (
        SELECT L1.*
              ,M4.CODE_NM
          FROM (
                SELECT M1.*
                      ,M2.ITEM_CD
                      ,M3.ITEM_NM
                      ,M2.ORDER_QTY
                  FROM LO_OUT_M M1
                       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                       JOIN CM_ITEM  M3 ON M3.ITEM_CD    = M2.ITEM_CD
                 WHERE M1.INVOICE_NO IN ('346724703834','346724722535','346724717915')
               ) L1
               JOIN CS_CODE M4 ON M4.CODE_CD = L1.TEMP_DIV
                              AND CODE_GRP = 'LDIV01'       
       ) L2
       JOIN CS_CODE M5 ON M5.CODE_CD = L2.OUT_TYPE_DIV
                      AND CODE_GRP = 'LDIV03'
                      
                      


----------------------------조인활용1,2----------------------------------
                      
--조인활용 PAGE3-1
SELECT *
  FROM (
        SELECT --+ORDERED USE_NL(M2)
               M1.INVOICE_NO
              ,M1.OUTBOUND_NO
              ,M1.OUTBOUND_BATCH
              ,M2.ITEM_CD
              ,M2.ITEM_NM
              ,M2.ORDER_QTY
          FROM LO_OUT_M M1
               JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                               AND M2.ITEM_NM LIKE '%골뱅이%'
         WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-03' AND '2019-09-10'
         ORDER BY M2.ORDER_QTY DESC
       )
 WHERE ROWNUM <= 5




--조인활용 PAGE4-1  
SELECT M2.ITEM_CD
      ,M3.ITEM_NM
      ,SUM(M2.ORDER_QTY)
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
       JOIN CM_ITEM M3  ON M3.ITEM_CD = M2.ITEM_CD
 WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-03' AND '2019-09-10'
   AND M1.OUT_BOX_DIV = 'D5'
 GROUP BY M2.ITEM_CD
         ,M3.ITEM_NM
 ORDER BY SUM(M2.ORDER_QTY) DESC
 
 
 
 
--조인활용 PAGE5-1
SELECT M1.INVOICE_NO
      ,M1.OUTBOUND_DATE
      ,M1.OUT_TYPE_DIV
      ,M2.LINE_NO
      ,M2.ITEM_CD
      ,M3.ITEM_NM
      ,M2.ORDER_QTY
      ,NVL(M4.CODE_NM ,'Failed..')
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
       JOIN CM_ITEM  M3 ON M3.ITEM_CD = M2.ITEM_CD
  LEFT JOIN CS_CODE  M4 ON M4.CODE_CD = M1.TEMP_DIV
                       AND M4.CODE_GRP = 'LDIV011'
 WHERE M1.INVOICE_NO IN ('346724703834','346724722535','346724717915')  

  


--조인활용 PAGE6-1
SELECT M1.OUTBOUND_DATE
      ,NVL(M2.SUM_QTY , 0)  AS SUM_QTY
  FROM (
        SELECT TO_DATE('2019-09-01','YYYY-MM-DD') + NO-1  AS OUTBOUND_DATE
          FROM CS_NO
         WHERE NO <= :OUT_DATE2 - :OUT_DATE1 +1
       ) M1
  LEFT JOIN ( --+ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
             SELECT M1.OUTBOUND_DATE
                   ,SUM(M2.ORDER_QTY)   AS SUM_QTY
               FROM LO_OUT_M M1
                    JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
              WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-19'
              GROUP BY M1.OUTBOUND_DATE
            ) M2
            ON M2.OUTBOUND_DATE = M1.OUTBOUND_DATE
 ORDER BY M1.OUTBOUND_DATE
 
 
 
 
--조인활용2 PAGE3-1 
SELECT INVOICE_NO
      ,LINE_NO
      ,ITEM_CD
      ,ITEM_NM
      ,ORDER_QTY
      ,SUM(ORDER_QTY) OVER(PARTITION BY INVOICE_NO ORDER BY LINE_NO)
  FROM LO_OUT_D
 WHERE INVOICE_NO IN ('346724703845','346724706214') 
 
 
 
 
----------------------------중간점검---------------------------------- 
 
--점검 PAGE3-1
SELECT OUTBOUND_DATE
      ,INVOICE_NO
      ,WORK_SEQ
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-06-03' AND '2019-06-04'
   AND SET_TYPE_CD = '000581225'
   AND SET_QTY = '3'
 ORDER BY WORK_SEQ * CASE :SORT_TYPE WHEN 1 THEN 1
                                     WHEN 2 THEN -1
                                     END
         ,INVOICE_NO
         
         


--점검 PAGE4-1
SELECT INVOICE_NO
      ,LINE_NO
      ,ITEM_NM
  FROM LO_OUT_D
 WHERE INVOICE_NO = '346724704405'
 ORDER BY CASE :SORT_TYPE WHEN 1 THEN ITEM_NM END ASC
         ,CASE :SORT_TYPE WHEN 2 THEN ITEM_NM END DESC
                           
 
 