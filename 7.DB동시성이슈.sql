-- dirty read 실습
-- 워크벤치에서 오토 커밋을 해제 후 update 실행 -> commit이 안된 상태
-- 터미널을 열어서 select 했을 때 변경사항이 변경됐는지 확인

-- phantom read 동시성 이슈 실습
-- 워크벤치에서 시간을 두고 두번의 select가 이루어지고,
-- 터미널에서 중간에 insert 실행 -> 2번의 select 결과값이 동일한지 확인
START TRANSACTION;
SELECT count(*) FROM author;
do sleep(15);
SELECT count(*) FROM author;
COMMIT;
-- 터미널에서 아래 insert문 실행
INSERT INTO author(name, email) VALUES('kim', 'kim@naver.com');


-- lost update 이슈를 해결하기 위한 공유락(shared lock)
-- 워크벤치에서 아래 코드 실행
start transaction;
select post_count from author where id = 6 lock in share mode;
do sleep(15);
select post_count from author where id = 6 lock in share mode;
commit;

-- 터미널에서 실행
select post_count from author where id = 6 lock in share mode;
update author set post_count=0 where id = 6;


-- 배타적 잠금: select for update
-- select부터 lock
start transaction;
select post_count from author where id = 6 for UPDATE;
do sleep(15);
select post_count from author where id = 6 for UPDATE;
commit;

-- 터미널에서 실행
select post_count from author where id = 6 for UPDATE;
update author set post_count=0 where id = 6;
