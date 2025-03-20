CREATE TABLE role_menu
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

