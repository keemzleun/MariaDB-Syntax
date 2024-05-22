# local에서 sql 덤프 파일 생성
mysqldump -u [username] -p [database_name] > dumpfile.sql
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql

# 한글 깨질 때
mysqldump -u root -p board -r > dumpfile.sql

# 리눅스에서 mariadb 서버 설치
docker exec -it a7dc82df0e7e /bin/bash
sudo apt-get install mariadb-server

# mariadb 실행
sudo systemctl start mariadb

# mariadb 접속 테스트
sudo mariadb -u root -p

# git 설치
sudo apt install git

# git을 통해 repo clone
git clone 레파지토리 주소

mysql -u root -p board -r < dumpfile.sql