WITH RECURSIVE data1 AS (
  SELECT company, LEFT(fiscal_year::TEXT,4)::INT AS year FROM dividend
), data2 AS (
  SELECT data1.company, data1.year, 1 AS datas 
   FROM data1
  UNION DISTINCT
  SELECT data1.company, data1.year, data2.datas + 1 
   FROM data1
   JOIN data2
     ON data1.company = data2.company
    AND data1.year = data2.year + 1
)
SELECT row_to_json(row(json_agg(company))) as valuestocks FROM data2
WHERE datas = 3;