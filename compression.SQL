
----------------------------데이터압축하기----------------------------------
   
--데이터압축하기1 PAGE4-1 
SELECT --+ORDERED USE_NL(M2)
       M1.OUTBOUND_DATE
      ,SUM(M2.ORDER_QTY)   AS SUM_QTY
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
 WHERE OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
 GROUP BY M1.OUTBOUND_DATE
 ORDER BY SUM_QTY DESC
 
                                               
 
 
--데이터압축하기1 PAGE5-1
SELECT --+ORDERED USE_NL(M2)
       TO_CHAR(M1.OUTBOUND_DATE,'DAY') AS DAY
      ,SUM(M2.ORDER_QTY)
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
 WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
 GROUP BY TO_CHAR(M1.OUTBOUND_DATE,'DAY')
         ,TO_CHAR(M1.OUTBOUND_DATE,'D')
 ORDER BY TO_CHAR(M1.OUTBOUND_DATE,'D')
 
 
SELECT --+ORDERED USE_NL(M2)
       SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'DAY') WHEN '일요일' THEN M2.ORDER_QTY END) AS SUN
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'DAY') WHEN '월요일' THEN M2.ORDER_QTY END) AS MON
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'DAY') WHEN '화요일' THEN M2.ORDER_QTY END) AS TUE
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'DAY') WHEN '수요일' THEN M2.ORDER_QTY END) AS WED
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'DAY') WHEN '목요일' THEN M2.ORDER_QTY END) AS THU
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'DAY') WHEN '금요일' THEN M2.ORDER_QTY END) AS FRI
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'DAY') WHEN '토요일' THEN M2.ORDER_QTY END) AS SAT
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO 
 WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
 
 
 
 
--데이터 압축하기1 PAGE6-1
SELECT --+ORDERED USE_NL(M2)
               SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '01' THEN M2.ORDER_QTY END) AS M01
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '02' THEN M2.ORDER_QTY END) AS M02
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '03' THEN M2.ORDER_QTY END) AS M03
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'Q')  WHEN '1'  THEN M2.ORDER_QTY END) AS Q01
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '04' THEN M2.ORDER_QTY END) AS M04  
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '05' THEN M2.ORDER_QTY END) AS M05
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '06' THEN M2.ORDER_QTY END) AS M06
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'Q')  WHEN '2'  THEN M2.ORDER_QTY END) AS Q02
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '07' THEN M2.ORDER_QTY END) AS M07
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '08' THEN M2.ORDER_QTY END) AS M08
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '09' THEN M2.ORDER_QTY END) AS M09
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'Q')  WHEN '3'  THEN M2.ORDER_QTY END) AS Q03
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '10' THEN M2.ORDER_QTY END) AS M10
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '11' THEN M2.ORDER_QTY END) AS M11
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'MM') WHEN '12' THEN M2.ORDER_QTY END) AS M12
              ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE,'Q')  WHEN '4'  THEN M2.ORDER_QTY END) AS Q04
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO 
 WHERE M1.OUTBOUND_DATE BETWEEN '2019-01-01' AND '2019-12-31'


 
 
--데이터 압축하기1 PAGE7-1 
SELECT CASE WHEN ROWNUM < 6 THEN ROWNUM  ELSE 0               END AS RNUM     
      ,CASE WHEN ROWNUM < 6 THEN ITEM_CD ELSE '99999'         END AS ITEM_CD
      ,CASE WHEN ROWNUM < 6 THEN ITEM_NM ELSE 'TOP5제외 합계' END AS ITEM_NM
      ,SUM(SUM_QTY)   AS ORDER_QTY
  FROM (
        SELECT --+ORDERED USE_NL(M2)
               M2.ITEM_CD
              ,M2.ITEM_NM
              ,SUM(M2.ORDER_QTY)    AS SUM_QTY
          FROM LO_OUT_M M1
               JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                               AND M2.ITEM_NM LIKE '%참치%'
         WHERE M1.OUTBOUND_DATE BETWEEN '2019-06-01' AND '2019-06-30'
         GROUP BY M2.ITEM_CD
                 ,M2.ITEM_NM
         ORDER BY SUM_QTY DESC  
       )
 GROUP BY CASE WHEN ROWNUM < 6 THEN ROWNUM  ELSE 0               END     
         ,CASE WHEN ROWNUM < 6 THEN ITEM_CD ELSE '99999'         END
         ,CASE WHEN ROWNUM < 6 THEN ITEM_NM ELSE 'TOP5제외 합계' END
 ORDER BY CASE WHEN RNUM BETWEEN 1 AND 5 THEN 1
                                         ELSE 2 END
         ,RNUM


  
  
