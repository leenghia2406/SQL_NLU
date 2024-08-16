				-- SELECT --
-- Lấy ra tên tất cả sản phẩm --
SELECT ProductName FROM dbo.Products;
-- Lấy ra tất cả dữ liệu từ bảng khách hàng 
SELECT * FROM dbo.Customers;
-- Lấy ra tên công ty và quốc gia của khách hàng --
SELECT CompanyName, Country FROM dbo.Customers;
-- Lấy ra tên các quốc gia khác nhau từ bảng khách hàng
				-- SELECT DISTINCT --
SELECT DISTINCT Country FROM dbo.Customers;
-- Lấy ra tên các mã số bưu điện khác nhau từ bảng nhà cung cấp
SELECT DISTINCT PostalCode FROM dbo.Suppliers;
-- Lấy ra các Họ khác nhau và cách gọi lịch sự của nhân viên
SELECT LastName, TitleOfCourtesy FROM dbo.Employees;
-- Lấy ra mã đơn vị vận chuyển khác nhau của các đơn hàng
SELECT DISTINCT ShipVia FROM dbo.Orders;
-- Lấy ra 5 dòng đầu tiên trong bảng Customers
				-- SELECT TOP --
SELECT TOP 5 * FROM dbo.Customers;
-- Lấy ra 30% nhân viên của công ty hiện tại
SELECT TOP 30 PERCENT * FROM dbo.Employees;
-- Lấy ra các đơn hàng không trùng mã khách hàng, chỉ lấy 5 dòng dữ liệu đầu tiên
SELECT DISTINCT TOP 5 (CustomerID) FROM dbo.Orders;
-- Lấy ra các sản phẩm không trùng mã thể loại, lấy ra 3 dòng đầu tiên
SELECT DISTINCT TOP 3 ProductID FROM dbo.Products;
				-- ALIAS--
-- Đặt CompanyName thành Tên công ty và PostalCode thành Mã bưu điện
SELECT CompanyName AS "TÊN CÔNG TY", PostalCode AS "MÃ BƯU ĐIỆN", City AS "THÀNH PHỐ" FROM dbo.Customers;
-- Đặt LastName thành Họ và FirstName thành Tên trong bảng nhân viên
SELECT LastName AS "HỌ", FirstName AS "TÊN" FROM dbo.Employees;
-- Lấy ra 15 dòng đầu tiên tất cả các cột trong bảng Orders, đặt tên thay thế là đơn hàng
SELECT TOP 15 * FROM dbo.Orders AS "ĐƠN HÀNG";
				-- MIN MAX --
-- Tìm giá thấp nhất của các sản phẩm trong Products
SELECT MIN(UnitPrice) AS "MIN PRICE" FROM dbo.Products;
-- Lấy ra ngày đặt hàng gần đây nhất từ bảng Orders
SELECT MAX(OrderDate) AS "MAX ORDER DATE" FROM dbo.Orders;
-- Lấy ra sản phẩm có số lượng hàng trong kho lớn nhất 
SELECT MAX(UnitsInStock) AS "CÒN HÀNG NHIỀU NHẤT" FROM dbo.Products;
-- Cho biết nhân viên lớn tuổi nhất trong công ty --
SELECT MIN(BirthDate) FROM dbo.Employees;
				-- COUNT, SUM, AVG --
-- Đếm số lượng khách hàng có trong bảng Customers
SELECT COUNT(*) AS "NUMBER OF CUSTOMER" FROM dbo.Customers;
-- Tính tổng số tiền vận chuyển của tất cả các đơn đặt hàng --
SELECT SUM(Freight) FROM dbo.Orders;
-- Tính trung bình số lượng đặt hàng của tất cả các sản phẩm trong bảng Order Details
SELECT AVG(Quantity) AS "AVG QUANTITY" FROM dbo.[Order Details];
-- Đếm số lượng, tính tổng số lượng hàng trong kho và trung bình giá các sản phẩm trong Producst
SELECT COUNT(*) AS "NUMBER OF PRODUCT", SUM(UnitsInStock) AS "Total Unit in Stock", 
AVG(UnitPrice) AS "AVG Price" FROM dbo.Products;
-- Đếm số lượng đơn hàng từ bảng Orders
SELECT COUNT(*) FROM dbo.Orders;
SELECT COUNT(OrderID) FROM dbo.Orders;
-- Từ bảng Order Details tính trung bình cột UnitPrice và tính tổng cột Quantity
SELECT AVG(UnitPrice), SUM(Quantity) FROM dbo.[Order Details];
				-- ORDER BY--
