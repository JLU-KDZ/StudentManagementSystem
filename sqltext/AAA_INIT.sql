-- 创建审计表

CREATE SEQUENCE audit_id_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE;

CREATE TABLE audit_log
(
    log_id      NUMBER,
    operation   VARCHAR2(10),
    table_name  VARCHAR2(100),
    column_name varchar2(200),
    changed_by  VARCHAR2(30),
    changed_on  TIMESTAMP,
    old_value   VARCHAR2(200),
    new_value   VARCHAR2(200)
);


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
FROM dual;CREATE TABLE menu
(
    menu_id         NUMBER(10) PRIMARY KEY, -- 唯一标识符
    menu_name       VARCHAR2(100),          -- 菜单名称
    permission_code VARCHAR2(100)          -- 权限代码
);
INSERT INTO menu VALUES (1, '学生查询', 'stu_QUERY');
INSERT INTO menu VALUES (2, '学生编辑', 'stu_update');
INSERT INTO menu VALUES (3, '学生删除', 'stu_delete');
INSERT INTO menu VALUES (4, '学生添加', 'stu_insert');
INSERT INTO menu VALUES (5, '学生根据ID查询', 'stu_getById');
INSERT INTO menu VALUES (6, '班级管理', 'class_manage');
INSERT INTO menu VALUES (7, '学院管理', 'dept2_manage');
CREATE TABLE roles (
                      RID NUMBER PRIMARY KEY,
                       ROLE_NAME VARCHAR2(50) NOT NULL UNIQUE,
                       ROLE_DESC VARCHAR2(50) NOT NULL
);


INSERT INTO roles VALUES (1, 'ROLE_Stu', '学生角色');
INSERT INTO roles VALUES (2, 'ROLE_ADMIN', '超级管理员');
INSERT INTO roles VALUES (3, 'ROLE_teacher', '教师角色');CREATE TABLE role_menu
(
    role_id NUMBER(10) NOT NULL,                      -- 角色ID，与 roles 表关联
    menu_id NUMBER(10) NOT NULL,                      -- 菜单项ID，与 menu 表关联
    PRIMARY KEY (role_id, menu_id)                   -- 复合主键，确保角色-菜单组合的唯一性
);
INSERT INTO role_menu
VALUES (1,1);
INSERT INTO role_menu
VALUES (1,5);
INSERT INTO role_menu
VALUES (1,2);
INSERT INTO role_menu
VALUES (1,4);
INSERT INTO role_menu
VALUES (2,1);
INSERT INTO role_menu
VALUES (2,2);
INSERT INTO role_menu
VALUES (2,3);
INSERT INTO role_menu
VALUES (2,4);
INSERT INTO role_menu
VALUES (2,5);
INSERT INTO role_menu
VALUES (2,6);
INSERT INTO role_menu
VALUES (2,7);
INSERT INTO role_menu
VALUES (3, 4);
INSERT INTO role_menu
VALUES (3, 6);


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


-- 创建序列
CREATE SEQUENCE stu_id_seq START WITH 1 INCREMENT BY 1 NOCACHE;


--创建stu表
CREATE TABLE stu (
                     id NUMBER(10) PRIMARY KEY,
                     username VARCHAR2(20) NOT NULL UNIQUE,
                     password VARCHAR2(32) DEFAULT '123456' not null ,
                     stu_id  number(11) unique ,
                     name VARCHAR2(10),
                     gender NUMBER(1),
                     phonenumber varchar2(20) default 'Unknow',
                     image VARCHAR2(300),
                     grade NUMBER(1),
                     entrydate DATE,
                     dept2_id NUMBER(10),
                     class_id NUMBER(10),
                     create_by  VARCHAR2(50) NOT NULL ,
                     create_time DATE NOT NULL,
                     update_by  VARCHAR2(50) NOT NULL ,
                     update_time DATE NOT NULL
);
-- 创建触发器
CREATE OR REPLACE TRIGGER stu_id_trigger
    BEFORE INSERT ON stu
    FOR EACH ROW
    WHEN (NEW.id IS NULL)
BEGIN
    SELECT stu_id_seq.NEXTVAL INTO :NEW.id FROM dual;
END;
/

--上注释
-- 为表添加注释
COMMENT ON TABLE stu IS '学生表';

