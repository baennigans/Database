----------------------------내장함수 일반----------------------------------      
     
--PDF         
SELECT NVL(NULL,'SKPANG') FROM DUAL WHERE 1=1

SELECT NVL(NULL,'SKPANG') FROM DUAL WHERE 1=2           
 
SELECT NVL(MAX(NULL), 'HELLO') AS VAL
  FROM DUAL
 WHERE 1=2 
 
SELECT NVL(MIN('Y'),'N') AS EXIST_YN
  FROM LO_OUT_M    
 WHERE OUTBOUND_DATE = '2015-06-03'
   AND ROWNUM = 10
   
 
 
 
--내장함수일반 PAGE17-1,2 
SELECT OUTBOUND_DATE
      ,TO_CHAR(OUTBOUND_DATE , 'day')             AS DY
      ,INVOICE_NO
      ,TO_NUMBER(SUBSTR(INVOICE_NO,2,2))          AS AAA
      ,MOD(SUBSTR(INVOICE_NO,2,2),2)              AS BBB
      ,MOD(TO_NUMBER(SUBSTR(INVOICE_NO,2,2)),2)   AS CCC
      ,CASE MOD(TO_NUMBER(SUBSTR(INVOICE_NO,2,2)),2)
       WHEN 0 THEN '짝'
       ELSE '홀' END                              AS EVENODD
      ,ORDER_NM
  FROM A_OUT_M
 WHERE BRAND_CD = '1001'
 ORDER BY TO_CHAR(OUTBOUND_DATE, 'D')
 
 
 
 
--내장함수일반 PAGE18-1 
SELECT BRAND_CD
      ,COUNT(INVOICE_NO) AS INV_CNT
  FROM A_OUT_M
 GROUP BY BRAND_CD
 ORDER BY BRAND_CD
 
 
 
 
--내장함수일반 PAGE18-2
SELECT BRAND_CD
      ,TO_CHAR(OUTBOUND_DATE , 'DAY')  AS DAY
      ,COUNT(INVOICE_NO)
  FROM A_OUT_M
 GROUP BY BRAND_CD, TO_CHAR(OUTBOUND_DATE , 'DAY')
 ORDER BY BRAND_CD, TO_CHAR(OUTBOUND_DATE , 'DAY') DESC;

 
 
 
--내장함수일반 PAGE18-3 
SELECT BRAND_CD
      ,CASE MOD(TO_NUMBER(SUBSTR(INVOICE_NO,2,2)),2) WHEN 0 THEN '짝'
                                                            ELSE '홀'  
                                                      END  AS MOD_INV                                                     
      ,SUM(ORDER_QTY)
  FROM A_OUT_D
 GROUP BY BRAND_CD
         ,CASE MOD(TO_NUMBER(SUBSTR(INVOICE_NO,2,2)),2) WHEN 0 THEN '짝'
                                                               ELSE '홀'  
                                                         END
 ORDER BY BRAND_CD


 
 
--내장함수일반 PAGE19-1 
SELECT INVOICE_NO
      ,OUTBOUND_DATE
      ,TO_CHAR(OUTBOUND_DATE,'DAY') AS DAY
      ,OUTBOUND_NO
  FROM LO_OUT_M
 WHERE INVOICE_NO IN ('346724706214' , '346724793596' , '346724869970')
 ORDER BY OUTBOUND_DATE;
 
 

 
--내장함수일반 PAGE20-1
SELECT DISTINCT NVL(NULL,'Empty..') AS ORDER_QTY
  FROM (
       SELECT ORDER_QTY, INVOICE_NO
         FROM LO_OUT_D
       ) 
 WHERE INVOICE_NO = '346724706215'   --'346724706215'
 
 
 

----------------------------내장함수CASE----------------------------------
 
--PDF
SELECT DISTINCT OUTBOUND_DATE 
      ,TO_CHAR(OUTBOUND_DATE,'MM') AS MM
      ,SET_QTY
      ,CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '06' THEN SET_QTY END AS M06
      ,CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '07' THEN SET_QTY END AS M07
      ,CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '08' THEN SET_QTY END AS M08
      ,CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '09' THEN SET_QTY END AS M09
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-01-01' AND '2019-12-31' 
 ORDER BY OUTBOUND_DATE
 
 
 
 
