
CREATE SEQUENCE class_id_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
CREATE TABLE class (
                       id NUMBER PRIMARY KEY,
                       name VARCHAR2(50) NOT NULL UNIQUE,
                       dept2_id NUMBER,
                       create_by  VARCHAR2(50) NOT NULL ,
                       create_time DATE NOT NULL,
                       update_by  VARCHAR2(50) NOT NULL ,
                       update_time DATE NOT NULL
);
CREATE OR REPLACE TRIGGER class_id_trigger
    BEFORE INSERT ON class
    FOR EACH ROW
BEGIN
    SELECT class_id_seq.NEXTVAL INTO :new.id FROM dual;
END;
/

COMMENT ON COLUMN class.id IS '主键ID';
COMMENT ON COLUMN class.name IS '班级名称';
COMMENT ON COLUMN class.dept2_id IS '所属学院';
COMMENT ON COLUMN class.create_by IS '创建者';
COMMENT ON COLUMN class.create_time IS '创建时间';
COMMENT ON COLUMN class.update_by IS '更新者';
COMMENT ON COLUMN class.update_time IS '更新时间';
COMMENT ON TABLE class IS '班级表';

INSERT ALL
    INTO class (  name,dept2_id, create_by,create_time, update_by,update_time) VALUES ( '大数据1班',1, USER,SYSDATE,USER, SYSDATE)
INTO class (  name,dept2_id,  create_by,create_time,update_by, update_time) VALUES ( '计科1班',1, USER,SYSDATE,USER, SYSDATE)
INTO class (  name,dept2_id,  create_by,create_time, update_by,update_time) VALUES ( '统计1班',3,USER,SYSDATE,USER, SYSDATE)
INTO class (  name,dept2_id,  create_by,create_time, update_by,update_time) VALUES ( '会计1班', 2,USER,SYSDATE,USER, SYSDATE)
INTO class (  name, dept2_id, create_by,create_time,update_by, update_time) VALUES ( '大数据2班',1, USER,SYSDATE,USER, SYSDATE)
SELECT * FROM dual;