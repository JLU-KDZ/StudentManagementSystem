
CREATE SEQUENCE lookup_id_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE;


CREATE TABLE smm_lookup
(
    id number primary key ,
    type varchar2(20),
    value number,
    desp varchar2(50)

);

CREATE OR REPLACE TRIGGER lookup_id_trigger
    BEFORE INSERT ON smm_lookup
    FOR EACH ROW
BEGIN
    SELECT lookup_id_seq.NEXTVAL INTO :new.id FROM dual;
END;
/

insert into  smm_lookup(type, value, desp)  values ('gender', 1,'男');
insert into  smm_lookup(type, value, desp)  values ('gender', 2,'女');
insert into  smm_lookup(type, value, desp)  values ('gender', 0,'Unknow');
insert into  smm_lookup(type, value, desp)  values ('grade', 1,'大一');
insert into  smm_lookup(type, value, desp)  values ('grade',2, '大二');
insert into  smm_lookup(type, value, desp)  values ('grade',3, '大三');
insert into  smm_lookup(type, value, desp)  values ('grade',4, '大四');
insert into  smm_lookup(type, value, desp)  values ('time', 11,'周一第一大节');
insert into  smm_lookup(type, value, desp)  values ('time', 12,'周一第二大节');
insert into  smm_lookup(type, value, desp)  values ('time', 13,'周一第三大节');
insert into  smm_lookup(type, value, desp)  values ('time', 14,'周一第四大节');
insert into  smm_lookup(type, value, desp)  values ('time', 21,'周二第一大节');
insert into  smm_lookup(type, value, desp)  values ('time', 22,'周二第二大节');
insert into  smm_lookup(type, value, desp)  values ('time', 23,'周二第三大节');
insert into  smm_lookup(type, value, desp)  values ('time', 24,'周二第四大节');
insert into  smm_lookup(type, value, desp)  values ('time', 31,'周三第一大节');
insert into  smm_lookup(type, value, desp)  values ('time', 32,'周三第二大节');
insert into  smm_lookup(type, value, desp)  values ('time', 33,'周三第三大节');
insert into  smm_lookup(type, value, desp)  values ('time', 34,'周三第四大节');
insert into  smm_lookup(type, value, desp)  values ('time', 41,'周四第一大节');
insert into  smm_lookup(type, value, desp)  values ('time', 42,'周四第二大节');
insert into  smm_lookup(type, value, desp)  values ('time', 43,'周四第三大节');
insert into  smm_lookup(type, value, desp)  values ('time', 44,'周四第四大节');
insert into  smm_lookup(type, value, desp)  values ('time', 51,'周五第一大节');
insert into  smm_lookup(type, value, desp)  values ('time', 52,'周五第二大节');
insert into  smm_lookup(type, value, desp)  values ('time', 53,'周五第三大节');
insert into  smm_lookup(type, value, desp)  values ('time', 54,'周五第四大节');
insert into  smm_lookup(type, value, desp)  values ('location', 1,'3A101');
insert into  smm_lookup(type, value, desp)  values ('location', 2,'3A102');
insert into  smm_lookup(type, value, desp)  values ('location', 3,'3A103');
insert into  smm_lookup(type, value, desp)  values ('location', 1,'3B101');
insert into  smm_lookup(type, value, desp)  values ('location', 2,'3B102');
insert into  smm_lookup(type, value, desp)  values ('location', 3,'3B103');
insert into  smm_lookup(type, value, desp)  values ('office', 1,'A201');
insert into  smm_lookup(type, value, desp)  values ('office', 2,'A202');
insert into  smm_lookup(type, value, desp)  values ('office', 3,'A203');
insert into  smm_lookup(type, value, desp)  values ('office', 1,'B201');
insert into  smm_lookup(type, value, desp)  values ('office', 2,'B202');
insert into  smm_lookup(type, value, desp)  values ('office', 3,'B203');

