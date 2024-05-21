select s.ID as SubCategoryID, s.SubCategoryName, count(p.ProductName) as [NumberOfProducts]
from SubCategory s full join Product p
on s.ID = p.SubCategoryID
group by s.ID, s.SubCategoryName
having count(p.ProductName) > 100
order by NumberOfProducts DESC