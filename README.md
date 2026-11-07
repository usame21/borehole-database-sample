# Borehole Database (Sample Design)

A relational database design for tracking boreholes (wells), their status and failures, with the SQL and reporting approach used to keep the data clean and useful.

> **Practice project with sample data. Not an official ministry product.**
> Every well, place, manager and phone number in this repository is invented.

## The problem
Water departments often track wells on paper or in scattered spreadsheets. Totals drift, spellings differ, and a failure is reported as a phone call that nobody records. This project shows how I structure that data so it can be queried, checked and reported reliably.

## What is inside
| File | Purpose |
|---|---|
| `Schema.sql` | Table design with a primary key, indexes and rules that block bad data (valid status values, standard failure reasons) |
| `sample_data.csv` / `Sample_data.sql` | 37 invented wells across 3 regions, for testing |
| `Data_cleaning.sql` | Cleaning steps after importing from Excel, such as `TRIM()` on text columns |
| `Queries.sql` | Reports: wells by status, region summary, failure rate by region and sub-district, failure reasons, data quality checks |

## Tools
MySQL 8, SQL, Excel (import and checking)

## Practices shown
- Well IDs follow one format, so records join and sort predictably.
- Imported text is trimmed before filtering, because hidden trailing spaces break `WHERE` clauses.
- Totals use `SUM()` over flags, not `COUNT(*)` over mixed rows.
- Data quality checks should return zero rows: duplicates, missing contacts, stray spaces, and failed wells with no reason.
- Check a filter with a `SELECT` before running an `UPDATE`.

## How to run
1. Run `Schema.sql`.
2. Run `Sample_data.sql`.
3. Run the queries in `Queries.sql` one at a time.

The last query (`WITH ROLLUP`) is MySQL-specific.

## Sample output
Wells by status (sample data): 28 functional, 2 partially functional, 7 non-functional. Region C has the highest failure rate in the sample.

## About me
Data analyst based in Somalia, working with water-sector data.
Contact: [usameomar15@gmail.com] 
