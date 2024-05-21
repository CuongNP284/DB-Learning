--Insert the following information:
--- A category named 'Sports' into table Category
--- A subcategory named 'Tennis' and a subcategory named 'Football' into table SubCategory, both these two subcategories are subcategories of Category 'Sports'


insert into Category (CategoryName) values('Sports')
insert into SubCategory (CategoryID, SubCategoryName) values
((select c.ID from Category c where c.CategoryName = 'Sport'),'Tennis'),
((select c.ID from Category c where c.CategoryName = 'Sport'),'Fooball')
