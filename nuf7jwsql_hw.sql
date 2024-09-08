#Question 1: List all countries in South America.
SELECT Name FROM country WHERE Continent = 'South America';
#Question 2: Find the population of 'Germany'.
SELECT Name, Population from country WHERE Name = 'Germany';
# Question 3: Retrieve all cities in the country 'Japan'.
SELECT Name FROM city WHERE CountryCode = 'JPN';
# Question 4: Find the 3 most populated countries in the 'Africa' region.
SELECT Name, Population FROM country WHERE Region = "Eastern Africa" ORDER BY Population DESC LIMIT 3;
# Question 5: Retrieve the country and its life expectancy where the population is between 1 and 5 million.
SELECT Name, LifeExpectancy, Population FROM country WHERE Population > 1000000 AND Population < 5000000 ORDER BY Population DESC;
# Question 6: List countries with an official language of 'French'.
SELECT country.Name FROM country
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';
# Question 7: Retrieve all album titles by the artist 'AC/DC'.
SELECT Title FROM Album WHERE ArtistId = (SELECT ArtistId FROM Artist WHERE Name = 'AC/DC');
# Question 8: Find the name and email of customers located in 'Brazil'.
SELECT FirstName, LastName, Email FROM Customer WHERE country = "Brazil";
# Question 9: List all playlists in the database.
SELECT Name FROM Playlist;
# Question 10: Find the total number of tracks in the 'Rock' genre.
SELECT Count(Name) FROM Track WHERE GenreId = (SELECT GenreId FROM Genre WHERE Name = 'Rock');
# Question 11: List all employees who report to 'Nancy Edwards'.
SELECT FirstName, LastName FROM Employee WHERE ReportsTo = (SELECT EmployeeId FROM Employee WHERE FirstName = 'Nancy' AND LastName = 'Edwards');
# Question 12: Calculate the total sales per customer by summing the total amount in invoices.
SELECT Customer.FirstName,Customer.LastName,Customer.CustomerId, SUM(Invoice.Total) AS TotalSales
From Customer
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
Group BY Customer.CustomerId
ORDER BY TotalSales DESC;
# Create your own database
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20));

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID));

INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES 
(1, 'IPhone 13', 'Smartphone', 1000, 50),
(2, 'Samsung TV', 'Television', 500, 30),
(3, 'Airpod Pro', 'Audio', 250, 100),
(4, 'Dell Laptop', 'Computer', 1000, 25),
(5, 'XBOX One Controller', 'Accessories', 60, 100);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone)
VALUES 
(1, 'John', 'Doe', 'john.doe@gmail.com', '555-345-1234'),
(2, 'Jane', 'Smith', 'jane.smith@gmail.com', '555-342-5678'),
(3, 'Mike', 'Johnson', 'mike.johnson@gmail.com', '555-134- 9761'),
(4, 'Emily', 'Brown', 'emily.brown@gmail.com', '555-238-4211'),
(5, 'David', 'Lee', 'david.lee@gmail.com', '555-965-1735');

INSERT INTO Sales (SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount)
VALUES 
(1, 1, 1, '2023-05-15', 1, 1000),
(2, 2, 3, '2023-05-16', 2, 500),
(3, 3, 2, '2023-05-17', 1, 500),
(4, 4, 4, '2023-05-18', 1, 1000),
(5, 5, 5, '2023-05-19', 3, 180);

#total sales for each product
SELECT Products.ProductName, SUM(Sales.Quantity) AS TotalSold, SUM(Sales.TotalAmount) AS TotalRevenue
FROM Products
JOIN Sales ON Products.ProductID = Sales.ProductID
GROUP BY Products.ProductName
ORDER BY TotalRevenue DESC;

#Get customers who have made purchases over $500
SELECT Customers.FirstName, Customers.LastName, SUM(Sales.TotalAmount) AS TotalSpent
FROM Customers
JOIN Sales ON Customers.CustomerID = Sales.CustomerID
GROUP BY Customers.CustomerID
HAVING TotalSpent > 500
ORDER BY TotalSpent DESC;

#Get products with low inventory (under 50)
SELECT ProductName, Category, StockQuantity FROM Products
WHERE StockQuantity < 50
ORDER BY StockQuantity;



