---------------------------------------------------------------------------- 
---------------------------------------------------------------------------- 
-------------------------------중간고사-------------------------------------
---------------------------------------------------------------------------- 
---------------------------------------------------------------------------- 
--문제1

SELECT TO_CHAR(OUTBOUND_DATE,'YYYY-MM')   AS OUT_DATE
      ,COUNT(INVOICE_NO)                  AS INV_CNT  
      ,SUM(SET_QTY)                       AS SET_QTY
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-06-01' AND '2019-08-31'
 GROUP BY TO_CHAR(OUTBOUND_DATE,'YYYY-MM')
 ORDER BY TO_CHAR(OUTBOUND_DATE,'YYYY-MM')
 
 
 
 
--문제2

SELECT M1.OUT_TYPE_DIV      
      ,SUM(M2.ORDER_QTY)   AS SUM_QTY
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
 WHERE OUTBOUND_DATE = '2019-09-03'
 GROUP BY M1.OUT_TYPE_DIV
HAVING SUM(M2.ORDER_QTY) >= 5000
 ORDER BY CASE WHEN OUT_TYPE_DIV LIKE 'M1%' THEN 1
               WHEN OUT_TYPE_DIV LIKE 'M2%' THEN 2 END
         ,SUM_QTY * CASE WHEN OUT_TYPE_DIV LIKE 'M1%' THEN  1
                         WHEN OUT_TYPE_DIV LIKE 'M2%' THEN -1 END
         
         

                                 
--문제3                    
 
SELECT CASE WHEN ROWNUM < 11 THEN TO_CHAR(L1.OUTBOUND_DATE) ELSE 'ETC' END AS OUT_DATE
      ,CASE WHEN ROWNUM < 11 THEN L1.ITEM_CD                ELSE NULL  END AS ITEM_CD
      ,CASE WHEN ROWNUM < 11 THEN L1.ITEM_NM                ELSE NULL  END AS ITEM_NM
      ,SUM(SUM_QTY)                                                        AS SUM_QTY
  FROM (
        SELECT  --+ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
               M1.OUTBOUND_DATE
              ,M2.ITEM_CD
              ,M2.ITEM_NM
              ,SUM(M2.ORDER_QTY)     AS SUM_QTY
          FROM LO_OUT_M M1
               JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                               AND M2.ITEM_NM LIKE '%참치%'
         WHERE OUTBOUND_DATE BETWEEN '2019-06-01' AND '2019-06-30'
         GROUP BY M1.OUTBOUND_DATE
                 ,M2.ITEM_CD
                 ,M2.ITEM_NM
         ORDER BY SUM_QTY DESC  
       ) L1
 GROUP BY CASE WHEN ROWNUM < 11 THEN TO_CHAR(L1.OUTBOUND_DATE) ELSE 'ETC' END
         ,CASE WHEN ROWNUM < 11 THEN L1.ITEM_CD                ELSE NULL  END
         ,CASE WHEN ROWNUM < 11 THEN L1.ITEM_NM                ELSE NULL  END
 ORDER BY CASE WHEN OUT_DATE='ETC' THEN 2 ELSE 1 END
         ,SUM_QTY DESC
 

  
--문제4

SELECT C1.NO+1 ||'단'                                            AS DANSU
      ,C1.NO+1 || ' x ' || C2.NO || ' = ' || (C1.NO+1)*C2.NO     AS CONTENTS
  FROM CS_NO C1
       JOIN CS_NO C2 ON C2.NO < 10
 WHERE C1.NO < 9 