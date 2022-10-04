-- Exercício SQL Server --
select top 3 * from sales.orders
select top 3 * from sales.customers
select top 3 * from HR.Employees
select top 3 * from sales.shippers
-------------------------------------------
--   1. Retornar os apelidos n�mero do pedido (orderid), data do pedido (orderdate), nome do contato (contactname) e o pa�s (country).

select ped.orderid, ped.orderdate, cli.contactname, cli.country
from		sales.orders		as	ped
inner join	sales.customers		as	cli
on			cli.custid = ped.custid

--   2. Retornar os apelidos data do pedido (orderdate), nome do contato (contactname), nome completo
-- do empregado (firstname/lastname) e pa�s do empregado (country), onde o pa�s do empregado
-- seja Inglaterra.

select ped.orderdate, cli.contactname, emp.firstname, emp.lastname, emp.country
from		sales.orders	as ped
inner join	sales.customers as cli
on			cli.custid = ped.custid
inner join	hr.employees	as emp
on			ped.empid  = emp.empid
where		emp.country = 'UK'

--   3.Retornar os apelidos n�mero do pedido (orderid), data do pedido (orderdate), nome do contato do
-- cliente (contactname), nome completo do empregado (firstname/lastname) e pa�s do cliente
-- (country), onde o pa�s do cliente seja Brasil, ordernado pela data do pedido mais recente.

select ped.orderid, ped.orderdate, cli.contactname, emp.firstname, emp.lastname,
cli.country
from		sales.orders		as ped
inner join	sales.customers		as cli
on			cli.custid = ped.custid
inner join	hr.employees		as emp
on			ped.empid = emp.empid
where		cli.country = 'Brazil'
order by	orderdate

--   4. Retornar os apelidos n�mero do pedido (orderid), data do pedido (orderdate), nome do contato
-- (contactname), nome completo do empregado (firstname/lastname), pa�s do empregado (country)
-- e nome da empresa de entrega, onde o pa�s do empregado seja Estados Unidos e a empresa de
-- entrega seja Shipper ETYNR ou Shipper GVSUA. Ordene pelo n�mero do pedido.

select ped.orderid, ped.orderdate, cli.contactname, emp.firstname, emp.lastname, emp.country,
empresa.companyname
from		sales.orders		as ped
inner join	sales.customers		as cli
on			ped.custid = cli.custid
inner join	hr.employees		as emp
on			ped.empid = emp.empid
inner join	sales.shippers		as empresa
on			ped.shipperid = empresa.shipperid
where		emp.country = 'USA' and empresa.companyname = 'Shipper ETYNR' or emp.country = 'USA' and empresa.companyname = 'Shipper GVSUA'
order by	ped.orderid
----------------------------------------
select top 3 * from sales.orderdetails
select top 3 * from production.products
select top 3 * from production.suppliers
select top 3 * from production.categories
-----------------------------------------
--   5. Retorne todas informa��es de nome do produto e o nome da categoria, onde esta seja Beverages e
-- o pre�o do produto (unitprice) seja menor que 30, ordenado pelo pre�o de forma descendente.

select prod.productname, cat.categoryname, prod.unitprice
from		production.products		as prod
inner join	production.categories	as cat
on			prod.categoryid = cat.categoryid
where		cat.categoryname = 'Beverages' and unitprice<30
order by	prod.unitprice desc

--   6. Retorne os apelidos, nome do produto (productname), nome da empresa de entrega
-- (companyname) e a quantidade do produto (qty), quando essa ultrapassar 100 unidades. Ordene
-- pelo nome do produto ascendente e quantidade de forma descendente.

select prod.productname, comp.companyname, dets.qty
from		production.products		as prod
inner join	production.suppliers	as comp
on			prod.supplierid = comp.supplierid
inner join	sales.orderdetails		as dets
on			prod.productid = dets.productid
where		dets.qty>100
order by	prod.productname asc, dets.qty desc

--   7. Retorne os apelidos, nome do contato do cliente (contactname), nome do produto (productname),
-- quantidade do produto (qty), data do pedido (orderdate) e cidade do fornecedor (city), onde a
-- data do pedido seja todo o m�s de julho de 2006, a quantidade de produtos seja maior ou igual a
-- 20 e menor que 60, o nome do produto inicie por Product A ou Product G, o nome da cidade do
-- fornecedor seja Stockholm, Sydney, Sandvika ou Ravenna. Ordene pelo n�mero do empregado
-- (empid) de forma descendente 

select cli.contactname, prod.productname, dets.qty, ped.orderdate, sup.city, emp.empid 
from		sales.customers		 as cli
inner join	sales.orders		 as ped
on			cli.custid = ped.custid
inner join	sales.orderdetails	 as dets
on			ped.orderid = dets.orderid
inner join	production.products  as prod
on			dets.productid = prod.productid
inner join	production.suppliers as sup
on			prod.supplierid = sup.supplierid
inner join  hr.employees		 as emp
on			emp.empid = ped.empid
where		(ped.orderdate between '2006-07-01' and '2006-07-31') and
			(dets.qty between 20 and 60) and 
			(prod.productname like '%product a%' or prod.productname like '%product g%') and
			(sup.city = 'Stockholm' or sup.city = 'Sydney' or sup.city = 'Sandvika' or sup.city = 'Ravenna')
			order by emp.empid desc


