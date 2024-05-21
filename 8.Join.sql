-- Inner join
    -- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. On 조건을 통해 교집합 찾기
    SELECT * FROM post INNER JOIN author ON author.id = post.author_id;
    SELECT * FROM author a INNER JOIN post p ON a.id = p.author_id;


-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오
SELECT p.id, p.title, p.contents, a.email FROM post p INNER JOIN author a ON p.author_id = a.id;

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
SELECT p.id, p.title, p.contents, a.email FROM post p  LEFT JOIN author a ON p.author_id = a.id;

-- join된 상황에서 where 조건 : on 뒤에 where 조건이 나옴
    -- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email 출력, 저자의 나이는 25세 이상
    -- 내 답안 = 정답!
    SELECT p.title, a.email FROM post p INNER JOIN author a ON p.author_id = a.id where a.age >= 25;

-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 2024-05-01 이후에 만들어진 글만 출력
    -- 내 답안 = 오답!
    SELECT  FROM post p LEFT join author a WHERE created_time >= '2024-05';
    -- 답안
    SELECT p.title, ifnull(a,email, '익명') FROM post p LEFT JOIN author a 
    ON a.id = p.author_id 
    WHERE p.title is not null and p.created_time >= '2024-05-01';

-- [프로그래머스] 조건에 맞는 도서와 저자 리스트 출력하기
    -- 내 답안 = 정답!
    -- 정답이긴 한데 일반적인 쿼리는 아닌듯...
    SELECT B.BOOK_ID, A.AUTHOR_NAME, DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d') as PUBLISHED_DATE 
    FROM BOOK B INNER JOIN AUTHOR A 
    ON B.CATEGORY = '경제' and B.AUTHOR_ID = A.AUTHOR_ID 
    ORDER BY B.PUBLISHED_DATE ASC;
    -- 답안 : AUTHOR_ID가 nullable=false(NotNull)이기 때문에 Book left join Author도 가능
    SELECT B.BOOK_ID, A.AUTHOR_NAME, DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d') as PUBLISHED_DATE 
    FROM BOOK B INNER JOIN AUTHOR A 
    ON B.AUTHOR_ID = A.AUTHOR_ID 
    WHERE B.CATEGORY = '경제'
    ORDER BY B.PUBLISHED_DATE ASC;


-- UNION : 중복 제외한 두 테이블의 select를 결합
    -- 컬럼의 개수와 타입이 같아야 함에 유의
    -- UNION ALL : 중복 포함
    SELECT 컬럼1, 컬럼2 FROM table1 UNION SELECT 컬럼1, 컬럼2 FROM table2;
    -- author테이블의 name, email, 그리고 post 테이블의 title, contents union
    SELECT name, email, from author union select title, contents from post;


-- 서브쿼리 : select문 안에 또 다른 select문을 서브쿼리라고 함
    -- select절 안에 서브쿼리
    -- author email과 해당 author가 쓴 글의 개수를 출력
    SELECT email, (select count(*) from post p where p.author_id = a.id) as count from author a;

    -- from절 안에 서브쿼리
    SELECT a.name FROM (SELECT * FROM author) as a;

    -- where절 안에 서브쿼리
    SELECT a.* FROM author a INNER JOIN post p ON a.id = p.author_id;  -- join 사용
    SELECT * FROM author WHERE id IN (SELECT author_id FROM post);  -- 서브쿼리 사용

    -- [프로그래머스] 없어진 기록 찾기
        -- JOIN 사용
        SELECT AO.ANIMAL_ID, AO.NAME FROM ANIMAL_OUTS AO LEFT JOIN ANIMAL_INS AI ON AO.ANIMAL_ID = AI.ANIMAL_ID
        WHERE AI.ANIMAL_ID IS NULL ORDER BY AO.ANIMAL_ID;
        -- 서브쿼리 사용
        SELECT ANIMAL_ID, NAME FROM ANIMAL_OUTS AO WHERE ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_INS) ORDER BY ANIMAL_ID;


-- 집계 함수
    -- COUNT()
    SELECT COUNT(*) FROM author;
    -- SUM()
    SELECT SUM(price) FROM post;
    -- AVG()
    SELECT AVG(price) FROM post;
    -- ROUND() : 소수점 올림
    SELECT ROUND(AVG(price), 2) FROM post;

