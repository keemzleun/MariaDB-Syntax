-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- %는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' IDENTIFIED BY '1234';

-- 사용자에게 select 권한 부여
GRANT SELECT ON board.author TO 'test1'@'localhost';

-- 사용자 권한 회수
REVOKE SELECT ON board.author from 'test1'@'localhost';

-- 환경설정을 변경후 확정
flush PRIVILEGES;

-- 터미널에서 test1로 로그인
docker exec -it my_mariadb mariadb -u test1 -p;

-- test1으로 로그인 후에
SELECT * FROM board.author;

-- 사용자 계정 삭제
DROP user 'test1'@'localhost';



-- view
-- view 생성
create view author_for_marketing_team as
SELECT name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- test 계정 view select 권한 부여
grant SELECT on board.author_for_marketing_team to 'test'@'localhost';

-- view 변경(대체)
CREATE or REPLACE view author_for_marketing_team AS
SELECT name, email, age, role from author;

-- view 삭제
DROP view author_for_marketing_team;



-- 프로시저 생성
DELIMITER //
CREATE PROCEDURE test_procedure()
BEGIN
    SELECT 'hello world';
END
// DELIMITER ;

-- 프로시저 호출
CALL test_procedure();

-- 프로시저 삭제
drop procedure test_procedure();

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN
    SELECT * from post;
END
// DELIMITER ;

CALL 게시글목록조회();

-- 게시글 단건 조회
    DELIMITER //
    CREATE PROCEDURE 게시글단건조회(in 저자id int, in 제목 varchar(255))
    BEGIN
        SELECT * from post WHERE author_id = 저자id and title = 제목;
    END
    // DELIMITER ;

    CALL 게시글단건조회(6, 'hello');

-- 글쓰기
    DELIMITER //
    CREATE PROCEDURE 글쓰기(in 저자id int, in 제목 varchar(255), in 내용 varchar(255))
    BEGIN
        insert into author_id = 저자id, title = 제목, contents = 내용 from post;
    END
    // DELIMITER ;

    CALL 글쓰기(8, '제목', '내용');


-- 글쓰기이메일 : title, contents, email 삽입 
    DELIMITER // 
    CREATE PROCEDURE 글쓰기이메일(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255) ) 
    BEGIN
        declare author_Id int;
        select id into author_Id from author where email = emailInput;
        insert into post(title, contents, author_id) values(titleInput, contentsInput, author_Id);
    END // DELIMITER ;
    call 글쓰기이메일('착한', '밀초','milk@google.com');

-- sql에서 문자열 합치는 concat('hello', 'world');

    -- 글상세조회 : input값이 postId
    -- 예상 결과값 : title, contents, '홍길동' + '님'
    DELIMITER // 
    CREATE PROCEDURE 글상세조회(in postId int) 
    BEGIN
        declare authorName varchar(255); 
        select name into authorName from author where id = (SELECT author_id from post where id = postId);
        set authorName = concat(authorName + '님');
        select title, contentsm authorName from post where id = postId;
    END // DELIMITER ;


-- 등급조회
-- 글을 100개 이상 쓴 사용자는 '고수입니다.' 출력
-- 10개 이상 100개 미만 '중수입니다.'
-- 10개 미만 '초보입니다.'
-- input값 : email값
-- GPT 풀이
    DELIMITER //

    CREATE PROCEDURE 등급조회(in emailInput varchar(255)) 
    BEGIN
        DECLARE post_count INT;

        -- 작성한 글 수 조회
        SELECT COUNT(*) INTO post_count 
        FROM post 
        JOIN author ON post.author_id = author.id
        WHERE author.email = emailInput;

        -- 등급 출력
        CASE
            WHEN post_count >= 100 THEN
                SELECT '고수입니다.' AS 등급;
            WHEN post_count >= 10 THEN
                SELECT '중수입니다.' AS 등급;
            ELSE
                SELECT '초보입니다.' AS 등급;
        END CASE;
    END
    //
    DELIMITER ;

-- 강사님 풀이
    declare authorId int;
    declare count int;
    select id into authorId from author where email=emailInput;
    select count(*) from post where author_id = authorId;
    IF count >= 100 then
        select '고수입니다';
    elseif count >= 10 and count <100 then
        select '중수입니다';
    else
        select '초보입니다';
    end if;

-- 반복을 통해 post 대량 생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 안녕하세요
DELIMITER //

CREATE PROCEDURE 도배(in count int) 
BEGIN
    DECLARE countValue INT default 0;
    while countValue < count do
        insert into post(title) values("안녕하세요");
        set countValue =  countValue + 1;
    end while;
END
//
DELIMITER ;

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';

