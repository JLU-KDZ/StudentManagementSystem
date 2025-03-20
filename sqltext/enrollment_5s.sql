
-- 创建序列
CREATE SEQUENCE enrollment_id_seq START WITH 1 INCREMENT BY 1 NOCACHE;


--创建enrollment表
CREATE TABLE enrollment
(
    id          NUMBER(10) PRIMARY KEY,
    stu_name        VARCHAR2(200) not null,
    course_id    number,
    create_by   VARCHAR2(50)  NOT NULL,
    create_time DATE          NOT NULL,
    update_by   VARCHAR2(50)  NOT NULL,
    update_time DATE          NOT NULL
);


-- 创建触发器
CREATE OR REPLACE TRIGGER enrollment_id_trigger
    BEFORE INSERT
    ON enrollment
    FOR EACH ROW
    WHEN (NEW.id IS NULL)
BEGIN
    SELECT enrollment_id_seq.NEXTVAL INTO :NEW.id FROM dual;
END;
/


-- 为列添加注释
COMMENT ON COLUMN enrollment.id IS 'ID';
COMMENT ON COLUMN enrollment.stu_name IS '学生名';
COMMENT ON COLUMN enrollment.course_id IS '选择课程';
COMMENT ON TABLE enrollment IS '选课表';


INSERT ALL
    INTO enrollment (stu_name, course_id, create_by, create_time, update_by,
                update_time)
VALUES ('张三', 1, USER, SYSDATE, USER, SYSDATE)
INTO enrollment (stu_name, course_id, create_by, create_time, update_by,
            update_time)
VALUES ('高一菲', 1,  USER, SYSDATE, USER, SYSDATE)
INTO enrollment (stu_name, course_id, create_by, create_time, update_by,
            update_time)
VALUES ('金阳', 2, USER, SYSDATE, USER, SYSDATE)
INTO enrollment (stu_name, course_id, create_by, create_time, update_by,
            update_time)
VALUES ('张五', 2,  USER, SYSDATE, USER, SYSDATE)
SELECT *
FROM dual;