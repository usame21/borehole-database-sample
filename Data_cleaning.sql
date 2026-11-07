-- Cleaning steps run after importing from Excel / CSV
-- Lesson learned: imported text often carries trailing spaces, which breaks WHERE filters.

UPDATE wells
SET well_id        = TRIM(well_id),
    region         = TRIM(region),
    sub_district   = TRIM(sub_district),
    status         = TRIM(status),
    failure_reason = NULLIF(TRIM(failure_reason), ''),
    manager_name   = TRIM(manager_name),
    manager_phone  = TRIM(manager_phone);

-- Always check a filter before running an UPDATE on it:
-- SELECT * FROM wells WHERE status = 'Non-functional' AND region = 'Region A';