-- Liệt kê tất cả các nhà cung cấp theo thứ tự tên công ty từ A - Z
SELECT * FROM dbo.Suppliers ORDER BY CompanyName;
-- Liệt kê tất cả các sản phẩm theo thứ tự giá giảm dần 
SELECT * FROM dbo.Products ORDER BY UnitPrice DESC;
-- Liệt kê tất cả các nhân viên theo thứ tự họ và tên đệm A - Z
SELECT * FROM dbo.Employees ORDER BY LastName, FirstName;
-- Lấy ra sản phẩm có số lượng bán cao nhất từ bản Order Details (ko dùng MAX)
SELECT TOP 1 * FROM dbo.[Order Details] ORDER BY Quantity DESC;
SELECT MAX(Quantity) FROM [Order Details];
-- Liệt kê orderID trong bảng Orders theo thứ tự giảm dần của ngày đặt hàng
SELECT OrderID FROM dbo.Orders ORDER BY OrderDate DESC;
-- Liệt kê tên, đơn giá, số lượng trong kho của tất cả các sản phẩm trong bảng Products, theo thứ tự giảm dần của UnitInStock
SELECT ProductName, UnitPrice, UnitsInStock FROM dbo.Products ORDER BY UnitsInStock DESC;
				-- CÁC PHÉP TOÁN --
-- Lấy ra số lượng hàng tồn kho
SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder,UnitsInStock - UnitsOnOrder AS "StockRemaining" FROM dbo.Products;
-- Tính giá trị đơn hàng chi tiết cho tất cả sản phẩm trong bảng OrderDetails
SELECT *, UnitPrice * Quantity AS "ORDER DETAIL VALUE" FROM dbo.[Order Details];
-- Tính tỉ lệ giá vận chuyển đơn đặt hàng trung bình của các đơn hàng trong bảng Orders so với giá trị vận chuyển của đơn hàng lớn nhất
SELECT AVG(Freight) / MAX(Freight) FROM dbo.Orders;
-- Liệt kê ds các sản phẩm và giá của từng sp được giảm đi 10%
SELECT *, UnitPrice, UnitPrice - UnitPrice* 0.1 AS "SAU KHI GIAM" FROM dbo.Products;
				-- WHERE --
-- Liệt kế tất cả nhân viên đến từ thành phố London, sắp xếp theo tên
SELECT * FROM dbo.Employees WHERE City = 'London' ORDER BY LastName ASC;
-- Liệt kê tất cả các đơn hàng bị giao muộn, đếm số lượng
SELECT COUNT(*) AS "SỐ ĐƠN GIAO MUỘN" FROM dbo.Orders WHERE ShippedDate > RequiredDate;
-- Lấy ra tất cả đơn hàng được giảm giá nhiều hơn 10%
SELECT * FROM [Order Details] WHERE Discount > 0.1;
-- Đếm số lượng
SELECT COUNT(*) FROM [Order Details] WHERE Discount > 0.1;
-- Liệt kê tất cả đơn hàng được gửi đến Pháp
SELECT * FROM dbo.Orders WHERE ShipCountry = 'France';
-- Liệt kê tất cả sản phẩm có số lượng hàng trong kho lớn hơn 20
SELECT * FROM dbo.Products WHERE UnitsInStock > 20;
				-- AND, OR, NOT --
-- Liệt kê tất cả sản phẩm có số lượng trong kho nhỏ hơn 50 hoặc lớn hơn 100
SELECT * FROM dbo.Products WHERE UnitsInStock < 50 OR UnitsInStock > 100;
-- Liệt kê tất cả đơn hàng giao đến Brazil đã bị giao muộn
SELECT * FROM dbo.Orders WHERE ShipCountry = 'Brazil' AND ShippedDate > RequiredDate;
-- Lấy tất cả sản phẩm có giá dưới 100 và mã thể loại khác 1
SELECT * FROM dbo.Products WHERE UnitPrice < 100 AND CategoryID != 1;
SELECT * FROM dbo.Products WHERE NOT( UnitPrice >= 100 OR CategoryID = 1);
-- Liệt kê tất cả đơn hàng có giá vận chuyển trong khoảng 50 - 100 đô
SELECT * FROM dbo.Orders WHERE Freight <= 100 AND Freight >= 50;
SELECT * FROM dbo.Orders WHERE NOT (Freight <50 OR Freight >100);
-- Liệt kê các sản phẩm có số lượng hàng trong kho lớn hơn 20 và số hàng trong đơn nhỏ hơn 20
SELECT * FROM dbo.Products WHERE UnitsInStock > 20 AND UnitsOnOrder < 20;
SELECT * FROM dbo.Products WHERE NOT(UnitsInStock <= 20 OR UnitsOnOrder >= 20);
				-- BETWEEN --
