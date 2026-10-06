# PRT563 Assignment 3 - Neo4j Graph Database Migration

Student: Saqib Zia (S399396)

## Purpose
This repository contains the reproducible Neo4j implementation for Assignment 3 using the final-state Assignment 2 SQL/SQLite data as the source of truth.

## Required files
- `import.txt` - imports the operational graph, constraints and indexes and prepares the analytics layers.
- `queries.txt` - four Cypher use cases.
- `gds_algorithms.txt` - four centrality algorithms and three similarity algorithms.
- `live_verification.txt` - migration and integrity checks.
- `csv/` - all CSV files required by the import.
- `source/Assignment2_SQL_source.sql` - the Assignment 2 source SQL used for the CSV dataset.
- `FINAL_CHECKLIST.md` - final execution checklist.

## Dataset baseline
The repository uses the final-state Assignment 2 source data:
- 10 Customers
- 10 Addresses
- 10 Stores
- 10 Drivers
- 10 MenuCategories
- 10 MenuItems
- 10 MenuVariants
- 20 Orders
- 20 Order-item rows / `CONTAINS` relationships
- 20 Payments
- 10 Deliveries
- 10 Pickup orders
- 10 Delivery orders

## Execution order
1. Create a fresh local Neo4j database.
2. Install a compatible Neo4j Graph Data Science (GDS) version.
3. Verify `RETURN version();` and `RETURN gds.version();`.
4. Copy all CSV files into the active Neo4j import directory.
5. Run `import.txt` once on the clean database.
6. Run `live_verification.txt` and confirm all expected counts/integrity checks pass.
7. Run the four queries in `queries.txt` one at a time.
8. Run the four centrality and three similarity experiments in `gds_algorithms.txt`.
9. Save genuine Neo4j/GDS screenshots.
10. Compare the live outputs with the Word report and update only genuine data-dependent results.

## Important reproducibility rule
Do not edit or invent results to make them match a report table. Live Neo4j/GDS results are authoritative for final numerical evidence.

## Security
Do not commit Neo4j passwords, GitHub tokens, API keys or other secrets.
