while true; do
    # 사용자가 product를 입력할 때마다, 현재시간을 score로 해서 zadd
    echo "원하는 상품 입렵 또는 나가기(exit)"
    read product

done

echo "사용자의 최근 본 상품 목록 : "