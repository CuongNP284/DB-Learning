select p.proid, p.proname, s.supname from tblProducts p full join tblSuppliers s on p.supcode = s.supcode
where s.supname = N'Hoàn Vũ'