-- Lấy ds các sp có giá bán trong khoảng 10 - 20 đô
SELECT * FROM dbo.Products WHERE UnitPrice BETWEEN 10 AND 20;
-- Lấy ds các đơn đặt hàng được đặt trong khoảng 1996-07-01 đến 1996-07-31
SELECT * FROM Orders WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';
-- Tính tổng tiền vận chuyển của các đơn đặt hàng trong tháng 7
SELECT SUM(Freight) AS "Total July Freight" FROM dbo.Orders WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';
-- Lấy ds các đơn đặt hàng trong năm 1997 được vận chuyển = tàu thủy
SELECT * FROM dbo.Orders WHERE ShipVia = 3;
				-- LIKE --
-- Lọc tất cả khách hàng đến từ quốc gia có tên bắt đầu là A
SELECT * FROM dbo.Customers WHERE Country LIKE 'A%';
-- Lấy ds các đơn đặt hàng được gửi đến thành phố có chứa chữ a
SELECT * FROM dbo.Orders WHERE ShipCity LIKE '%a%';
-- Lọc tất cả đơn hàng với điều kiện ShipCountry LIKE 'U_' và ShipCountry LIKE 'U%'
SELECT * FROM dbo.Orders WHERE ShipCountry LIKE 'U_';
SELECT * FROM dbo.Orders WHERE ShipCountry LIKE 'U%';
-- Lấy ra tất cả nhà cung cấp hàng có chữ 'b' trong tên công ty
SELECT * FROM dbo.Suppliers WHERE CompanyName LIKE '%b%';
				-- WILDCARD --
-- Lọc ra tất cả các khách hàng có tên liên hệ bắt đầu bằng chữ A --
SELECT * FROM dbo.Customers WHERE ContactName LIKE 'A%';
-- Lọc ra tất cả các khách hàng có tên liên hệ bắt đầu bằng chữ H, chữ thứ 2 là bất kì kí tự nào
SELECT * FROM Customers WHERE ContactName LIKE 'H_%';
-- Lọc ra tất cả đơn hàng được gửi đến thành phố có chữ cái bắt đầu là L, chữ thứ hai là u hoặc o
SELECT * FROM Orders WHERE ShipCity LIKE 'Lu%' OR ShipCity LIKE 'Lo%';
SELECT * FROM Orders WHERE ShipCity LIKE 'L[u, o]%';
-- Lọc ra tất cả đơn hàng được gửi đến thành phố có chữ cái bắt đầu là L, chữ thứ hai không phải là u hoặc o
SELECT * FROM Orders WHERE ShipCity LIKE 'L_%' AND ShipCity NOT LIKE 'Lo%' AND ShipCity NOT LIKE 'Lu%';
SELECT * FROM Orders WHERE ShipCity LIKE 'L[^u, o]%';
-- Lọc ra tất cả đơn hàng được gửi đến thành phố có chữ cái bắt đầu là L, chữ thứ hai là các kí tự từ a đến u
SELECT * FROM Orders WHERE ShipCity LIKE 'L[a-u]%';
-- Lấy ra tất cả nhà cung cấp hàng có tên công ty bắt đầu bằng chữ A và ko chứa kí tự b
SELECT * FROM Suppliers WHERE CompanyName LIKE 'A%' AND CompanyName NOT LIKE '%B%';
				-- IN, NOT IN --
-- Lọc ra những đơn hàng giao đến Brazil, UK, Germany
SELECT * FROM Orders WHERE ShipCountry IN ('Brazil', 'UK', 'Germany');
-- Lọc ra những đơn hàng giao đến những quốc gia khác Brazil, UK, Germany
SELECT * FROM Orders WHERE ShipCountry NOT IN ('Brazil', 'UK', 'Germany');
-- Lấy các sản phẩm có mã thể loại khác 2, 3, 4
SELECT * FROM Products WHERE CategoryID NOT IN (2, 3, 4);
-- Liệt kê các nhân viên không phải là nữ
SELECT * FROM Employees WHERE TitleOfCourtesy NOT IN ('Ms.', 'Mrs.');
-- Liệt kê các nhân viên là nữ
SELECT * FROM Employees WHERE TitleOfCourtesy IN ('Ms.', 'Mrs.');
-- Lấy ra khách hàng đến từ các thành phố: Berlin, London, Warszawa
SELECT * FROM Customers WHERE City IN ('Berlin', 'London', 'Warszawa');
				-- IS NULL, IS NOT NULL --
