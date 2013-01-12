
--需要替换两处表名
update sys_sequence s set s.cur_value  = 
(select max(to_number(subid))+10  from A004)
            where s.seq_name = 'A004'