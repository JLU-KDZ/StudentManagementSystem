
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