-- Lấy ra tất cả đơn hàng chưa được giao 
SELECT * FROM Orders WHERE ShippedDate IS NULL;
SELECT COUNT(*) FROM Orders WHERE ShippedDate IS NULL;
-- Lấy ra ds khách hàng có khu vực không bị NULL
SELECT * FROM Customers WHERE Region IS NOT NULL;
-- Lấy ds khách hàng không có tên công ty
SELECT * FROM Customers WHERE CompanyName IS NULL;
-- Lấy ra tất cả đơn hàng chưa được giao và có khu vực giao hàng không bị NULL
SELECT * FROM Orders WHERE ShippedDate IS NULL AND ShipRegion IS NOT NULL;
				-- GROUP BY --
-- Cho biết mỗi khách hàng đã đặt bao nhiêu đơn hàng
SELECT CustomerID, COUNT(OrderID) AS "SỐ ĐƠN HÀNG" FROM Orders GROUP BY CustomerID;
-- Tính đơn giá trung bình theo mỗi nhà cung cấp sản phẩm
SELECT SupplierID, AVG(UnitPrice) AS "GIÁ TRUNG BÌNH" FROM Products GROUP BY SupplierID;
-- Mỗi thể loại có bao nhiêu sản phẩm trong kho
SELECT CategoryID, SUM(UnitsInStock) AS "TỔNG SẢN PHẨM" FROM Products GROUP BY CategoryID;
-- Cho biết giá vận chuyển thấp nhất và lớn nhất của các đơn hàng theo từng thành phố và các quốc gia khác nhau
SELECT ShipCountry, ShipCity, MIN(Freight) AS "GIÁ VẬN CHUYỂN THẤP NHẤT", MAX(Freight) AS "GIÁ VẬN CHUYỂN CAO NHẤT"
FROM Orders GROUP BY ShipCountry, ShipCity
ORDER BY ShipCountry, ShipCity;
-- Thống kê số lượng nhân viên theo từng quốc gia khác nhau
SELECT Country, COUNT(EmployeeID) AS "SỐ LƯỢNG NHÂN VIÊN" FROM Employees GROUP BY Country;
				-- DAY, MONTH, YEAR --
-- Tính số đơn đặt hàng năm 1997 của từng khách hàng
SELECT CustomerID, COUNT(OrderID) AS "TỔNG SỐ LƯỢNG" FROM Orders 
WHERE YEAR(OrderDate) = 1997
GROUP BY CustomerID;
-- Lọc ra các đơn hàng được đặt hàng vào tháng 5 năm 1997
SELECT * FROM Orders 
WHERE MONTH(OrderDate) = 5 AND YEAR(OrderDate) = 1997;
-- Lấy ds các đơn hàng đặt ngày 4/9/1996
SELECT * FROM Orders
WHERE DAY(OrderDate) = 4 AND MONTH(OrderDate) = 9 AND YEAR(OrderDate) = 1996;
SELECT * FROM Orders
WHERE OrderDate = '1996-09-04';
-- Lấy ds khách hàng đặt hàng trong năm 1998 và số đơn hàng mỗi tháng, sắp xếp tháng tăng dần
SELECT CustomerID, MONTH(OrderDate) AS "MONTH", COUNT(OrderID) AS "SỐ ĐƠN HÀNG"
FROM Orders
WHERE YEAR(OrderDate) = 1998
GROUP BY CustomerID, MONTH(OrderDate)
ORDER BY MONTH(OrderDate) ASC;
-- Lọc các đơn hàng đã được giao vào tháng 5, sắp xếp tăng dần theo năm
SELECT *
FROM Orders
WHERE MONTH(ShippedDate) = 5
ORDER BY YEAR(ShippedDate) ASC;
				-- HAVING --
