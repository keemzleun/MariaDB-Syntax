-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database)
show databases;

-- board 스키마(데이터베이스) 생성
CREATE DATABASE board;

-- 데이터베이스 선택
use board;

-- 테이블 조회
SHOW tables;

-- author 테이블 생성
CREATE TABLE author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼 조회
describe author;

-- 컬럼 상세 조회
SHOW FULL COLUMNS from author;

-- 테이블 생성문 조회
SHOW CREATE TABLE author;

-- post 테이블 신규 생성
CREATE TABLE posts (id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT, Foreign Key (author_id) REFERENCES author(id));

-- 테이블 인덱스 조회
SHOW INDEX FROM author;

-- ALTER문 : 테이블의 구조를 변경
-- 테이블 이름 변경
ALTER TABLE posts RENAME post;

-- 테이블 컬럼 추가
ALTER TABLE author ADD COLUMN test1 VARCHAR(50);

-- 테이블 컬럼 삭제
ALTER TABLE author DROP COLUMN test1;

-- 테이블 컬럼명 변경
ALTER TABLE post CHANGE content contents VARCHAR(255);

-- 테이블 컬럼 타입과 제약조건 변경
ALTER TABLE author MODIFY COLUMN email VARCHAR(255) NOT NULL;
ALTER TABLE author MODIFY COLUMN profile_image longblob;


-- 테이블 삭제
DROP TABLE 테이블명;