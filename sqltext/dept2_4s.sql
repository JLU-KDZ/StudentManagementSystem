
CREATE SEQUENCE dept2_id_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
CREATE TABLE dept2 (
                      id NUMBER PRIMARY KEY,
                      name VARCHAR2(50) NOT NULL UNIQUE,
                      create_by  VARCHAR2(50) NOT NULL ,
                      create_time DATE NOT NULL,
                      update_by  VARCHAR2(50) NOT NULL ,
                      update_time DATE NOT NULL
);
CREATE OR REPLACE TRIGGER dept2_id_trigger
    BEFORE INSERT ON dept2
    FOR EACH ROW
BEGIN
    SELECT dept2_id_seq.NEXTVAL INTO :new.id FROM dual;
END;
/

COMMENT ON COLUMN dept2.id IS '主键ID';
COMMENT ON COLUMN dept2.name IS '学院名称';
COMMENT ON COLUMN dept2.create_by IS '创建者';
COMMENT ON COLUMN dept2.create_time IS '创建时间';
COMMENT ON COLUMN dept2.update_by IS '更新者';
COMMENT ON COLUMN dept2.update_time IS '更新时间';
COMMENT ON TABLE dept2 IS '学院表';

INSERT ALL
    INTO dept2 (  name, create_by,create_time, update_by,update_time) VALUES ( '管理与工程学院', USER,SYSDATE,USER, SYSDATE)
INTO dept2 (  name, create_by,create_time,update_by, update_time) VALUES ( '会计学院', USER,SYSDATE,USER, SYSDATE)
INTO dept2 (  name, create_by,create_time, update_by,update_time) VALUES ( '统计学院',USER,SYSDATE,USER, SYSDATE)
INTO dept2 (  name, create_by,create_time, update_by,update_time) VALUES ( '数据与科学学院', USER,SYSDATE,USER, SYSDATE)
INTO dept2 (  name, create_by,create_time,update_by, update_time) VALUES ( '国际经济与贸易学院', USER,SYSDATE,USER, SYSDATE)
SELECT * FROM dual;