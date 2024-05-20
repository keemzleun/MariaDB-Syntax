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

-- BLOB 바이너리데이터 실습
-- author 테이블에 profile_image컬럼을 blob형식으로 추가
alter table author add column profile_image blob;
alter into author(id, email, profile_image) values (8, 'abc@naver.com', '이미지경로');

-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 컬럼
alter table author add column role enum('admin', 'user') default 'user';

-- enum 컬럼 실습
-- user1을 insert -> 에러
-- user 또는 admin insert -> 정상

-- date 타입
-- author테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author (id, email, birth_day) VALUES (14, 'aaa@naver.com', '2000-05-17');


-- datetime 타입
-- author, post 둘 다 datetime으로 created_time 컬럼 추가
alter table author add column created_time datetime default current_timestamp;
alter table post add column created_time datetime;

-- 비교연산자
-- and 또는 &&
select * from post WHERE id >= 2 && id <= 5;
select * from post where id beteen 2 and 4;

-- or 또는 ||
-- not 또는 !

-- NULL인지 아닌지
select from post where contents is null;
select from post where contents is not null;

-- in(리스트 형태), not in(리스트 형태)
select * from post where id in(1, 2, 3, 4);
select * from post where id not in(1, 2, 3, 4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o'; -- o로 끝나는 title 검색
select * from post where title like 'h%'; -- h로 시작하는 title 검색
select * from post where title like '%llo%'; -- 단어 중간에 llo라는 키워드가 있는 경우 검색
select * from post where title like '%o'; -- o로 끝나는 title이 아닌 title 검색

-- ifnull(a, b) : 만약 a가 null이면 b 반환, null이 아니면 a 반환
select title, contents, ifnull(author_id, '익명') as 저자 from post;

-- REGEXP : 정규표현식을 활용한 조회
select * from  author where name regexp '[a-z]';
select * from  author where name regexp '[가-힣]';


-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CAST와 CONVERT
select cast(202001021 as date);
select cast('202001021' as date);
select convert (202001021, date);
select convert('202001021', date);

-- datetime 조회 방법
select * from post where created_time like '2024-05%';
select * from post where created_time >= '2024' and created_time >= '1999';
select * from post where created_time between '2023' and '1999';

-- data_format
select date_format(created_time, '%Y-%m') from post;
-- 실습 ) post를 조회할 때 date_format을 활용하여 2024년 데이터 조회, 결과는 *
select * from post WHERE data_format(created_time, '%Y')='2024';

-- 오늘 날짜
select now();

