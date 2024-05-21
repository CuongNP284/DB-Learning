select py.ProductID, py.Price, py.StartDate, py.EndDate from ProductPriceHistory py
where Year(py.EndDate) = 2003 and py.Price < 100
order by py.Price DESC