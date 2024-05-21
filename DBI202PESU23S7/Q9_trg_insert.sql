create trigger tr1 on tblInv_Detail
after insert
as
begin
	select i.invid, sum(i.quantity * i.price) from inserted i group by i.invid
end

insert into tblInv_Detail values('000003', 'RTPL02', 1, 10000000)

select d.invid, sum(d.quantity * d.price) from tblInv_Detail d group by d.invid
having d.invid = '000003'