--내장함수CASE PAGE8-1 
SELECT OUTBOUND_DATE
      ,TO_CHAR(OUTBOUND_DATE, 'DAY') AS DAY
      ,INVOICE_NO
      ,CASE MOD(TO_NUMBER(SUBSTR(INVOICE_NO,2,2)),2)
            WHEN 0 THEN '짝'
                   ELSE '홀' END AS MOD
      ,ORDER_NM
      ,CASE TO_CHAR(SUBSTR(OUT_TYPE_DIV,1,2))
            WHEN 'M1' THEN '상온'
            WHEN 'M2' THEN '저온' END AS TEMP
  FROM A_OUT_M 
 
 
 
 
--내장함수CASE PAGE8-2
SELECT BRAND_CD
      ,INVOICE_NO
      ,LINE_NO
      ,ITEM_CD
      ,ORDER_QTY
      ,CASE WHEN ORDER_QTY BETWEEN 1 AND 2 THEN '하'
            WHEN ORDER_QTY BETWEEN 3 AND 4 THEN '중'
            WHEN ORDER_QTY >= 5            THEN '상'
            END AS GRADE 
  FROM A_OUT_D 
 
 
 
 
--내장함수CASE PAGE9-1
SELECT BRAND_CD
      ,CASE TO_CHAR(SUBSTR(OUT_TYPE_DIV,1,2))
            WHEN 'M1' THEN '상온'
            WHEN 'M2' THEN '저온' END AS TEMP
      ,COUNT(INVOICE_NO)
  FROM A_OUT_M
 GROUP BY BRAND_CD
         ,CASE TO_CHAR(SUBSTR(OUT_TYPE_DIV,1,2))
               WHEN 'M1' THEN '상온'
               WHEN 'M2' THEN '저온' END
 
 
 
 
--내장함수CASE PAGE9-2
SELECT BRAND_CD
      ,CASE WHEN ORDER_QTY BETWEEN 1 AND 2 THEN '하'
            WHEN ORDER_QTY BETWEEN 3 AND 4 THEN '중'
            WHEN ORDER_QTY >= 5            THEN '상'
            END AS GRADE 
      ,COUNT(INVOICE_NO) AS CNT_INV_NO
  FROM (
       SELECT BRAND_CD
             ,INVOICE_NO
             ,SUM(ORDER_QTY) AS ORDER_QTY
         FROM A_OUT_D 
        GROUP BY BRAND_CD, INVOICE_NO
       )
 GROUP BY BRAND_CD
         ,CASE WHEN ORDER_QTY BETWEEN 1 AND 2 THEN '하'
               WHEN ORDER_QTY BETWEEN 3 AND 4 THEN '중'
               WHEN ORDER_QTY >= 5            THEN '상'
                END
 
 
 
 
--내장함수CASE PAGE9-3
SELECT CASE WHEN ROWNUM <=2 THEN ROWNUM
                            ELSE 0
            END AS RNK
      ,CASE WHEN ROWNUM <=2 THEN ITEM_CD
                            ELSE 'ETC' 
            END AS ITEM
      ,SUM(SUM_QTY)
  FROM (
        SELECT ITEM_CD
              ,SUM(ORDER_QTY) AS SUM_QTY
          FROM A_OUT_D
         GROUP BY ITEM_CD
         ORDER BY SUM_QTY DESC 
       ) 
 GROUP BY CASE WHEN ROWNUM <=2 THEN ROWNUM
                            ELSE 0
            END 
      ,CASE WHEN ROWNUM <=2 THEN ITEM_CD
                            ELSE 'ETC' 
            END 
 ORDER BY CASE WHEN RNK IN (1,2) THEN 1 ELSE 2 END
          ,RNK
 
 
 

--내장함수CASE PAGE10-1
SELECT BRAND_CD
      ,INVOICE_NO
      ,LINE_NO
      ,ITEM_CD
      ,ORDER_QTY
      ,CASE WHEN ORDER_QTY BETWEEN 1 AND 2 THEN '하'
            WHEN ORDER_QTY BETWEEN 3 AND 4 THEN '중'
            WHEN ORDER_QTY >= 5            THEN '상'
            END AS GRADE
  FROM A_OUT_D
 WHERE BRAND_CD = '1001'
 ORDER BY CASE WHEN ITEM_CD = 'C' THEN 1
                                  ELSE 2 END
          ,ITEM_CD
          ,ORDER_QTY DESC
 



