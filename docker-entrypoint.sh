# MySQLコンテナの起動を最大約60秒WAITする。
conn_established=0
for _ in `seq 1 60`
do
    mysql -uroot -ppassword -h ${MYSQL_PORT_3306_TCP_ADDR} -e "SELECT 1 FROM dual;" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        conn_established=1
        break
    fi
    sleep 1
done

if [ $conn_established -eq 1 ]; then
    python3 ${DEPLOY_DIR}/manage.py migrate
    python3 ${DEPLOY_DIR}/manage.py runserver 0.0.0.0:8000
else
    echo "【Error】60秒間MySQLサーバーに接続できませんでした。"
fi