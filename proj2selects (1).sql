-- Shows prodparts price for each product
use products;
select product.prod_id, prod_name, prodparts.price
from product
join prodparts on product.prod_id = prodparts.prod_id;
    
-- Shows employees that work for a vendor    
use vendors;
select company_name, ename, employee_contact
from company
join salesperson on company.vcid = salesperson.vcid;

-- Shows address of vendors that have certain parts and their prices
use parts;
select company.address, part_name, price
from vendors.company
join vendorpart on company.vcid = vendorpart.vcid;

-- Shows which vendor parts go to which product and product price
use parts;
select part_name, product.prod_name, product.price
from products.product
join vendorpart on product.bike_type = vendorpart.bike_type