-- Cho biết các khách hàng đã đặt nhiều hơn 20 đơn hàng, sắp xếp theo tổng số đơn hàng giảm dần
SELECT CustomerID, COUNT(OrderID) AS "SỐ LƯỢNG ĐƠN"
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 20
ORDER BY COUNT(OrderID) DESC;
-- Lọc những nhà cung cấp có tổng số lượng hàng trong kho lớn hơn 30 và có trung bình đơn giá có giá trị dưới 50
SELECT SupplierID, SUM(UnitsInStock) AS "TOTAL IN STOCK", AVG(UnitPrice) AS "AVG PRICE" FROM Products
GROUP BY SupplierID
HAVING SUM(UnitsInStock) > 30 AND AVG(UnitPrice) < 50;
-- Cho biết tổng số tiền vận chuyển của từng tháng trong nửa năm sau 1996, sắp xếp tháng tăng dần, tổng tiền vc > 1000
SELECT MONTH(ShippedDate) "MONTH", SUM(Freight) "TONG TIEN" FROM Orders
WHERE ShippedDate BETWEEN '1996-07-01' AND '1996-12-31'
GROUP BY MONTH(ShippedDate)
HAVING SUM(Freight) > 1000
ORDER BY MONTH(ShippedDate);
-- Lọc ra những thành phố có số lượng đơn hàng > 16 và sắp xếp theo tổng số lượng giảm dần
SELECT ShipCity, COUNT(OrderID) "TONG SO LUONG" FROM Orders
GROUP BY ShipCity
HAVING COUNT(OrderID) > 16
ORDER BY COUNT(OrderID) DESC;
				-- ONTAP --
-- Cho biết những kh đặt nhiều hơn 20 đơn hàng, sx theo tổng số đơn hàng giảm dần
SELECT CustomerID, COUNT(OrderID) AS "Tong So" FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 20
ORDER BY COUNT(OrderID) DESC;
-- Lọc ra các nhân viên có tổng số đơn hàng lớn hơn hoặc bằng 100, sx theo số đơn hàng giảm dần
SELECT EmployeeID, COUNT(OrderID) "TONG SO" FROM Orders
GROUP BY EmployeeID
HAVING COUNT(OrderID) >= 100
ORDER BY COUNT(OrderID) DESC;
-- Cho biết những thế loại nào có số sp khác nhau lớn hơn 11
SELECT CategoryID, COUNT(ProductID) AS "SO LUONG SP" FROM Products
GROUP BY CategoryID
HAVING COUNT(ProductID) > 11;
-- Cho biết những thể loại nào có tổng số lượng sp trong kho lớn hơn 350
SELECT CategoryID, SUM(UnitsInStock) AS "SO LUONG TRONG KHO" FROM Products
GROUP BY CategoryID
HAVING SUM(UnitsInStock) > 350;
-- Cho biết những quốc gia có nhiều hơn 7 đơn hàng
SELECT ShipCountry, COUNT(OrderID) "SO LUONG KHACH HANG" FROM Orders
GROUP BY ShipCountry
HAVING COUNT(OrderID) > 7;
-- Cho biết những ngày có nhiều hơn 5 đơn hàng được giao sắp xếp tăng dần theo ngày giao hàng
SELECT ShippedDate, COUNT(OrderID) AS "SỐ ĐƠN GIAO" FROM Orders
GROUP BY ShippedDate
HAVING COUNT(OrderID) > 5
ORDER BY ShippedDate;
-- Cho biết những quốc gia bắt đầu bằng A hoặc G, có số lượng đơn hàng > 29
SELECT ShipCountry, COUNT(OrderID) AS "SO LUONG DON" FROM Orders
WHERE ShipCountry LIKE '[A,G]%'
GROUP BY ShipCountry
HAVING COUNT(OrderID) > 29
ORDER BY COUNT(OrderID) DESC;
-- Cho biết những thành phố có số lượng đơn hàng được giao khác 1 và 2, ngày đặt hàng từ 1/4/1997 - 31/8/1997
SELECT ShipCity, COUNT(OrderID) FROM Orders
WHERE OrderDate BETWEEN '1997-04-01' AND '1997-08-31'
GROUP BY ShipCity
HAVING COUNT(OrderID) NOT IN (1, 2);
				-- Truy vấn từ nhiều bảng, kết nối thông qua các khóa chính - khóa ngoại --
