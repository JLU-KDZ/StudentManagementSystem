
-- 创建序列
CREATE SEQUENCE major_id_seq START WITH 1 INCREMENT BY 1 NOCACHE;


--创建major表
CREATE TABLE major
(
    id          NUMBER(10) PRIMARY KEY,
    NAME        VARCHAR2(200) not null unique,
    dept2_id    number,
    create_by   VARCHAR2(50)  NOT NULL,
    create_time DATE          NOT NULL,
    update_by   VARCHAR2(50)  NOT NULL,
    update_time DATE          NOT NULL
);


-- 创建触发器
CREATE OR REPLACE TRIGGER major_id_trigger
    BEFORE INSERT
    ON major
    FOR EACH ROW
    WHEN (NEW.id IS NULL)
BEGIN
    SELECT major_id_seq.NEXTVAL INTO :NEW.id FROM dual;
END;
/


-- 为列添加注释
COMMENT ON COLUMN major.id IS 'ID';
COMMENT ON COLUMN major.name IS '专业名';
COMMENT ON COLUMN major.dept2_id IS '关联学院';
COMMENT ON COLUMN dept2.create_by IS '创建者';
COMMENT ON COLUMN dept2.create_time IS '创建时间';
COMMENT ON COLUMN dept2.update_by IS '更新者';
COMMENT ON COLUMN dept2.update_time IS '更新时间';
COMMENT ON TABLE major IS '专业表';


INSERT ALL
    INTO major (name, dept2_id, create_by, create_time, update_by,
                update_time)
VALUES ('计算机科学与技术', 1, USER, SYSDATE, USER, SYSDATE)
INTO major (name, dept2_id, create_by, create_time, update_by,
            update_time)
VALUES ('软件工程', 1,  USER, SYSDATE, USER, SYSDATE)
INTO major (name, dept2_id, create_by, create_time, update_by,
            update_time)
VALUES ('会计学', 2, USER, SYSDATE, USER, SYSDATE)
INTO major (name, dept2_id, create_by, create_time, update_by,
            update_time)
VALUES ('统计学', 3,  USER, SYSDATE, USER, SYSDATE)
SELECT *
FROM dual;