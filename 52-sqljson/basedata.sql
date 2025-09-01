create table stores as select 
(json_object('manager' : mgr.first_name || ' ' || mgr.last_name,
                'address' : json_object('address': stoaddr.address, 'district': stoaddr.district, 'zip': stoaddr.postal_code),
                'staff' : json_arrayagg(
                        json_object('id' : staff.staff_id,
                                    'name': staff.first_name || ' ' || staff.last_name,
                                    'address': json_object('addr1' : staffaddr.address,
                                                           'addr2': staffaddr.address2,
                                                           'district': staffaddr.district,
                                                           'zip' : staffaddr.postal_code)
                                        )
                        ) returning jsonb))
from staff join store using (store_id)
    join address stoaddr on (store.address_id = stoaddr.address_id)
    join address staffaddr on (staff.address_id = staffaddr.address_id)
    join staff mgr on (store.manager_staff_id = mgr.staff_id)
group by store.store_id, mgr.staff_id, stoaddr.address_id;

create table allstores as select json_arrayagg(json_object returning jsonb) as alldata from stores;

