
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