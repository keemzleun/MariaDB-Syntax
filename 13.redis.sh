sudo apt-get update
sudo apt-get install redis-server
redis-server --version

#레디스 접속
#cli : commandline interface
redis-cli

#redis는 0~15번까지의 database구성
#데이터베이스 선택
select 번호(0번디폴트)

#데이터베이스내 모든 키 조회
keys *

#일반 String 자료구조
#key:value 값 세팅
#key값은 중복되면 안됨
SET key(키) value(값)
set test_key1 test_value1
set user:email:1 hongildong@naver.com
# set할때 key값이 이미 존재하면 덮어쓰기 되는것이 기본
# 맵저장소에서 key값은 유일하게 관리가 되므로
#nx : not exist
set user:email:1 hongildong2@naver.com nx
#ex(만료시간-초단위) - ttl(time to live)
set user:email:2 hong2@naver.com ex 20

#get을통해 value값 얻기
get test_key1

#특정 key삭제
del user:email:1
#현재 데이터베이스 모든 key값 삭제
flushdb

#좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 #특정 key값의 value를 1만큼 증가
decr likes:posting:1
get likes:posting:1

#재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock
#bash쉘을 활용하여 재고감소 프로그램 작성
14.redis_stock.sh

# 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis 캐싱 : json 데이터 형식으로 저장
set user:1:detail "{\"name\":\"hong\", \"email\":\"kim@naver.com\", \"age:20\"}" ex 10

# list
# redis의 list는 java의 deque와 같은 구조 즉, double-ended queue 구조

# 데이터 왼쪽 삽입
LPUSH my_key my_value
# 데이터 오른쪽 삽입
RPUSH my_key my_value
# 데이터 왼쪽부터 꺼내기
LPOP my_key
# 데이터 오른쪽부터 꺼내기

lpush kimjieuns kim1
lpush kimjieuns kim2
lpush kimjieuns kim3
lpop kimjieuns

# 꺼내서 보기만 하기(제거X)
lrange kimjieuns -1 -1  # 왼쪽? 오른쪽?
lrange kimjieuns 0 0    # 오른쪽? 왼쪽?


# 데이터 개수 조회
llen my_key
# list의 요소 조회시에는 범위 지정
lrange kimjieuns 0 -1 # 처음부터 끝까지
# start부터 end까지 조회(0부터 시작)
lrange my_key start end
# ttl 적용
expire kimjieuns 20
# ttl 조회
ttl kimjieuns

# pop과 push 동시에(A리스트에서 빼서 B리스트에 넣기)
RPOPLPUSH A리스트 B리스트

# 최근 방문한 페이지
# 5개 정도 데이터 push
# 최근 방문한 페이지 3개 정도만 보여주는
rpush pages page1
rpush pages page2
rpush pages page2
rpush pages page4
rpush pages page5

rpop pages
rpop pages
rpop pages

# 위 방문 페이지에서 5개에서 뒤로가기 앞으로가기 구현
# 뒤로 가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 다시 앞으로 가기 누르면 앞으로 간 페이지가 뭔지 출력
    rpush forwards page1
    rpush forwards page2
    rpush forwards page3
    rpush forwards page4
    rpush forwards page5
    lrange forwards -1 -1
    rpoplpush fowards backwards
    # 실습 실패 !!!! lpop이 없음


# set 자료구조
# set 자료구조에 멤버 추가
sadd members member1
sadd members member1
sadd members member2

# set 조회
smembers members  # 중복 제거돼서 조회됨
# set에서 멤버 삭제
srem members member1
# set 멤버 개수 반환
scard members
# 특정 멤버가 set 안에 있는지 존재 여부 확인(있으면 1, 없으면 0 반환)
sismember members member3

# 어떤 목적으로 사용될 수 있을까?
# 매일 방문자수 계산할 때(중복 제거해서 세기)
sadd visit:2024-05-27 kim1@naver.com


# zset(sorted set)
# zset 자료구조에 멤버 추가(우선순위 부여)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zmembers 0 -1
# score 기준 내림차순 정렬
zrevrange zmembers 0 -1

# zset 삭제
zrem zmembers member2
# zrank는 해당 멤버가 index 몇번째인지 출력
zrank zmembers member2

# 최근 본 상품목록(-> 중복 제거 못함) => sorted set(zset)을 활용하는 것이 적절
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192420 orange
zadd recent:products 192430 apple

zrevrange recent:products 0 2
# apple (값이 높은 마지막 apple만 살아 남음)
# orange
# banana


# hashes
# 해당 자료구조에서는 문자, 숫자가 구분
hset key------ value---------------------------
               key- value-
hset product:1 name "apple" price 1000 stock 50
hget product:1 price
# 모든 객체값 get
hgetall product:1
# 특정 요소값 수정
hset product:1 stock 40

# 특정 요소의 값을 증가/감소
hincrby product:1 stock 5  # 5 증가
hincrby product:1 stock -10  # 10 감소