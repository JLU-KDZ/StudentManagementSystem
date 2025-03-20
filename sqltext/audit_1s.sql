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

