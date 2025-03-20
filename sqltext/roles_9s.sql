CREATE TABLE roles (
                      RID NUMBER PRIMARY KEY,
                       ROLE_NAME VARCHAR2(50) NOT NULL UNIQUE,
                       ROLE_DESC VARCHAR2(50) NOT NULL
);


INSERT INTO roles VALUES (1, 'ROLE_Stu', '学生角色');
INSERT INTO roles VALUES (2, 'ROLE_ADMIN', '超级管理员');
INSERT INTO roles VALUES (3, 'ROLE_teacher', '教师角色');