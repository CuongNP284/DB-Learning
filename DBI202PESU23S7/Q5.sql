select i.employeeid, count(i.employeeid) as [Total Number] from tblInvoices i
group by i.employeeid