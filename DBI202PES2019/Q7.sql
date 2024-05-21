select * from
(
select top 5 * from Product
order by UnitPrice ASC
Union
select top 5 * from Product
order by UnitPrice DESC) as P1 order by UnitPrice DESC