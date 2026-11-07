-- Reporting queries (sample data)

-- 1. Wells by status
SELECT status, COUNT(*) AS wells
FROM wells
GROUP BY status
ORDER BY wells DESC;

-- 2. Region summary: totals by status (SUM of flags, not COUNT(*) of mixed rows)
SELECT region,
       COUNT(*)                                                   AS total_wells,
       SUM(CASE WHEN status = 'Functional' THEN 1 ELSE 0 END)           AS functional,
       SUM(CASE WHEN status = 'Partially functional' THEN 1 ELSE 0 END) AS partial,
       SUM(CASE WHEN status = 'Non-functional' THEN 1 ELSE 0 END)       AS non_functional
FROM wells
GROUP BY region
ORDER BY region;

-- 3. Failure rate by region (non-functional as a share of all wells)
SELECT region,
       ROUND(100.0 * SUM(CASE WHEN status = 'Non-functional' THEN 1 ELSE 0 END) / COUNT(*), 1) AS failure_pct
FROM wells
GROUP BY region
ORDER BY failure_pct DESC;

-- 4. Sub-district failure rate (same logic as the Power BI measure)
SELECT region, sub_district,
       COUNT(*) AS total_wells,
       ROUND(100.0 * SUM(CASE WHEN status = 'Non-functional' THEN 1 ELSE 0 END) / COUNT(*), 1) AS failure_pct
FROM wells
GROUP BY region, sub_district
ORDER BY failure_pct DESC;

-- 5. Failure reasons
SELECT failure_reason, COUNT(*) AS wells
FROM wells
WHERE failure_reason IS NOT NULL
GROUP BY failure_reason
ORDER BY wells DESC;

-- 6. Data quality checks (each should return zero rows)
-- 6a. Duplicate well IDs (also blocked by the primary key)
SELECT well_id, COUNT(*) AS n FROM wells GROUP BY well_id HAVING COUNT(*) > 1;
-- 6b. Missing manager phone
SELECT well_id FROM wells WHERE manager_phone IS NULL OR manager_phone = '';
-- 6c. Leftover trailing or leading spaces
SELECT well_id FROM wells WHERE sub_district <> TRIM(sub_district) OR region <> TRIM(region);
-- 6d. Non-functional or partial wells with no failure reason
SELECT well_id FROM wells WHERE status <> 'Functional' AND failure_reason IS NULL;

-- 7. Totals with a grand total row 
SELECT COALESCE(region, 'ALL REGIONS') AS region, COUNT(*) AS total_wells
FROM wells
GROUP BY region WITH ROLLUP;
