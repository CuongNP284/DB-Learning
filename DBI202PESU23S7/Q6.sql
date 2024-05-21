select d.invid, sum(d.price * d.quantity) as [Total amount] from tblInvoices i join tblInv_Detail d on i.invid = d.invid
group by d.invid
having sum(d.price * d.quantity) >= ALL
(select sum(d.price * d.quantity) as [Total amount] from tblInvoices i join tblInv_Detail d on i.invid = d.invid
group by d.invid)