-- GROUP BY와 집계 함수
    SELECT author_id FROM post GROUP BY author_id;
    SELECT author_id, count(*), SUM(price), ROUND(AVG(price), 2), MIN(price), MAX(price) FROM post GROUP BY author_id;

-- 저자 email, 해당 저자가 작성한 글 수를 출력
-- inner join? left join?
select a.id, if(p.id is null, 0, count(*))
from author a left join post p on a.id = p.author_id group by a.id;

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select date_format(created_time, '%Y'), count(*) from post WHERE created_time is not null GROUP BY date_format(created_time, '%Y');
select date_format(created_time, '%Y')as year, count(*) from post WHERE created_time is not null GROUP BY year;


-- [프로그래머스] 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
    -- 내 답안 = 오답!
    SELECT CAR_TYPE, COUNT(*) as CARS
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE OPTIONS is not null
    GROUP BY CAR_TYPE
    ORDER BY CAR_TYPE ASC;
    -- 정답
    SELECT CAR_TYPE, COUNT(*) as CARS
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE OPTIONS like '%통풍시트%' OR OPTIONS like'%열선시트%' OR OPTIONS like'%가죽시트%'
    GROUP BY CAR_TYPE
    ORDER BY CAR_TYPE ASC;

-- [프로그래머스] 입양 시각 구하기(1)
    -- 내 답안 = 오답!
    SELECT date_format(DATETIME, '%h') as HOUR, COUNT(*) as COUNT
    FROM ANIMAL_OUTS
    WHERE DATETIME is not null
    GROUP BY HOUR
    ORDER BY HOUR;
    -- 정답
    SELECT DATE_FORMAT(DATETIME, '%H') as HOUR, COUNT(*)
    FROM ANIMAL_OUTS
    WHERE DATE_FORMAT(DATETIME, '%H:%i') BETWEEN '09:00' and '19:59'
    GROUP BY HOUR
    ORDER BY HOUR;

-- HAVING : group by를 통해 나온 통계에 대한 조건
    select author_id, count(*) from post group by author_id;
    -- 글을 2개 이상 쓴 사람에 대한 통계 정보
    select author_id, count(*) as count from post
    group by author_id having count >= 2;

    -- [실습] 포스팅 price가 2000원 이상인 글을 대상으로,
    --  작성자별로 몇 건인지와 평균 price를 구하되,
    -- 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
    -- 내 답변
    select count(*) as count, avg(p.price) as avg 
    from post p 
    where price >= 2000  
    group by author_id having avg >= 3000;
    -- 정답
    select author_id, avg(price) as avg 
    from post
    where price >= 2000  
    group by author_id having avg >= 3000;

    -- [프로그래머스] 동명 동물 수 찾기
    SELECT NAME, count(*) as COUNT 
    from ANIMAL_INS 
    WHERE NAME is not null
    group by NAME 
    having count >= 2 ORDER BY NAME ASC;

    -- [실습] 2건 이상의 글을 쓴 사람의 email과 글의 수를 구할건데,
    -- 나이는 25세 이상인 사람만 통계에 사용하고,
    -- 가장 나이 많은 사람 1명의 통계만 출력하시오
    SELECT a.id, count(a.id) as count
    from author a inner join post p
    on a.id = p.author_id 
    where a.age >= 25
    group by a.id having count>=2 ORDER BY max(a.age) limit 1;

-- 다중열 group by
select author_id, title, count(*) from post group by author_id, title

-- [프로그래머스]
    -- 내 답변 = 틀림!!!
    SELECT USER_ID, PRODUCT_ID 
    FROM ONLINE_SALE 
    WHERE 재구매
    GROUP BY USER_ID, PRODUCT_ID
    ORDER BY USER_ID ASC, PRODUCT_ID DESC;
    -- 정답
    SELECT USER_ID, PRODUCT_ID 
    FROM ONLINE_SALE 
    GROUP BY USER_ID, PRODUCT_ID
    HAVING COUNT(*) >= 2
    ORDER BY USER_ID ASC, PRODUCT_ID DESC;
