-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment;

-- author.id에 제약조건 추가시 fk로 인해 문제 발생시
-- fk 먼저 제거 이후에 author.id에 제약조건 추가
select * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE where table_name = 'post';

-- 삭제
alter table post drop foreign key post_ibfk_1;

-- 삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk foreign key(author_id) REFERENCES author(id);

-- uuid
alter table post add column user_id;

-- unique 제약 조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 -> 부모테이블의 id를 수정하면? 수정 안됨
alter table post drop foreign key post_author_fk;

-- alter table post drop foreign key post_author_fk;
-- alter table post add constraint post_author_fk foreign key(author_id) REFERENCES author(id) on delete cascade on update cascade;

-- (실습) delete는 set null, update는 cascade
alter table post add constraint post_author_fk foreign key(author_id) REFERENCES author(id) on delete set null on update cascade;
