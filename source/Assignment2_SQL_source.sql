

-- 1. CUSTOMER
CREATE TABLE CUSTOMER (
    CustomerID INTEGER PRIMARY KEY,
    FirstName TEXT NOT NULL,
    LastName TEXT,
    Email TEXT NOT NULL,
    Phone TEXT
);

-- 2. ADDRESS
CREATE TABLE ADDRESS (
    AddressID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    StreetAddress TEXT NOT NULL,
    Suburb TEXT,
    State TEXT NOT NULL,
    Postcode TEXT NOT NULL,
    FOREIGN KEY (CustomerID)
        REFERENCES CUSTOMER(CustomerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 3. STORE
CREATE TABLE STORE (
    StoreID INTEGER PRIMARY KEY,
    StoreName TEXT NOT NULL,
    StreetAddress TEXT,
    Suburb TEXT NOT NULL,
    State TEXT NOT NULL,
    Postcode TEXT NOT NULL,
    Phone TEXT
);

-- 4. DRIVER
CREATE TABLE DRIVER (
    DriverID INTEGER PRIMARY KEY,
    StoreID INTEGER NOT NULL,
    FirstName TEXT NOT NULL,
    LastName TEXT,
    Phone TEXT NOT NULL,
    DriverStatus TEXT NOT NULL,
    FOREIGN KEY (StoreID)
        REFERENCES STORE(StoreID)
        ON UPDATE CASCADE
);

-- 5. MENU_CATEGORY
CREATE TABLE MENU_CATEGORY (
    CategoryID INTEGER PRIMARY KEY,
    CategoryName TEXT NOT NULL,
    Description TEXT
);

-- 6. MENU_ITEM
CREATE TABLE MENU_ITEM (
    MenuItemID INTEGER PRIMARY KEY,
    CategoryID INTEGER NOT NULL,
    ItemName TEXT NOT NULL,
    Description TEXT,
    AvailabilityStatus TEXT,
    FOREIGN KEY (CategoryID)
        REFERENCES MENU_CATEGORY(CategoryID)
        ON UPDATE CASCADE
);

-- 7. MENU_VARIANT
CREATE TABLE MENU_VARIANT (
    VariantID INTEGER PRIMARY KEY,
    MenuItemID INTEGER NOT NULL,
    Size TEXT,
    CrustType TEXT,
    CurrentPrice DECIMAL NOT NULL CHECK (CurrentPrice >= 0),
    AvailabilityStatus TEXT,
    FOREIGN KEY (MenuItemID)
        REFERENCES MENU_ITEM(MenuItemID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 8. ORDERS
CREATE TABLE ORDERS (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    StoreID INTEGER NOT NULL,
    OrderDateTime DATETIME NOT NULL,
    OrderStatus TEXT,
    FOREIGN KEY (CustomerID)
        REFERENCES CUSTOMER(CustomerID)
        ON UPDATE CASCADE,
    FOREIGN KEY (StoreID)
        REFERENCES STORE(StoreID)
        ON UPDATE CASCADE
);

-- 9. ORDER_ITEM
CREATE TABLE ORDER_ITEM (
    OrderID INTEGER NOT NULL,
    LineNumber INTEGER NOT NULL,
    VariantID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL NOT NULL CHECK (UnitPrice >= 0),
    SpecialInstructions TEXT,
    PRIMARY KEY (OrderID, LineNumber),
    FOREIGN KEY (OrderID)
        REFERENCES ORDERS(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (VariantID)
        REFERENCES MENU_VARIANT(VariantID)
        ON UPDATE CASCADE
);

-- 10. PAYMENT
CREATE TABLE PAYMENT (
    PaymentID INTEGER PRIMARY KEY,
    OrderID INTEGER NOT NULL UNIQUE,
    PaymentMethod TEXT,
    PaymentAmount DECIMAL NOT NULL CHECK (PaymentAmount >= 0),
    PaymentStatus TEXT,
    PaymentDateTime DATETIME,
    VoucherCode TEXT,
    PriorityFee DECIMAL CHECK (PriorityFee IS NULL OR PriorityFee >= 0),
    FOREIGN KEY (OrderID)
        REFERENCES ORDERS(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 11. PICKUP_ORDER
CREATE TABLE PICKUP_ORDER (
    OrderID INTEGER PRIMARY KEY,
    FOREIGN KEY (OrderID)
        REFERENCES ORDERS(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 12. DELIVERY_ORDER
CREATE TABLE DELIVERY_ORDER (
    OrderID INTEGER PRIMARY KEY,
    FOREIGN KEY (OrderID)
        REFERENCES ORDERS(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 13. DELIVERY
CREATE TABLE DELIVERY (
    DeliveryID INTEGER PRIMARY KEY,
    OrderID INTEGER NOT NULL UNIQUE,
    DriverID INTEGER,
    AddressID INTEGER NOT NULL,
    TrackerStatus TEXT,
    DispatchTime DATETIME,
    DeliveredTime DATETIME,
    EstimatedDeliveryTime DATETIME,
    CHECK (
        DeliveredTime IS NULL
        OR DispatchTime IS NULL
        OR DeliveredTime >= DispatchTime
    ),
    FOREIGN KEY (OrderID)
        REFERENCES DELIVERY_ORDER(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (DriverID)
        REFERENCES DRIVER(DriverID)
        ON UPDATE CASCADE,
    FOREIGN KEY (AddressID)
        REFERENCES ADDRESS(AddressID)
        ON UPDATE CASCADE
);

-- =========================================================
-- SAMPLE DATA
-- =========================================================

INSERT INTO CUSTOMER (CustomerID, FirstName, LastName, Email, Phone)
VALUES
(1, 'Alice', 'Smith', 'alice@email.com', '0400111221'),
(2, 'Bob', 'Jones', 'bob@email.com', '0400111222'),
(3, 'Charlie', 'Brown', 'charlie@email.com', '0400111223'),
(4, 'Diana', 'Prince', 'diana@email.com', '0400111224'),
(5, 'Ethan', 'Hunt', 'ethan@email.com', '0400111225'),
(6, 'Fiona', 'Gallagher', 'fiona@email.com', '0400111226'),
(7, 'George', 'Costanza', 'george@email.com', '0400111227'),
(8, 'Hannah', 'Abbott', 'hannah@email.com', '0400111228'),
(9, 'Ian', 'Malcolm', 'ian@email.com', '0400111229'),
(10, 'Julia', 'Child', 'julia@email.com', '0400111230');

INSERT INTO ADDRESS (AddressID, CustomerID, StreetAddress, Suburb, State, Postcode)
VALUES
(1, 1, '123 Palm St', 'Darwin City', 'NT', '0800'),
(2, 2, '456 Casuarina Dr', 'Casuarina', 'NT', '0810'),
(3, 3, '789 Mitchell St', 'Darwin City', 'NT', '0800'),
(4, 4, '101 Smith St', 'Darwin City', 'NT', '0800'),
(5, 5, '202 Trower Rd', 'Nightcliff', 'NT', '0810'),
(6, 6, '303 McMillans Rd', 'Jingili', 'NT', '0810'),
(7, 7, '404 Vanderlin Dr', 'Karama', 'NT', '0812'),
(8, 8, '505 Roystonea Ave', 'Palmerston', 'NT', '0830'),
(9, 9, '606 Stuart Hwy', 'Berrimah', 'NT', '0828'),
(10, 10, '707 Tiger Brennan Dr', 'Winnellie', 'NT', '0820');

INSERT INTO STORE (StoreID, StoreName, StreetAddress, Suburb, State, Postcode, Phone)
VALUES
(1, 'Dominos Darwin City', '10 Knuckey St', 'Darwin', 'NT', '0800', '0889000001'),
(2, 'Dominos Casuarina', 'Casuarina Square', 'Casuarina', 'NT', '0810', '0889000002'),
(3, 'Dominos Palmerston', 'Oasis Shopping Village', 'Palmerston', 'NT', '0830', '0889000003'),
(4, 'Dominos Nightcliff', 'Progress Dr', 'Nightcliff', 'NT', '0810', '0889000004'),
(5, 'Dominos Karama', 'Karama Shopping Plaza', 'Karama', 'NT', '0812', '0889000005'),
(6, 'Dominos Winnellie', 'Stuart Hwy', 'Winnellie', 'NT', '0820', '0889000006'),
(7, 'Dominos Coolalinga', 'Coolalinga Central', 'Coolalinga', 'NT', '0839', '0889000007'),
(8, 'Dominos Parap', 'Parap Village', 'Parap', 'NT', '0820', '0889000008'),
(9, 'Dominos Stuart Park', 'Westralia St', 'Stuart Park', 'NT', '0820', '0889000009'),
(10, 'Dominos Berrimah', 'Berrimah Rd', 'Berrimah', 'NT', '0828', '0889000010');

INSERT INTO DRIVER (DriverID, StoreID, FirstName, LastName, Phone, DriverStatus)
VALUES
(1, 1, 'Tom', 'Hardy', '0412000001', 'Available'),
(2, 2, 'Emma', 'Stone', '0412000002', 'Available'),
(3, 3, 'Chris', 'Evans', '0412000003', 'On Delivery'),
(4, 4, 'Scarlett', 'Johansson', '0412000004', 'Available'),
(5, 5, 'Mark', 'Ruffalo', '0412000005', 'Off Duty'),
(6, 6, 'Jeremy', 'Renner', '0412000006', 'Available'),
(7, 7, 'Paul', 'Rudd', '0412000007', 'On Delivery'),
(8, 8, 'Brie', 'Larson', '0412000008', 'Available'),
(9, 9, 'Chadwick', 'Boseman', '0412000009', 'Available'),
(10, 10, 'Don', 'Cheadle', '0412000010', 'Off Duty');

INSERT INTO MENU_CATEGORY (CategoryID, CategoryName, Description)
VALUES
(1, 'Traditional Pizzas', 'Classic favorites'),
(2, 'Premium Pizzas', 'Gourmet ingredients'),
(3, 'Value Pizzas', 'Affordable classics'),
(4, 'Vegan Pizzas', '100% Plant-based'),
(5, 'Sides', 'Breads, wings, and bites'),
(6, 'Desserts', 'Sweet treats'),
(7, 'Drinks', 'Sodas and juices'),
(8, 'Dips', 'Sauces for dipping'),
(9, 'Pasta', 'Oven-baked pastas'),
(10, 'Salads', 'Fresh side salads');

INSERT INTO MENU_ITEM (MenuItemID, CategoryID, ItemName, Description, AvailabilityStatus)
VALUES
(1, 1, 'Margherita', 'Classic cheese and tomato', 'Available'),
(2, 1, 'Pepperoni', 'Double pepperoni and cheese', 'Available'),
(3, 2, 'BBQ Meatlovers', 'Bacon, beef, ham, sausage', 'Available'),
(4, 2, 'Supreme', 'Everything on it', 'Available'),
(5, 3, 'Hawaiian', 'Ham and pineapple', 'Available'),
(6, 4, 'Vegan Margherita', 'Dairy-free cheese', 'Available'),
(7, 5, 'Garlic Bread', 'Oven-baked garlic baguette', 'Available'),
(8, 6, 'Choc Lava Cake', 'Warm chocolate center', 'Available'),
(9, 7, 'Coca-Cola 1.25L', 'Classic soda', 'Available'),
(10, 8, 'Garlic Aioli Dip', 'Creamy garlic sauce', 'Available');

INSERT INTO MENU_VARIANT (VariantID, MenuItemID, Size, CrustType, CurrentPrice, AvailabilityStatus)
VALUES
(1, 1, 'Large', 'Classic Crust', 12.00, 'Available'),
(2, 2, 'Large', 'Thin Crust', 14.00, 'Available'),
(3, 3, 'Large', 'Cheesy Crust', 18.50, 'Available'),
(4, 4, 'Extra Large', 'Classic Crust', 21.00, 'Available'),
(5, 5, 'Large', 'Classic Crust', 10.00, 'Available'),
(6, 6, 'Medium', 'Thin Crust', 15.00, 'Available'),
(7, 7, 'Standard', NULL, 4.50, 'Available'),
(8, 8, 'Standard', NULL, 5.50, 'Available'),
(9, 9, '1.25L', NULL, 4.95, 'Available'),
(10, 10, 'Single', NULL, 1.00, 'Available');

INSERT INTO ORDERS (OrderID, CustomerID, StoreID, OrderDateTime, OrderStatus)
VALUES
(1, 1, 1, '2026-09-04 18:05:00', 'Completed'),
(2, 2, 2, '2026-09-04 18:10:00', 'Completed'),
(3, 3, 3, '2026-09-04 18:15:00', 'Preparing'),
(4, 4, 4, '2026-09-04 18:20:00', 'Completed'),
(5, 5, 5, '2026-09-04 18:25:00', 'Completed'),
(6, 6, 6, '2026-09-04 18:30:00', 'Ready for Pickup'),
(7, 7, 7, '2026-09-04 18:35:00', 'Completed'),
(8, 8, 8, '2026-09-04 18:40:00', 'Completed'),
(9, 9, 9, '2026-09-04 18:45:00', 'Completed'),
(10, 10, 10, '2026-09-04 18:50:00', 'Completed'),
(11, 1, 1, '2026-09-04 19:00:00', 'Completed'),
(12, 2, 2, '2026-09-04 19:05:00', 'Completed'),
(13, 3, 3, '2026-09-04 19:10:00', 'Out for Delivery'),
(14, 4, 4, '2026-09-04 19:15:00', 'Completed'),
(15, 5, 5, '2026-09-04 19:20:00', 'Completed'),
(16, 6, 6, '2026-09-04 19:25:00', 'Completed'),
(17, 7, 7, '2026-09-04 19:30:00', 'Completed'),
(18, 8, 8, '2026-09-04 19:35:00', 'Out for Delivery'),
(19, 9, 9, '2026-09-04 19:40:00', 'Completed'),
(20, 10, 10, '2026-09-04 19:45:00', 'Completed');

INSERT INTO ORDER_ITEM (OrderID, LineNumber, VariantID, Quantity, UnitPrice, SpecialInstructions)
VALUES
(1, 1, 1, 1, 12.00, 'Extra cheese'),
(2, 1, 2, 2, 14.00, 'No chili'),
(3, 1, 3, 1, 18.50, NULL),
(4, 1, 4, 1, 21.00, 'Well done'),
(5, 1, 5, 3, 10.00, NULL),
(6, 1, 6, 1, 15.00, NULL),
(7, 1, 7, 2, 4.50, NULL),
(8, 1, 8, 1, 5.50, NULL),
(9, 1, 9, 1, 4.95, NULL),
(10, 1, 10, 4, 1.00, NULL),
(11, 1, 1, 1, 12.00, NULL),
(12, 1, 2, 1, 14.00, NULL),
(13, 1, 3, 1, 18.50, NULL),
(14, 1, 4, 1, 21.00, NULL),
(15, 1, 5, 2, 10.00, NULL),
(16, 1, 6, 1, 15.00, NULL),
(17, 1, 7, 1, 4.50, NULL),
(18, 1, 8, 2, 5.50, NULL),
(19, 1, 9, 1, 4.95, NULL),
(20, 1, 10, 1, 1.00, NULL);

INSERT INTO PAYMENT (PaymentID, OrderID, PaymentMethod, PaymentAmount, PaymentStatus, PaymentDateTime, VoucherCode, PriorityFee)
VALUES
(1, 1, 'Card', 12.00, 'Paid', '2026-09-04 18:06:00', NULL, 0.00),
(2, 2, 'Cash', 28.00, 'Paid', '2026-09-04 18:11:00', NULL, 0.00),
(3, 3, 'Card', 18.50, 'Paid', '2026-09-04 18:16:00', 'DISC10', 0.00),
(4, 4, 'Card', 21.00, 'Paid', '2026-09-04 18:21:00', NULL, 0.00),
(5, 5, 'Card', 30.00, 'Paid', '2026-09-04 18:26:00', NULL, 0.00),
(6, 6, 'Card', 15.00, 'Paid', '2026-09-04 18:31:00', NULL, 0.00),
(7, 7, 'Card', 9.00, 'Paid', '2026-09-04 18:36:00', NULL, 0.00),
(8, 8, 'Card', 5.50, 'Paid', '2026-09-04 18:41:00', NULL, 0.00),
(9, 9, 'Card', 4.95, 'Paid', '2026-09-04 18:46:00', NULL, 0.00),
(10, 10, 'Card', 4.00, 'Paid', '2026-09-04 18:51:00', NULL, 0.00),
(11, 11, 'Card', 12.00, 'Paid', '2026-09-04 19:01:00', NULL, 0.00),
(12, 12, 'Card', 14.00, 'Paid', '2026-09-04 19:06:00', NULL, 0.00),
(13, 13, 'Card', 18.50, 'Paid', '2026-09-04 19:11:00', NULL, 0.00),
(14, 14, 'Card', 21.00, 'Paid', '2026-09-04 19:16:00', NULL, 0.00),
(15, 15, 'Card', 20.00, 'Paid', '2026-09-04 19:21:00', NULL, 0.00),
(16, 16, 'Card', 15.00, 'Paid', '2026-09-04 19:26:00', NULL, 0.00),
(17, 17, 'Card', 4.50, 'Paid', '2026-09-04 19:31:00', NULL, 0.00),
(18, 18, 'Card', 11.00, 'Paid', '2026-09-04 19:36:00', NULL, 0.00),
(19, 19, 'Card', 4.95, 'Paid', '2026-09-04 19:41:00', NULL, 0.00),
(20, 20, 'Card', 1.00, 'Paid', '2026-09-04 19:46:00', NULL, 0.00);

INSERT INTO PICKUP_ORDER (OrderID)
VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO DELIVERY_ORDER (OrderID)
VALUES
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

INSERT INTO DELIVERY (
    DeliveryID, OrderID, DriverID, AddressID,
    TrackerStatus, DispatchTime, DeliveredTime, EstimatedDeliveryTime
)
VALUES
(1, 11, 1, 1, 'Delivered', '2026-09-04 19:15:00', '2026-09-04 19:35:00', '2026-09-04 19:40:00'),
(2, 12, 2, 2, 'Delivered', '2026-09-04 19:20:00', '2026-09-04 19:45:00', '2026-09-04 19:50:00'),
(3, 13, 3, 3, 'On the way', '2026-09-04 19:30:00', NULL, '2026-09-04 19:55:00'),
(4, 14, 4, 4, 'Delivered', '2026-09-04 19:25:00', '2026-09-04 19:50:00', '2026-09-04 19:55:00'),
(5, 15, 5, 5, 'Delivered', '2026-09-04 19:35:00', '2026-09-04 20:00:00', '2026-09-04 20:05:00'),
(6, 16, 6, 6, 'Delivered', '2026-09-04 19:40:00', '2026-09-04 20:10:00', '2026-09-04 20:15:00'),
(7, 17, 7, 7, 'Delivered', '2026-09-04 19:45:00', '2026-09-04 20:15:00', '2026-09-04 20:20:00'),
(8, 18, 8, 8, 'On the way', '2026-09-04 19:55:00', NULL, '2026-09-04 20:20:00'),
(9, 19, 9, 9, 'Delivered', '2026-09-04 19:50:00', '2026-09-04 20:25:00', '2026-09-04 20:30:00'),
(10, 20, 10, 10, 'Delivered', '2026-09-04 20:00:00', '2026-09-04 20:30:00', '2026-09-04 20:35:00');

-- =========================================================
-- RUBRIC DEMONSTRATION: ALTER, UPDATE, DROP
-- =========================================================

ALTER TABLE CUSTOMER
ADD COLUMN LoyaltyPoints INTEGER DEFAULT 0;

UPDATE CUSTOMER
SET LoyaltyPoints = 150
WHERE CustomerID IN (1, 2, 3);

CREATE TABLE TEMP_PROMOTIONS (
    PromoID INTEGER PRIMARY KEY,
    PromoCode TEXT NOT NULL,
    DiscountPercentage DECIMAL NOT NULL
);

DROP TABLE TEMP_PROMOTIONS;

-- =========================================================
-- SQL USE CASES
-- =========================================================

-- Query 1: Simple filter
SELECT VariantID, MenuItemID, Size, CrustType, CurrentPrice, AvailabilityStatus
FROM MENU_VARIANT
WHERE CurrentPrice BETWEEN 10 AND 20
  AND CrustType IS NOT NULL
  AND AvailabilityStatus = 'Available';

-- Query 2: Simple multi-condition filter
SELECT OrderID, CustomerID, StoreID, OrderDateTime, OrderStatus
FROM ORDERS
WHERE OrderStatus IN ('Completed', 'Out for Delivery')
  AND OrderDateTime >= '2026-09-04 19:00:00'
  AND (StoreID = 3 OR StoreID = 8)
  AND OrderStatus LIKE '%D%';

-- Query 3: Moderately complex LEFT JOIN
SELECT
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderStatus,
    a.StreetAddress,
    a.Suburb
FROM CUSTOMER c
JOIN ORDERS o
    ON c.CustomerID = o.CustomerID
LEFT JOIN DELIVERY d
    ON o.OrderID = d.OrderID
LEFT JOIN ADDRESS a
    ON d.AddressID = a.AddressID
ORDER BY o.OrderID;

-- Query 4: Complex query with aggregate + nested subquery
SELECT
    s.StoreName,
    ROUND(AVG(p.PaymentAmount), 2) AS AvgOrderValue
FROM STORE s
JOIN ORDERS o
    ON s.StoreID = o.StoreID
JOIN PAYMENT p
    ON o.OrderID = p.OrderID
GROUP BY s.StoreID, s.StoreName
HAVING AVG(p.PaymentAmount) > (
    SELECT AVG(PaymentAmount)
    FROM PAYMENT
)
ORDER BY AvgOrderValue DESC;
"""

path = "/mnt/data/PRT563_Assignment2_Final_SQL.sql"
with open(path, "w", encoding="utf-8") as f:
    f.write(sql)

# Validate by executing against SQLite in-memory.
import sqlite3, pathlib, textwrap, json, os, sys
conn = sqlite3.connect(":memory:")
try:
    conn.executescript(sql)
    status = "Validation passed: the complete SQL script executes successfully in SQLite."
except Exception as e:
    status = f"Validation error: {e}"
finally:
    conn.close()

print(status)
print(path)
