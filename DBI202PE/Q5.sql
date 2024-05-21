select pm.ModelID, pm.Name as ModelName, count(p.ModelID) as NumberOfProducts from ProductModel pm left join Product p 
on pm.ModelID = p.ModelID
where pm.Name like 'Mountain%' or pm.Name like 'ML Mountain%'
group by pm.Name , pm.ModelID
order by NumberOfProducts desc, pm.Name asc
