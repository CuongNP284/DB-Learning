create trigger Tr2
on stocks
after delete
as
begin
	select d.product_id, p.product_name, d.store_id, s.store_name, d.quantity
	from deleted d full join stores s on d.store_id = s.store_id
	full join products p on d.product_id = p.product_id
	rollback transaction
end


delete from stocks
where store_id = 1 and product_id in (10,11,12)