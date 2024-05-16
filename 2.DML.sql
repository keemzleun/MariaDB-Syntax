-- insert into : 데이터 삽입
INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3) VALUES(데이터1, 데이터2, 데이터3);

-- select : 데이터 조회, * : 모든 컬럼 조회
SELECT * FROM author;
-- 예시: insert into author(id, name, email) values(1, 'keem', 'keem@naver.com');

-- id, title, content, author_id -> posts에 1건 추가
INSERT INTO posts(id, title, content, author_id) VALUES(1, 'say hi', 'hello world', 1);

-- 테이블 제약조건 조회
SELECT * FROM information_schema.key_column_usage WHERE TABLE_NAME = 'posts';

-- update 테이블명 set 컬럼명=데이터 where id = 1;
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의
UPDATE author SET name = abc, email='abc@test.com' where id=1;

-- delete from 테이블명 where 조건
-- where 조건이 생략될 경우 모든 데이터가 삭제됨에 유의
delete from author where id=5;

-- select의 다양한 조회 방법
select * from author;
select * from author where id=1;
select * from author WHERE id>2 and name='gang';

-- 특정 컬럼만 조회할 때
SELECT name, email FROM author WHERE id = 3;

-- 중복 제거하고 조회하기
select distinct title from post;

-- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬조건 없이 조회할 경우에는 pk를 기준으로 오름차순 정렬
-- asc: 오름차순, desc: 내림차순, 생략시 오름차순
select * from author order by name asc;

-- 멀티컬럼 order by : 여러 컬럼으로 정렬. 먼저 쓴 칼럼 우선 정렬, 중복시 그 다음 정렬 옵션 적용
select * from post order by title;
select * from post order by title asc, id desc;

-- limit number : 특정 숫자로 결과 값 개수 제한
select * from author ORDER BY id DESC LIMIT 1;

-- alias(별칭)을 이용한 select : as 키워드 사용
select name as 이름, email as 이메일 from author;
select a.name as 이름, a.email as 이메일 from author as a;

-- null을 조회 조건으로
select * from post where author_id is null;
select * from post where author_id is not null;


-- [프로그래머스] 여러 기준으로 정렬하기
-- [프로그래머스] 상위 n개 레코드



