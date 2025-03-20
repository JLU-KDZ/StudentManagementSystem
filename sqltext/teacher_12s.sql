
-- 创建序列
CREATE SEQUENCE teacher_id_seq START WITH 1 INCREMENT BY 1 NOCACHE;


--创建teacher表
CREATE TABLE teacher
(
    id           NUMBER(10) PRIMARY KEY,
    username     VARCHAR2(200) not null unique,
    NAME         VARCHAR2(200) not null unique,
    gender       NUMBER,
    age          number,
    dept2_id     number,
    phone_number varchar2(11),
    email        varchar2(100),
    office       varchar2(100),
    create_by    VARCHAR2(50)  NOT NULL,
    create_time  DATE          NOT NULL,
    update_by    VARCHAR2(50)  NOT NULL,
    update_time  DATE          NOT NULL
);


-- 创建触发器
CREATE OR REPLACE TRIGGER teacher_id_trigger
    BEFORE INSERT
    ON teacher
    FOR EACH ROW
    WHEN (NEW.id IS NULL)
BEGIN
    SELECT teacher_id_seq.NEXTVAL INTO :NEW.id FROM dual;
END;
/


-- 为列添加注释
COMMENT ON COLUMN teacher.id IS 'ID';
COMMENT ON COLUMN teacher.username IS '用户名';
COMMENT ON COLUMN teacher.name IS '教师名';
COMMENT ON COLUMN teacher.gender IS '性别 1为男 2为女';
COMMENT ON COLUMN teacher.age IS '年龄';
COMMENT ON COLUMN teacher.dept2_id IS '关联学院';
COMMENT ON COLUMN teacher.phone_number IS '电话';
COMMENT ON COLUMN teacher.email IS '邮箱';
COMMENT ON COLUMN teacher.office IS '办公室';
COMMENT ON COLUMN dept2.create_by IS '创建者';
COMMENT ON COLUMN dept2.create_time IS '创建时间';
COMMENT ON COLUMN dept2.update_by IS '更新者';
COMMENT ON COLUMN dept2.update_time IS '更新时间';
COMMENT ON TABLE teacher IS '教师表';


INSERT ALL
    INTO teacher (username,name, gender, age, dept2_id, phone_number, email, office, create_by, create_time, update_by,
                  update_time)
VALUES ('3zhangwei','张伟', 1, 22, 1, '13800138000', 'zhangwei@university.edu', 'B201', USER, SYSDATE, USER, SYSDATE)
INTO teacher (username,name, gender, age,  dept2_id, phone_number, email, office, create_by, create_time, update_by,
              update_time)
VALUES ('3lina','李娜', 2, 26,  1, '13900139000', 'lina@university.edu', 'B202', USER, SYSDATE, USER, SYSDATE)
INTO teacher (username,name, gender, age,  dept2_id, phone_number, email, office, create_by, create_time, update_by,
              update_time)
VALUES ('3wangqiang','王强', 1, 24,  1, '13700137000', 'wangqiang@university.edu', 'B203', USER, SYSDATE, USER, SYSDATE)
INTO teacher (username,name, gender, age,  dept2_id, phone_number, email, office, create_by, create_time, update_by,
              update_time)
VALUES ('3huangli','黄丽', 2, 22,  1, '13000130000', 'huangli@university.edu', 'A203', USER, SYSDATE, USER, SYSDATE)
INTO teacher (username,name, gender, age,  dept2_id, phone_number, email, office, create_by, create_time, update_by,
              update_time)
VALUES ('3zhengqiang','郑强', 1, 33,  1, '13100131000', 'zhengqiang@university.edu', 'A202', USER, SYSDATE, USER, SYSDATE)
INTO teacher (username,name, gender, age,  dept2_id, phone_number, email, office, create_by, create_time, update_by,
              update_time)
VALUES ('3lisi','李四', 1, 40,  2, '13800138001', 'lisi@university.edu', 'A201', USER, SYSDATE, USER, SYSDATE)
SELECT *
FROM dual;