# PRT563 Assignment 3 - Final Repository Checklist

Student: Saqib Zia (S399396)

## Before upload
- [ ] Fresh Neo4j database created
- [ ] Compatible GDS installed
- [ ] All CSV files are final Assignment 2 source data
- [ ] `import.txt` present
- [ ] `queries.txt` present
- [ ] `gds_algorithms.txt` present
- [ ] `live_verification.txt` present
- [ ] `README.md` present
- [ ] `source/Assignment2_SQL_source.sql` present

## Expected migration checks
- [ ] Customer = 10
- [ ] Address = 10
- [ ] Store = 10
- [ ] Driver = 10
- [ ] MenuCategory = 10
- [ ] MenuItem = 10
- [ ] MenuVariant = 10
- [ ] Order = 20
- [ ] CONTAINS = 20
- [ ] Payment = 20
- [ ] Delivery = 10
- [ ] PickupOrder = 10
- [ ] DeliveryOrder = 10
- [ ] No order has both subtype labels
- [ ] No pickup order has `FULFILLED_BY`
- [ ] Every delivery order has `FULFILLED_BY`
- [ ] No invalid CONTAINS quantity/price rows
- [ ] No duplicate `(OrderID, LineNumber)` rows

## Analytics
- [ ] Degree runs
- [ ] Betweenness runs
- [ ] Closeness runs
- [ ] PageRank runs
- [ ] Node Similarity / Jaccard runs
- [ ] Filtered Node Similarity / Overlap runs
- [ ] KNN / Cosine runs

## Submission
- [ ] Genuine screenshots saved
- [ ] Word report reconciled with live results
- [ ] GitHub repository is accessible to the marker
- [ ] Actual repository URL copied into Blackboard
