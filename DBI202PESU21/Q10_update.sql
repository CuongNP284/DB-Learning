--update quantity = 30 all products of category 'Cruisers Bicycles'
--in the store with store_id = 1
UPDATE stocks
set quantity = 30
where store_id = 1 and product_id in
(select s.product_id from stocks s full join products p on s.product_id = p.product_id
where p.category_name = 'Cruisers Bicycles' and s.store_id = 1)