-- 为列添加注释
COMMENT ON COLUMN stu.id IS 'ID';
COMMENT ON COLUMN stu.username IS '用户名';
COMMENT ON COLUMN stu.password IS '密码';
COMMENT ON COLUMN stu.name IS '姓名';
COMMENT ON COLUMN stu.gender IS '性别, 说明: 1 男, 2 女';
COMMENT ON COLUMN stu.image IS '图像';
COMMENT ON COLUMN stu.grade IS '年级, 说明: 1 大一,2 大二, 3 大三, 4 大四';
COMMENT ON COLUMN stu.entrydate IS '入学时间';
COMMENT ON COLUMN stu.dept2_id IS '学院ID';
COMMENT ON COLUMN stu.class_id IS '班级ID';
COMMENT ON COLUMN dept2.create_by IS '创建者';
COMMENT ON COLUMN dept2.create_time IS '创建时间';
COMMENT ON COLUMN dept2.update_by IS '更新者';
COMMENT ON COLUMN dept2.update_time IS '更新时间';
COMMENT ON TABLE stu IS '学生表';



--插入数据
INSERT ALL
    INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id,class_id,create_by, create_time,update_by,update_time)
VALUES ( '1jinyang', '123456','32023210001', '金阳', 1, '1.jpg', 4, TO_DATE('2000-01-01', 'yyyy-mm-dd'), 2,4,USER,sysdate,USER,sysdate)
INTO stu (  username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1zhangwu', '123456','32023210002', '张五', 1, '2.jpg', 2, TO_DATE('2015-01-01', 'yyyy-mm-dd'), 2,4,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1yangxiao', '123456','32023210003', '杨逍', 1, '3.jpg', 2, TO_DATE('2008-05-01', 'yyyy-mm-dd'), 2,4,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1weiyixiao', '123456','32023210004', '韦一笑', 1, '4.jpg', 2, TO_DATE('2007-01-01', 'yyyy-mm-dd'), 2,4,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ('1changyuchun', '123456','32023210005', '常遇春', 1, '5.jpg', 2, TO_DATE('2012-12-05', 'yyyy-mm-dd'), 2,4,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1xiaozhao', '123456','32023210006', '小昭', 2, '6.jpg', 3, TO_DATE('2013-09-05', 'yyyy-mm-dd'), 1,1,USER,sysdate,USER,sysdate)
INTO stu (username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1jixiaofu', '123456','32023210007', '纪晓芙', 2, '7.jpg', 1, TO_DATE('2005-08-01', 'yyyy-mm-dd'), 1,1,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1zhouzhiruo', '123456', '32023210008','周芷若', 2, '8.jpg', 1, TO_DATE('2014-11-09', 'yyyy-mm-dd'), 1,1,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ('1dingminjun', '123456', '32023210009','丁敏君', 2, '9.jpg', 1, TO_DATE('2011-03-11', 'yyyy-mm-dd'), 1,1,USER,sysdate,USER,sysdate)
INTO stu (username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1zhaomin', '123456','32023210010', '赵敏', 2, '10.jpg', 1, TO_DATE('2013-09-05', 'yyyy-mm-dd'), 1,1,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1luzhangke', '123456','32023210011', '鹿杖客', 1, '11.jpg', 5, TO_DATE('2007-02-01', 'yyyy-mm-dd'), 3,3,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1hebiweng', '123456','32023210012', '鹤笔翁', 1, '12.jpg', 5, TO_DATE('2008-08-18', 'yyyy-mm-dd'), 3,3,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1fangdongbai', '123456','32023210013', '方东白', 1, '13.jpg', 5, TO_DATE('2012-11-01', 'yyyy-mm-dd'), 3,3,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1zhangsanfeng', '123456','32023210014', '张三丰', 1, '14.jpg', 2, TO_DATE('2002-08-01', 'yyyy-mm-dd'), 2,4,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1yulianzhou', '123456','32023210015', '俞莲舟', 1, '15.jpg', 2, TO_DATE('2011-05-01', 'yyyy-mm-dd'), 2,4,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1songyuanqiao', '123456','32023210016', '宋远桥', 1, '16.jpg', 2, TO_DATE('2010-01-01', 'yyyy-mm-dd'), 2,4,USER,sysdate,USER,sysdate)
INTO stu ( username, password,stu_id, name, gender, image, grade, entrydate, dept2_id, class_id,create_by, create_time,update_by,update_time)
VALUES ( '1gaoyifei', '123456','32023210225', '高一菲', 2, '17.jpg', 1, TO_DATE('2023-09-01', 'yyyy-mm-dd'), 1,1,USER,sysdate,USER,sysdate)

SELECT * FROM dual;
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
CREATE SEQUENCE users_id_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
CREATE TABLE users
(
    UID2       NUMBER PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    password VARCHAR2(50) NOT NULL
);
CREATE OR REPLACE TRIGGER users_id_trigger
    BEFORE INSERT
    ON users
    FOR EACH ROW
BEGIN
    SELECT users_id_seq.NEXTVAL INTO :new.UID2 FROM dual;
END;
/

COMMENT ON COLUMN users.UID2 IS '主键ID';
COMMENT ON COLUMN users.username IS '用户名';
COMMENT ON COLUMN users.password IS '密码';
COMMENT ON TABLE users IS '用户表';

INSERT ALL
    INTO users (username, password)
VALUES ('1jinyang', '123456')
INTO users (username, password )
VALUES ('1zhangwu', '123456')
INTO users (username, password )
VALUES ('1yangxiao', '123456')
INTO users (username, password)
VALUES ('1weiyixiao', '123456')
INTO users (username, password )
VALUES ('1linpingzhi', '123456')
INTO users (username, password )
VALUES ('1xiaozhao', '123456')
INTO users (username, password )
VALUES ('1jixiaofu', '123456')
INTO users (username, password )
VALUES ('1zhouzhiruo', '123456')
INTO users (username, password )
VALUES ('1dingminjun', '123456')
INTO users (username, password )
VALUES ('1zhaomin', '123456')
INTO users (username, password )
VALUES ('1luzhangke', '123456')
INTO users (username, password )
VALUES ('1hebiweng', '123456')
INTO users (username, password )
VALUES ('1fangdongbai', '123456')
INTO users (username, password )
VALUES ('1zhangsanfeng', '123456')
INTO users (username, password )
VALUES ('1yulianzhou', '123456')
INTO users (username, password )
VALUES ('1songyuanqiao', '123456')
INTO users (username, password )
VALUES ('1gaoyifei', '123456')
INTO users (username, password )
VALUES ('2root', '123456')
INTO users (username, password )
VALUES ('3lisi', '123456')
INTO users (username, password )
VALUES ('3zhangwei', '123456')
INTO users (username, password )
VALUES ('3lina', '123456')
INTO users (username, password )
VALUES ('3wangqiang', '123456')
INTO users (username, password )
VALUES ('3huangli', '123456')
INTO users (username, password )
VALUES ('3zhengqiang', '123456')
SELECT *
FROM dual;



CREATE SEQUENCE user_role_id_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
CREATE TABLE user_role
(
    id       NUMBER PRIMARY KEY,
    UID2 number NOT NULL,
    RID number NOT NULL
);
CREATE OR REPLACE TRIGGER user_role_id_trigger
    BEFORE INSERT
    ON user_role
    FOR EACH ROW
BEGIN
    SELECT user_role_id_seq.NEXTVAL INTO :new.id FROM dual;
END;
/

COMMENT ON COLUMN user_role.id IS '主键ID';
COMMENT ON COLUMN user_role.UID2 IS '用户ID';
COMMENT ON COLUMN user_role.RID IS '角色ID';
COMMENT ON TABLE user_role IS '用户角色表';


INSERT ALL
    INTO user_role (UID2, RID)
VALUES (1, 1)
INTO user_role (UID2, RID)
VALUES (2, 1)
INTO user_role (UID2, RID)
VALUES (3, 1)
INTO user_role (UID2, RID)
VALUES (4, 1)
INTO user_role (UID2, RID)
VALUES (5, 1)
INTO user_role (UID2, RID)
VALUES (6, 1)
INTO user_role (UID2, RID)
VALUES (7, 1)
INTO user_role (UID2, RID)
VALUES (8, 1)
INTO user_role (UID2, RID)
VALUES (9, 1)
INTO user_role (UID2, RID)
VALUES (10, 1)
INTO user_role (UID2, RID)
VALUES (11, 1)
INTO user_role (UID2, RID)
VALUES (12, 1)
INTO user_role (UID2, RID)
VALUES (13, 1)
INTO user_role (UID2, RID)
VALUES (14, 1)
INTO user_role (UID2, RID)
VALUES (15, 1)
INTO user_role (UID2, RID)
VALUES (16, 1)
INTO user_role (UID2, RID)
VALUES (17, 1)
INTO user_role (UID2, RID)
VALUES (18, 2)
INTO user_role (UID2, RID)
VALUES (19, 3)
INTO user_role (UID2, RID)
VALUES (20, 3)
INTO user_role (UID2, RID)
VALUES (21, 3)
INTO user_role (UID2, RID)
VALUES (22, 3)
INTO user_role (UID2, RID)
VALUES (23, 3)
INTO user_role (UID2, RID)
VALUES (24, 3)

SELECT *
FROM dual;



CREATE OR REPLACE TRIGGER audit_id_trigger
    BEFORE INSERT
    ON audit_log
    FOR EACH ROW
BEGIN
    SELECT audit_id_seq.NEXTVAL INTO :new.log_id FROM dual;
END;
/

-- 创建insert触发器
CREATE OR REPLACE TRIGGER stu_after_insert
    AFTER INSERT
    ON stu
    FOR EACH ROW
DECLARE
    v_old_value VARCHAR2(200);
BEGIN
    INSERT INTO audit_log (operation,
                           table_name,
                           column_name,
                           changed_by,
                           changed_on,
                           new_value)
    VALUES ('INSERT',
            'stu',
            NULL, -- INSERT 操作不涉及特定列的更改
            USER, -- 当前登录的用户
            SYSDATE, -- 当前系统日期和时间
            :NEW.username || ', ' || :NEW.password || ', ' || :NEW.name || ', ' || :NEW.gender || ', ' || :NEW.image
                || ', ' || :NEW.grade || ', ' || :NEW.entrydate || ', ' || :NEW.dept2_id || ', ' || :NEW.class_id-- 新值
           );
END;
/




-- 创建update触发器
CREATE OR REPLACE TRIGGER stu_update_trigger
    AFTER UPDATE ON stu
    FOR EACH ROW
BEGIN
    FOR i IN (
        SELECT column_name
        FROM user_tab_columns
        WHERE table_name = 'STU'
          AND column_name IN ('USERNAME', 'PASSWORD', 'NAME', 'GENDER', 'IMAGE', 'GRADE', 'ENTRYDATE', 'DEPT2_ID', 'CLASS_ID')
          AND (
                        column_name = 'USERNAME' AND :OLD.USERNAME != :NEW.USERNAME
                OR column_name = 'PASSWORD' AND :OLD.PASSWORD != :NEW.PASSWORD
                OR column_name = 'NAME' AND :OLD.NAME != :NEW.NAME
                OR column_name = 'GENDER' AND :OLD.GENDER != :NEW.GENDER
                OR column_name = 'IMAGE' AND :OLD.IMAGE != :NEW.IMAGE
                OR column_name = 'GRADE' AND :OLD.GRADE != :NEW.GRADE
                OR column_name = 'ENTRYDATE' AND :OLD.ENTRYDATE != :NEW.ENTRYDATE
                OR column_name = 'DEPT2_ID' AND :OLD.DEPT2_ID != :NEW.DEPT2_ID
                OR column_name = 'CLASS_ID' AND :OLD.CLASS_ID != :NEW.CLASS_ID
            )
        ) LOOP
            INSERT INTO audit_log (
                operation,
                table_name,
                column_name,
                changed_by,
                changed_on,
                old_value,
                new_value
            ) VALUES (
                         'UPDATE',
                         'STU',
                         i.column_name,
                         USER,
                         SYSDATE,
                         CASE i.column_name
                             WHEN 'USERNAME' THEN :OLD.USERNAME
                             WHEN 'PASSWORD' THEN :OLD.PASSWORD
                             WHEN 'NAME' THEN :OLD.NAME
                             WHEN 'GENDER' THEN TO_CHAR(:OLD.GENDER)
                             WHEN 'IMAGE' THEN :OLD.IMAGE
                             WHEN 'GRADE' THEN TO_CHAR(:OLD.GRADE)
                             WHEN 'ENTRYDATE' THEN TO_CHAR(:OLD.ENTRYDATE, 'YYYY-MM-DD HH24:MI:SS')
                             WHEN 'DEPT2_ID' THEN TO_CHAR(:OLD.DEPT2_ID)
                             WHEN 'CLASS_ID' THEN TO_CHAR(:OLD.CLASS_ID)
                             END,
                         CASE i.column_name
                             WHEN 'USERNAME' THEN :NEW.USERNAME
                             WHEN 'PASSWORD' THEN :NEW.PASSWORD
                             WHEN 'NAME' THEN :NEW.NAME
                             WHEN 'GENDER' THEN TO_CHAR(:NEW.GENDER)
                             WHEN 'IMAGE' THEN :NEW.IMAGE
                             WHEN 'GRADE' THEN TO_CHAR(:NEW.GRADE)
                             WHEN 'ENTRYDATE' THEN TO_CHAR(:NEW.ENTRYDATE, 'YYYY-MM-DD HH24:MI:SS')
                             WHEN 'DEPT2_ID' THEN TO_CHAR(:NEW.DEPT2_ID)
                             WHEN 'CLASS_ID' THEN TO_CHAR(:NEW.CLASS_ID)
                             END
                     );
        END LOOP;
END;
/

-- 创建delete触发器
CREATE OR REPLACE TRIGGER stu_after_delete
    AFTER DELETE ON stu
    FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
        operation,
        table_name,
        column_name,
        changed_by,
        changed_on,
        old_value
    ) VALUES (
                 'DELETE',
                 'stu',
                 NULL, -- DELETE 操作不涉及特定列的更改
                 USER, -- 当前登录的用户
                 SYSDATE, -- 当前系统日期和时间
                 :OLD.username || ', ' || :OLD.password || ', ' || :OLD.name || ', ' || :OLD.gender || ', ' || :OLD.image
                     || ', ' || :OLD.grade || ', ' || :OLD.entrydate || ', ' || :OLD.dept2_id || ', ' || :OLD.class_id -- 旧值
             );
END;
/