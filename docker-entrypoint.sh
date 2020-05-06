function create_django_superuser() {
    expect -c "
spawn python3 ${DEPLOY_DIR}/manage.py createsuperuser
expect \"ユーザー名 (leave blank to use 'root'):\"
send \"admin\n\"
expect \"メールアドレス:\"
send \"admin@example.com\n\"
expect \"Password:\"
send \"password\n\"
expect \"Password (again):\"
send \"password\n\"
expect \"Bypass password validation and create user anyway? \\\\\[y/N\\\\\]:\"
send \"y\n\"
expect \"Superuser created successfully.\"
exit 0
"    
}

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
    create_django_superuser
    python3 ${DEPLOY_DIR}/manage.py runserver 0.0.0.0:8000
else
    echo "【Error】60秒間MySQLサーバーに接続できませんでした。"
fi