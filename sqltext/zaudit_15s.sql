
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