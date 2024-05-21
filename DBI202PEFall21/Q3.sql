select p.ProductID, p.Name, p.Color, p.SubcategoryID, ps.Name, ps.Category, py.StartDate, py.EndDate, sum(py.Cost) as [HistoryCost]
from Product p full join ProductCostHistory py
on p.ProductID = py.ProductID
full join ProductSubcategory ps
on p.SubcategoryID = ps.SubcategoryID
group by  p.ProductID, p.Name, p.Color, p.SubcategoryID, ps.Name, ps.Category, py.StartDate, py.EndDate
having p.Color = 'Black'
and p.Name like 'HL%'