--데이터압축하기2 PAGE3-1   
SELECT L2.DAYY
      ,TO_DATE(SUBSTR(DATE_QTY,11,8),'YYYY-MM-DD')                                              AS OUTBOUND_DATE
      ,TO_NUMBER(SUBSTR(DATE_QTY,1,10))                                                         AS ORDER_QTY
  FROM (
        SELECT SUBSTR(TO_CHAR(L1.OUTBOUND_DATE,'DAY'),1,1)                                      AS DAYY
              ,MAX( LPAD(L1.SUM_QTY,10,0) || LPAD(TO_CHAR(L1.OUTBOUND_DATE,'YYYYMMDD'),8,0) )   AS DATE_QTY                
          FROM (
                SELECT --+ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
                       M1.OUTBOUND_DATE
                      ,SUM(M2.ORDER_QTY)                                                        AS SUM_QTY
                  FROM LO_OUT_M M1
                       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                 WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
                 GROUP BY M1.OUTBOUND_DATE  
               ) L1
         GROUP BY SUBSTR(TO_CHAR(L1.OUTBOUND_DATE,'DAY'),1,1) 
                 ,TO_CHAR(L1.OUTBOUND_DATE,'D')
         ORDER BY TO_CHAR(L1.OUTBOUND_DATE,'D')  
       ) L2  
       
       
       
       
--데이터압축하기2 PAGE4-1
SELECT MAX(SUM_QTY)             AS MAX_QTY
      ,MIN(SUM_QTY)             AS MIN_QTY
      ,TRUNC(AVG(SUM_QTY))      AS AVG_QTY
  FROM (
        SELECT --+ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
               M1.OUTBOUND_DATE           AS OUT_DATE
              ,SUM(M2.ORDER_QTY)          AS SUM_QTY
          FROM LO_OUT_M M1
               JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
         WHERE OUTBOUND_DATE IN (
                                 SELECT *
                                   FROM (
                                         SELECT NO, TO_DATE('2019-09-03','YYYY-MM-DD') + NO - 1    AS STD_DATE
                                           FROM CS_NO
                                          WHERE NO <= 10  
                                        ) M1
                                  WHERE EXISTS (
                                                 SELECT 1
                                                   FROM LO_OUT_M S1
                                                  WHERE S1.OUTBOUND_DATE = M1.STD_DATE
                                               )
                                   AND ROWNUM <=7  
                                 )      
         GROUP BY OUTBOUND_DATE       
       ) L1
       



--데이터압축하기2 PAGE5-1
SELECT L1.ITEM_CD
      ,TO_DATE(SUBSTR(MAX(L1.BATCH_DATE),4,11),'YYYY-MM-DD')                                                                           AS MAX_DATE
      ,CASE SUBSTR(MAX(L1.BATCH_DATE),1,3) WHEN 'zzz' THEN '001' ELSE SUBSTR(MAX(L1.BATCH_DATE),1,3) END                               AS MAX_BATCH
  FROM (
        SELECT --+ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
               M2.ITEM_CD                                                                                                              AS ITEM_CD
              ,MAX(CASE M1.OUTBOUND_BATCH WHEN '001' THEN 'zzz' ELSE M1.OUTBOUND_BATCH END) || TO_CHAR(M1.OUTBOUND_DATE,'YYYYMMDD')    AS BATCH_DATE
          FROM LO_OUT_M M1
               JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                               AND M2.ITEM_CD IN ('30500','73510')
         WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-19'
         GROUP BY M2.ITEM_CD
                 ,M1.OUTBOUND_DATE 
       ) L1
 GROUP BY L1.ITEM_CD
          



--데이터압축하기2 PAGE6-1


SELECT L1.*
      ,CASE WHEN L1.ORDER_QTY >= 900000 THEN 'A'
            WHEN L1.ORDER_QTY >= 800000 THEN 'B'
            WHEN L1.ORDER_QTY >= 700000 THEN 'C'
            WHEN L1.ORDER_QTY >= 600000 THEN 'D'
                                        ELSE 'F' END   AS GRADE
  FROM (
        SELECT --+ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
               TO_CHAR(M1.OUTBOUND_DATE,'IW')          AS WEEK_OF_YEAR
              ,SUM(ORDER_QTY)                          AS ORDER_QTY
          FROM LO_OUT_M M1
               JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO 
         WHERE TO_CHAR(M1.OUTBOUND_DATE,'YYYY') = '2019'
         GROUP BY TO_CHAR(M1.OUTBOUND_DATE,'IW')
         ORDER BY TO_CHAR(M1.OUTBOUND_DATE,'IW')  
       ) L1


