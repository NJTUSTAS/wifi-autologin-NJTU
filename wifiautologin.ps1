# 作者：丁昊（hydrogendeuterium1@gmail.com）

$username = ""
$password = ""
$channelshow = "中国移动&channel=@cmcc"
# $channel="中国电信&channel=@telecom"
# 选择不想要的注释掉。


$url='https://u.njtech.edu.cn/cas/login?service=https://u.njtech.edu.cn/oauth2/authorize?client_id=Oe7wtp9CAMW0FVygUasZ&response_type=code&state=njtech'
if (!((ping www.baidu.com) -match "TTL")) {
    # 验证有网络
    echo "getting cookies"
    rm tmp
     curl.exe $url -c "cookie" -H 'Accept: */*' -H 'Accept-Language: zh-cn' `
        -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko'`
        -H 'Content-Type: application/x-www-form-urlencoded' -H 'Connection: keep-alive'>>tmp
    $tmp = cat tmp

    # get LT
    ($tmp -match "`"lt`" value=`"LT-.*`"")[0] -match "`"LT-[0-9]{6}-.*`""
    $result = $matches[0]; $result -match "[^`"]+"; $LT = $matches[0]
    echo "LT= $LT"

    # get EXEC
    ($tmp -match "name=`"execution`"")[0] -match "value=`"`.*`""
    $result = ($matches[0] -split "=")[-1]; $result -match "[^`"]+"; $EXEC = $matches[0]
    echo "EXEC= $EXEC"

    $cookie = cat cookie

    # get insert_cookie
    $insert_cookie = ($cookie -match "INSERT_COOKIE" -split "\t")[-1]
    echo "INSERT_COOKIE= $insert_cookie"

    #get JsessionID
    $jsessionid = ($cookie -match "JSESSIONID" -split "\t")[-1]
    echo "JsessionID= $jsessionid"

    $DATA = "username=$username&password=$password&channelshow=$channelshow&lt=$LT&execution=$EXEC&_eventId=submit&login=%E7%99%BB%E5%BD%95"
    echo "DATA= $DATA"

    $DATA2 = "Cookie: JSESSIONID=$jsessionid; insert_cookie=$insert_cookie"
    echo "DATA2= $DATA2"

    curl.exe $url -H 'Accept: */*' -H 'Accept-Language: zh-cn' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Connection: keep-alive' -H "$DATA2"  --data "$DATA"

    echo "connect established."
}
else {
    echo "connect has been established already."
}