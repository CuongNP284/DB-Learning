delete from tblInvoices where invid = (
select invid from tblInvoices where customer = N'Lê Minh phương')

select * from tblInvoices