-- Từ bảng products và categories hãy in ra các thông tin sau: mã thể loại, tên thể loại, mã sp, tên sp
SELECT  c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Products AS p, Categories AS c
WHERE c.CategoryID = p.CategoryID;
-- Từ employee và order, in ra mã nv, tên nv, số đơn hàng nv đó đã bán được
SELECT o.EmployeeID,e.FirstName, e.LastName ,COUNT(o.OrderID) AS "SO LUONG DON HANG"
FROM Orders o, Employees e
WHERE o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID,e.FirstName, e.LastName;
-- Từ bảng customer và order, in ra mã kh, tên cty, tên liên hệ, số đơn đã mua, với đk quốc gia là UK
SELECT o.CustomerID, c.CompanyName, c.ContactName ,COUNT(o.OrderID) AS "SO DON DA MUA"
FROM Customers c, Orders o
WHERE c.CustomerID = o.CustomerID
GROUP BY o.CustomerID, c.CompanyName, c.ContactName
-- Từ bảng order và shipper, in ra mã nhà vận chuyển, tên cty vận chuyển, tổng số tiền vận chuyển, in ra theo thứ tự tổng tiền vc tăng dần
SELECT s.ShipperID, s.CompanyName, SUM(o.Freight) AS "TONG TIEN"
FROM Orders o, Shippers s
WHERE o.ShipVia = s.ShipperID
GROUP BY s.ShipperID, s.CompanyName
ORDER BY SUM(o.Freight) DESC
-- Từ bảng product và suppliers in ra mã ncc, tên cty, tổng số các sp khác nhau đã cc, in ra duy nhất 1 ncc có số sp khác nhau nhiều nhất
SELECT TOP 1 s.SupplierID, s.CompanyName, COUNT(p.ProductID) "SO SP KHAC NHAU"
FROM Products p, Suppliers s
WHERE p.SupplierID = s.SupplierID
GROUP BY s.SupplierID, s.CompanyName
ORDER BY COUNT(p.ProductID) DESC
-- Từ order và order detail, in ra mã đơn hàng và tổng số tiền sp của đh đó
SELECT o.OrderID, SUM(od.UnitPrice * od.Quantity) AS "TONG SO TIEN"
FROM Orders o, [Order Details] od
WHERE o.OrderID = od.OrderID
GROUP BY o.OrderID
-- Từ 3 bảng order, order detail, employee in ra mã đh, tên nv, tổng tiền sp của đơn hàng
SELECT o.OrderID, e.FirstName, e.LastName, SUM(od.UnitPrice * od.Quantity) AS "TONG TIEN"
FROM Orders o, [Order Details] od, Employees e
WHERE o.EmployeeID = e.EmployeeID AND o.OrderID = od.OrderID 
GROUP BY o.OrderID, e.FirstName, e.LastName
-- Từ 3 bảng order, customer, shipper, in ra mã dh, tên kh, tên cty vận chuyển, chỉ in ra các đơn giao đến UK năm 1997
SELECT o.OrderID, c.ContactName, s.CompanyName, YEAR(o.ShippedDate), o.ShipCountry
FROM Orders o, Customers c, Shippers s
WHERE o.CustomerID = c.CustomerID AND o.ShipVia = s.ShipperID AND o.ShipCountry = 'UK' AND YEAR(o.ShippedDate) = 1997 
-- Từ products, supplier và categories tìm các sp thuộc danh mục Seafood in ra mã tl, tên tl, mã sp, tên sp
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Products p, Categories c
WHERE c.CategoryID = p.CategoryID AND c.CategoryName = 'Seafood';
-- Từ product và supplier, tìm các sp được cung cấp từ Đức, in ra mã ncc, quốc gia, mã sp, tên sp
SELECT s.SupplierID, s.Country, p.ProductID, p.ProductName 
FROM Products p, Suppliers s
WHERE p.SupplierID = s.SupplierID AND s.Country = 'Germany'
-- Từ customer, Order và Shippers hãy in ra mã đơn hàng, tên kh, tên cty vận chuyển, chỉ in ra các đơn đến từ London
SELECT o.OrderID, c.ContactName, s.CompanyName 
FROM Customers c, Orders o, Shippers s
WHERE c.CustomerID = o.CustomerID AND o.ShipVia = s.ShipperID AND c.City = 'London';
-- Từ 3 bảng trên lấy ra mã đh, tên kh, tên cty vận chuyển, ngày yêu cầu chuyển hàng và ngày giao hàng chỉ in ra các đơn giao muộn
SELECT o.OrderID, c.ContactName, s.CompanyName , o.RequiredDate, o.ShippedDate
FROM Customers c, Orders o, Shippers s
WHERE c.CustomerID = o.CustomerID AND s.ShipperID = o.ShipVia AND o.ShippedDate > o.RequiredDate;
-- Từ 3 bảng trên, lấy những shipcountry mà kh không đến từ Mỹ, chọn những country lớn hơn 100 đơn, hiển thị shipcountry và số đơn hàng
SELECT o.ShipCountry, COUNT(o.OrderID) AS "TỔNG ĐƠN"
FROM Customers c, Orders o, Shippers s
WHERE c.CustomerID = o.CustomerID AND o.ShipVia = s.ShipperID AND c.Country <> 'USA'
GROUP BY o.ShipCountry
HAVING COUNT(o.OrderID) > 100;
				-- UNION --
