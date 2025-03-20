CREATE TABLE menu
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
