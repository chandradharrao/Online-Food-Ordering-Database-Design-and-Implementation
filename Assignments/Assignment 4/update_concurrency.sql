-- Locking done row wise in postgres
-- Hence an update stateemnt blocks another update,delete only if it targets the same row

-- cust_id,restaurant_id,order_id
-- 1,4,2

begin;

    update review
        set stars=5
    where cust_id=1 and restaurant_id=4 and order_id=2;

select c.first_name,ra.name,r.stars
from customer c,Restaurant_admin ra,review r where c.cust_id=r.cust_id and r.restaurant_id=ra.id;

commit;