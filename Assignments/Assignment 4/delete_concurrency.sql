begin;
    delete from dish_category
    where cat_name='Starter';

    select * from dish_category;

commit;