-- 1 Liệt kê tất cả mã đơn hàng có giá nằm trong phạm vi từ 100 - 200: 22 rows
SELECT OrderID
FROM [Order Details]
WHERE UnitPrice BETWEEN 100 AND 200;
-- 2 Liệt kê tất cả đơn hàng có Quantity = 10 or 20: 433 rows
SELECT OrderID
FROM [Order Details]
WHERE Quantity IN (10, 20);
-- 3: 1 AND 2 Liệt kê tất cả đơn hàng có giá nằm trong phạm vi từ 100 - 200 VÀ Quantity = 10 or 20: 7 rows 
SELECT OrderID
FROM [Order Details]
WHERE (UnitPrice BETWEEN 100 AND 200) AND (Quantity IN (10, 20));
-- 4: 1 OR 2 Liệt kê tất cả đơn hàng có giá nằm trong phạm vi từ 100 - 200 HOẶC Quantity = 10 or 20: 448 rows
SELECT OrderID
FROM [Order Details]
WHERE (UnitPrice BETWEEN 100 AND 200) OR (Quantity IN (10, 20));
-- 5: 4 + DISTINCT 1 OR 2 Liệt kê tất cả đơn hàng có giá nằm trong phạm vi từ 100 - 200 HOẶC Quantity = 10 or 20 có sử dụng DISTINCT: 360 rows
SELECT DISTINCT OrderID
FROM [Order Details]
WHERE (UnitPrice BETWEEN 100 AND 200) OR (Quantity IN (10, 20));
-- 5: UNION (1 or 2) 360 rows
SELECT OrderID FROM [Order Details] WHERE UnitPrice BETWEEN 100 AND 200
UNION 
SELECT OrderID FROM [Order Details] WHERE Quantity IN (10, 20);
-- 4: UNION ALL 455 (448 + 7)
SELECT OrderID FROM [Order Details] WHERE UnitPrice BETWEEN 100 AND 200
UNION ALL
SELECT OrderID FROM [Order Details] WHERE Quantity IN (10, 20);
-- Liệt kê toàn bộ các tp và quốc gia tồn tại trong customers và supplier với 2 tình huống UNION và UNION ALL
SELECT Country FROM Customers 
UNION 
SELECT Country FROM Suppliers

SELECT Country FROM Customers 
UNION ALL
SELECT Country FROM Suppliers
-- Liệt kê thành phố, quốc gia có KH thuộc Countrys bắt đầu bằng U hoặc City = London hoặc ShipCountry= USA
SELECT City, Country FROM Customers WHERE Country LIKE 'U%'
UNION
SELECT City, Country FROM Suppliers WHERE City = 'London'
UNION
SELECT ShipCity, ShipCountry FROM Orders WHERE ShipCountry = 'USA';
				-- JOIN --
