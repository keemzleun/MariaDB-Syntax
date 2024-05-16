-- tinyint는 -128~127까지 표현
-- author 테이블에 age 컬럼 추가
alter table add column age tinyint;

-- unsigned시에 255까지 표현범위 확대
alter table author modify column age tinyint unsigned;

-- insert시에 age : 200 -> 125
insert into author(id, email, age) values(5, 'hello@naver.com', 130);

-- decimal 실습
alter table post add COLUMN price decimal(10, 3);

-- decimal 소수점 초과 값 입력 후 짤림 확인
INSERT into post (id, title, price) value (7, 3.123456);
-- update : price를 1234.1