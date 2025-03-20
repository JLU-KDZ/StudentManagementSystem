
-- 创建序列
CREATE SEQUENCE course_id_seq START WITH 1 INCREMENT BY 1 NOCACHE;


--创建course表
CREATE TABLE course
(
    id              NUMBER(10) PRIMARY KEY,
    NAME            VARCHAR2(200) not null unique,
    teacher_id      NUMBER,
    DESCRIPTION     VARCHAR2(200),
    stu_number      number,
    max_number      number,
    major_id        number,
    CREDIT          NUMBER
        check (Credit > 0),
    time            VARCHAR2(200),
    location        VARCHAR2(200),
    enrolled_number number,
    status          VARCHAR2(100) CHECK (status IN ('未开课', '开课', '满课')),
    create_by       VARCHAR2(50)  NOT NULL,
    create_time     DATE          NOT NULL,
    update_by       VARCHAR2(50)  NOT NULL,
    update_time     DATE          NOT NULL
);


-- 创建触发器
CREATE OR REPLACE TRIGGER course_id_trigger
    BEFORE INSERT
    ON COURSE
    FOR EACH ROW
    WHEN (NEW.id IS NULL)
BEGIN
    SELECT course_id_seq.NEXTVAL INTO :NEW.id FROM dual;
END;
/


-- 为列添加注释
COMMENT ON COLUMN course.id IS 'ID';
COMMENT ON COLUMN course.name IS '课程名';
COMMENT ON COLUMN course.CREDIT IS '学分';
COMMENT ON COLUMN course.teacher_id IS '授课教师';
COMMENT ON COLUMN course.major_id IS '专业';
COMMENT ON COLUMN course.stu_number IS '开班人数';
COMMENT ON COLUMN course.max_number IS '满课人数';
COMMENT ON COLUMN course.DESCRIPTION IS '课程介绍';
COMMENT ON COLUMN course.time IS '上课时段';
COMMENT ON COLUMN course.location IS '地点';
COMMENT ON COLUMN course.enrolled_number IS '已选人数';
COMMENT ON COLUMN course.status IS '状态';
COMMENT ON COLUMN course.create_by IS '创建者';
COMMENT ON COLUMN course.create_time IS '创建时间';
COMMENT ON COLUMN course.update_by IS '更新者';
COMMENT ON COLUMN course.update_time IS '更新时间';
COMMENT ON TABLE course IS '课程表';


INSERT ALL
    INTO course (name, CREDIT, teacher_id, major_id, stu_number, max_number, DESCRIPTION, time, location,
                 enrolled_number, status,
                 create_by, create_time, update_by, update_time)
VALUES ('java基础', 4, 1, 1, 20, 40, 'java基础知识', '周一第二大节', '3A101', 2, '未开课', USER, SYSDATE, USER, SYSDATE)
INTO course (name, CREDIT, teacher_id, major_id, stu_number, max_number, DESCRIPTION, time, location, enrolled_number,
             status, create_by,
             create_time, update_by, update_time)
VALUES ('java进阶', 4, 2, 1, 20, 40, 'java进阶学习', '周一第四大节', '3A102', 2, '未开课', USER, SYSDATE, USER, SYSDATE)
INTO course (name, CREDIT, teacher_id, major_id, stu_number, max_number, DESCRIPTION, time, location, enrolled_number,
             status, create_by,
             create_time, update_by, update_time)
VALUES ('python基础', 3, 3, 2, 20, 40, 'python基础知识', '周二第三大节', '3A103', 0, '未开课', USER, SYSDATE, USER,
        SYSDATE)
SELECT *
FROM dual;