-- Từ product và categories, in ra các thông tin sau: mã tl, tên tl, mã sp, tên sp
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Categories c JOIN Products p ON c.CategoryID = p.CategoryID
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Categories c LEFT JOIN Products p ON c.CategoryID = p.CategoryID
-- Từ product và categories, in ra các thông tin sau: mã tl, tên tl, số lượng sp
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS "SO LUONG SP"
FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.CategoryName
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS "SO LUONG SP"
FROM Categories c LEFT JOIN Products p ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.CategoryName
-- In ra mã đh và tên cty khách hàng
SELECT o.OrderID, c.CompanyName
FROM Orders o RIGHT JOIN Customers c ON o.CustomerID = c.CustomerID
SELECT c.CompanyName, COUNT(o.OrderID)
FROM Orders o RIGHT JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
-- In ra mã tl, tên tl, mã sp, tên sp
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Categories c FULL JOIN Products p ON c.CategoryID = p.CategoryID
-- Liệt kê tên nhân viên và tên khách hàng của các đơn hàng trong bảng order
SELECT e.LastName, c.ContactName, o.OrderID
FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID JOIN Customers c ON o.CustomerID = c.CustomerID;
-- Liệt kê các ncc và tên sp của các sp trong bảng product, gồm cả các sp ko có ncc
SELECT s.CompanyName, p.ProductName
FROM Suppliers s RIGHT JOIN Products p ON s.SupplierID = p.SupplierID;
-- Liệt kê tên kh và tên đơn hàng của các đh trong bảng order, gồm cả các kh ko có đơn hàng
SELECT c.ContactName, o.OrderID
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;
-- Liệt kê tên danh mục và tên ncc của các sp trong product, gồm cả các danh mục và ncc ko có sản phẩm
SELECT c.CategoryName, s.CompanyName, p.ProductName
FROM Categories c FULL JOIN Products p ON c.CategoryID = p.CategoryID FULL JOIN Suppliers s ON s.SupplierID = p.SupplierID
-- BT1 Liệt kê tên sp và tên ncc sp của các sp đã đc đặt hàng trong bảng order detail
SELECT DISTINCT od.ProductID, p.ProductName, s.CompanyName
FROM [Order Details] od JOIN Products p ON od.ProductID = p.ProductID JOIN Suppliers s ON p.SupplierID = s.SupplierID
-- BT2 Liệt kê tên kh và tên nv phụ trách của các đh trong bảng orders gồm cả các đơn hàng ko có nv phụ trách
SELECT o.OrderID, e.FirstName, e.LastName, c.ContactName
FROM Orders o LEFT JOIN Employees e ON o.EmployeeID = e.EmployeeID LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
-- BT3 RIGHT JOIN
SELECT o.OrderID, e.FirstName, e.LastName, c.ContactName
FROM Orders o RIGHT JOIN Employees e ON o.EmployeeID = e.EmployeeID RIGHT JOIN Customers c ON o.CustomerID = c.CustomerID
-- BT4 Full join: liệt kê tên danh mục và tên ncc của các sp trong bảng product gồm cả các danh mục và ncc ko có sản phẩm
SELECT c.CategoryName, s.CompanyName, p.ProductName
FROM Categories c FULL JOIN Products p ON c.CategoryID = p.CategoryID FULL JOIN Suppliers s ON p.SupplierID = s.SupplierID
-- BT5: Lấy ra tên kh và tên sp đã được đặt hàng
SELECT od.OrderID, c.ContactName, p.ProductName
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Customers c ON o.CustomerID = c.CustomerID 
JOIN Products p ON od.ProductID = p.ProductID
-- BT6: Lấy ra tên nv và tên kh của các đh trong gồm cả đh ko có nv hoặc kh tương ứng
SELECT o.OrderID, e.FirstName, e.LastName, c.ContactName
FROM Orders o FULL JOIN Employees e ON o.EmployeeID = e.EmployeeID FULL JOIN Customers c ON o.CustomerID = c.CustomerID
				-- SUB QUERY --
-- Liệt kê toàn bộ sản phẩm
SELECT ProductID, ProductName, UnitPrice FROM dbo.Products;
-- Tìm giá trung bình của các sản phẩm
SELECT AVG(UnitPrice) FROM dbo.Products;
-- Lọc những sản phẩm có giá lớn hơn giá trung bình
SELECT ProductID, ProductName, UnitPrice FROM dbo.Products 
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM dbo.Products);
-- Lọc những khách hàng có số đơn hàng > 10 JOIN GROUP BY HAVING
SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS "Total Orders"
FROM dbo.Customers c
LEFT JOIN dbo.Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID)> 10;
SELECT * FROM Customers WHERE CustomerID IN (
SELECT CustomerID FROM Orders 
GROUP BY CustomerID
HAVING COUNT(OrderID) > 10)
-- In ra ma đh và tổng tiền của đh đó
SELECT o.OrderID, (
SELECT SUM(Quantity * UnitPrice)
FROM [Order Details] od
WHERE od.OrderID = o.OrderID) AS "TOTAL PRICE"
FROM Orders o
-- Loc ra tên sp và tong so don hang của sp
SELECT p.ProductName, COUNT(od.OrderID) AS "TOTAL ORDER"
FROM Products p LEFT JOIN [Order Details] od ON p.ProductID = od.ProductID LEFT JOIN Orders o ON od.OrderID = o.OrderID
WHERE p.ProductID = od.ProductID
GROUP BY p.ProductName
-- In ra mã đh và tổng số lượng sp của đh đó
SELECT o.OrderID, SUM(od.Quantity)
FROM Orders o LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderID = od.OrderID
GROUP BY o.OrderID