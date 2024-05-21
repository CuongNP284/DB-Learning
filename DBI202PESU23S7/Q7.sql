select i.invid, i.invdate, d.proid, d.quantity, d.price from tblInvoices i join tblInv_Detail d on i.invid = d.invid
where i.employeeid = 'S003'