--내장함수CASE PAGE11-1
SELECT OUTBOUND_DATE 
      ,COUNT(INVOICE_NO)                                      AS INVOICE_CNT
      ,COUNT(CASE WHEN OUT_TYPE_DIV LIKE 'M1%' THEN 1 END)    AS M1_CNT
      ,COUNT(CASE WHEN OUT_TYPE_DIV LIKE 'M2%' THEN 2 END)    AS M2_CNT
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-19'
   AND OUT_BOX_DIV LIKE CASE :COND WHEN 1 THEN 'D'
                                   WHEN 2 THEN 'F'
                                   WHEN 0 THEN NULL
                                   ELSE 'ZZZ'
                         END || '%'
 GROUP BY OUTBOUND_DATE 
 ORDER BY OUTBOUND_DATE
 
 

 
--내장함수CASE PAGE12-1
SELECT ITEM_BAR_CD
      ,COUNT(DISTINCT ITEM_CD)  AS ITEM_CNT
  FROM LO_OUT_D
 GROUP BY ITEM_BAR_CD
HAVING COUNT(DISTINCT ITEM_CD) > 1 
 ORDER BY CASE WHEN ITEM_BAR_CD IS NULL THEN 1
                                        ELSE 0
               END        
         ,ITEM_CNT DESC




--내장함수CASE PAGE13-1
SELECT SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '01' THEN SET_QTY END) AS M01
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '02' THEN SET_QTY END) AS M02
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '03' THEN SET_QTY END) AS M03
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '04' THEN SET_QTY END) AS M04
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '05' THEN SET_QTY END) AS M05
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '06' THEN SET_QTY END) AS M06
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '07' THEN SET_QTY END) AS M07
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '08' THEN SET_QTY END) AS M08
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '09' THEN SET_QTY END) AS M09
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '10' THEN SET_QTY END) AS M10
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '11' THEN SET_QTY END) AS M11
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '12' THEN SET_QTY END) AS M12
  FROM LO_OUT_M
 WHERE TO_CHAR(OUTBOUND_DATE,'YYYY') = '2019'





--내장함수CASE PAGE14-1
SELECT OUTBOUND_DATE
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '01' THEN SET_QTY END) AS M01
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '02' THEN SET_QTY END) AS M02
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '03' THEN SET_QTY END) AS M03
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '04' THEN SET_QTY END) AS M04
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '05' THEN SET_QTY END) AS M05
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '06' THEN SET_QTY END) AS M06
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '07' THEN SET_QTY END) AS M07
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '08' THEN SET_QTY END) AS M08
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '09' THEN SET_QTY END) AS M09
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '10' THEN SET_QTY END) AS M10
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '11' THEN SET_QTY END) AS M11
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '12' THEN SET_QTY END) AS M12
  FROM LO_OUT_M
 WHERE TO_CHAR(OUTBOUND_DATE,'YYYY') = '2019'
 GROUP BY OUTBOUND_DATE
 ORDER BY OUTBOUND_DATE




--내장함수CASE PAGE15-1
SELECT TO_CHAR(OUTBOUND_DATE,'YYYY')                                    AS YYYY
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '01' THEN SET_QTY END) AS M01
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '02' THEN SET_QTY END) AS M02
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '03' THEN SET_QTY END) AS M03
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '04' THEN SET_QTY END) AS M04
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '05' THEN SET_QTY END) AS M05
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '06' THEN SET_QTY END) AS M06
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '07' THEN SET_QTY END) AS M07
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '08' THEN SET_QTY END) AS M08
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '09' THEN SET_QTY END) AS M09
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '10' THEN SET_QTY END) AS M10
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '11' THEN SET_QTY END) AS M11
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE,'MM') WHEN '12' THEN SET_QTY END) AS M12
  FROM LO_OUT_M
 GROUP BY TO_CHAR(OUTBOUND_DATE,'YYYY')
 ORDER BY TO_CHAR(OUTBOUND_DATE,'YYYY')




--내장함수CASE PAGE16-1
SELECT INVOICE_NO
      ,LINE_NO
      ,ITEM_CD
      ,ITEM_NM
      ,ORDER_QTY
  FROM LO_OUT_D
 WHERE INVOICE_NO = '346724706214'
 ORDER BY CASE :SORT_TYPE WHEN 1 THEN LINE_NO
                          WHEN 2 THEN ORDER_QTY
                           END
        ,LINE_NO



--내장함수CASE PAGE16-1 응용 
SELECT INVOICE_NO
      ,LINE_NO
      ,ITEM_CD                    
      ,ITEM_NM
      ,ORDER_QTY
  FROM LO_OUT_D
 WHERE INVOICE_NO = '346724706214'
 ORDER BY ORDER_QTY * DECODE(:SORT_TYPE ,1 ,1, -1)

 