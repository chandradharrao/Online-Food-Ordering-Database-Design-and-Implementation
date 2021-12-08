select total_amount,status,order_id
from (
    order_details inner join customer
    on order_details.cust_id=customer.cust_id
) 
where customer.last_name='dhoni' and customer.first_name='ms';
