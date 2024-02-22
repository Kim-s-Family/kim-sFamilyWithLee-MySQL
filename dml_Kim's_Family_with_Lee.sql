CREATE DATABASE attendancemanagementdb;


GRANT ALL PRIVILEGES ON attendancemanagementdb.* TO 'ohgiraffers'@'%';

SHOW GRANTS FOR 'ohgiraffers'@'%';

USE attendancemanagementdb;

DROP TABLE `check_date`;

CREATE TABLE `check_date`
(
    `date_code`    INTEGER NOT NULL COMMENT '날짜코드',
    `year_month_day`    TIMESTAMP NOT NULL COMMENT '날짜',
 PRIMARY KEY ( `date_code` )
) COMMENT = '날짜';

ALTER TABLE `check_date`
 ADD CONSTRAINT `check_date_PK` PRIMARY KEY ( `date_code` );


DROP TABLE `attendance_record`;

CREATE TABLE `attendance_record`
(
    `attendance_code`    VARCHAR(100) NOT NULL COMMENT '근태코드',
    `date_code`    INTEGER NOT NULL COMMENT '날짜코드',
    `emp_id`    VARCHAR(100) NOT NULL COMMENT '사용자ID',
    `arrival_at_work`    CHAR COMMENT '출근',
    `leave_work`    CHAR COMMENT '퇴근',
    `late_work`    CHAR NOT NULL COMMENT '지각',
    `vacation`    VARCHAR(100) COMMENT '휴가',
 PRIMARY KEY ( `attendance_code` )
) COMMENT = '근태기록';

ALTER TABLE `attendance_record`
 ADD CONSTRAINT `attendance_record_PK` PRIMARY KEY ( `attendance_code` );


DROP TABLE `compensation`;

CREATE TABLE `compensation`
(
    `emp_id`    VARCHAR(100) NOT NULL COMMENT '사용자ID',
    `attendance_code`    VARCHAR(100) NOT NULL COMMENT '근태코드',
    `evaluation_criteria`    VARCHAR(100) NOT NULL COMMENT '상벌기준',
    `compensation_status`    CHAR NOT NULL COMMENT '보상여부',
    `penalty_status`    CHAR NOT NULL COMMENT '패널티여부',
 PRIMARY KEY ( `emp_id` )
) COMMENT = '보상';

ALTER TABLE `compensation`
 ADD CONSTRAINT `compensation_PK` PRIMARY KEY ( `emp_id` );


DROP TABLE `payment`;

CREATE TABLE `payment`
(
    `payment_code`    VARCHAR(100) NOT NULL COMMENT '급여코드',
    `payment_category`    VARCHAR(100) NOT NULL COMMENT '급여종류',
    `payment_amount`    INTEGER NOT NULL COMMENT '급여액',
 PRIMARY KEY ( `payment_code` )
) COMMENT = '급여';

ALTER TABLE `payment`
 ADD CONSTRAINT `payment_PK` PRIMARY KEY ( `payment_code` );


DROP TABLE `department`;

CREATE TABLE `department`
(
    `department_code`    VARCHAR(100) NOT NULL COMMENT '부서코드',
    `department_name`    VARCHAR(100) NOT NULL COMMENT '부서명',
 PRIMARY KEY ( `department_code` )
) COMMENT = '부서';

ALTER TABLE `department`
 ADD CONSTRAINT `department_PK` PRIMARY KEY ( `department_code` );


DROP TABLE `emp_position`;

CREATE TABLE `emp_position`
(
    `position_code`    VARCHAR(100) NOT NULL COMMENT '직책코드',
    `position_name`    VARCHAR(100) NOT NULL COMMENT '직책명',
    `authorization_access`    CHAR NOT NULL COMMENT '권한',
 PRIMARY KEY ( `position_code` )
) COMMENT = '직책';

ALTER TABLE `emp_position`
 ADD CONSTRAINT `emp_position_PK` PRIMARY KEY ( `position_code` );


DROP TABLE `evaluation_list`;

CREATE TABLE `evaluation_list`
(
    `attendance_code`    VARCHAR(100) NOT NULL COMMENT '근태코드',
    `evaluation_criteria`    VARCHAR(100) NOT NULL COMMENT '평가기준',
 PRIMARY KEY ( `attendance_code`,`evaluation_criteria` )
) COMMENT = '평가항목';

ALTER TABLE `evaluation_list`
 ADD CONSTRAINT `evaluation_list_PK` PRIMARY KEY ( `attendance_code`,`evaluation_criteria` );


DROP TABLE `emp_info`;

CREATE TABLE `emp_info`
(
    `emp_id`    VARCHAR(100) NOT NULL COMMENT '사용자ID',
    `emp_password`    VARCHAR(100) NOT NULL COMMENT '사용자PWD',
    `emp_name`    VARCHAR(100) NOT NULL COMMENT '이름',
    `phone`    VARCHAR(100) NOT NULL COMMENT '전화번호',
    `email`    VARCHAR(100) NOT NULL COMMENT '이메일주소',
    `department_code`    VARCHAR(100) NOT NULL COMMENT '부서코드',
    `position_code`    VARCHAR(100) NOT NULL COMMENT '직책코드',
    `emp_identification`    VARCHAR(100) NOT NULL COMMENT '구분',
    `payment_code`    VARCHAR(100) NOT NULL COMMENT '급여코드',
 PRIMARY KEY ( `emp_id` )
) COMMENT = '직원정보';

ALTER TABLE `emp_info`
 ADD CONSTRAINT `emp_info_PK` PRIMARY KEY ( `emp_id` );


--------------------------------------------------------------------------------

SELECT * FROM attendancemanagementdb.payment;

insert into payment(
            payment_code,
            payment_category,
            payment_amount)
      values
        ("P1","사원",100);
        
insert into payment(
            payment_code,
            payment_category,
            payment_amount)
      values
        ("P2","사원",100);
        
insert into payment(
            payment_code,
            payment_category,
            payment_amount)
      values
        ("P3","대리",200),
        ("P4","사장",400);
        
select   
		 payment_code,
         payment_category,
         payment_amount
  from   payment;
  
UPDATE payment
   SET payment_code = "pay3"
 WHERE payment_code = "pay2";
 
 UPDATE payment
   SET payment_category = "대리"
 WHERE payment_code = "pay3";
 
DELETE FROM payment
ORDER BY payment_code
LIMIT 1;

INSERT INTO -- 직원등록
         emp_info(emp_id, emp_password, emp_name, phone, email, department_code, position_code, emp_identification, payment_code)
VALUES ('user01', 'pwd123', '김지호', '010-1111-1111', 'kr1@kr.com', 'D1', 'J1', 'Y', 'P1'),
       ('user02', 'pwd123', '김진용', '010-2222-1111', 'kr2@kr.com', 'D2', 'J2', 'N', 'P2'),
       ('user03', 'pwd123', '이민국', '010-3333-1111', 'kr3@kr.com', 'D3', 'J3', 'N', 'P3'),
       ('user04', 'pwd123', '김만호', '010-4444-1111', 'kr4@kr.com', 'D4', 'J4', 'N', 'P4');

SELECT
       A.payment_code,
       B.emp_name
  FROM payment A
 INNER JOIN emp_info B USING (payment_code);



