
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


