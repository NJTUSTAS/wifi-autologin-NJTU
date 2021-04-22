# 作者：丁昊（hydrogendeuterium1@gmail.com）

$username = ""
$password = ""
$channelshow = "中国移动&channel=@cmcc"
# $channel="中国电信&channel=@telecom"
# 选择不想要的注释掉。


$url='https://u.njtech.edu.cn/cas/login?service=https://u.njtech.edu.cn/oauth2/authorize?client_id=Oe7wtp9CAMW0FVygUasZ&response_type=code&state=njtech'

# 判断是否已经联网
if ((ping www.baidu.com -n 1) -match "TTL") {
    Write-Output "connect has been established already."
}
else{
    Write-Output "getting cookies..."
    
    # get response
    $tmp = curl.exe $url -c "cookie" -H 'Accept: */*' -H 'Accept-Language: zh-cn' `
        -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko'`
        -H 'Content-Type: application/x-www-form-urlencoded' -H 'Connection: keep-alive'|Out-String

    # get LT
    $tmp -match "`"lt`" value=`"LT-.*`" "
    $matches[0] -match "`"LT-[0-9]{6,8}-.*`""
    $matches[0] -match "[^`"]+"
    $LT = $matches[0]
    Write-Output "LT= $LT"

    # get EXEC
    $tmp -match "name=`"execution`" value=`".*`""
    # like: name="execution" value="e1s1"
    $matches[0] -match "value=`"`.*`""
    # like: "e1s1"
    $result = ($matches[0] -split "=")[-1]; 
    # remove quotation marks
    $result -match "[^`"]+"; $EXEC = $matches[0]
    Write-Output "EXEC= $EXEC"

    $cookie = Get-Content cookie

    # get insert_cookie
    $insert_cookie = ($cookie -match "INSERT_COOKIE" -split "\t")[-1]
    Write-Output "INSERT_COOKIE= $insert_cookie"

    #get JsessionID
    $jsessionid = ($cookie -match "JSESSIONID" -split "\t")[-1]
    Write-Output "JsessionID= $jsessionid"

    $DATA = "username=$username&password=$password&channelshow=$channelshow&lt=$LT&execution=$EXEC&_eventId=submit&login=%E7%99%BB%E5%BD%95"
    Write-Output "DATA= $DATA"

    $DATA2 = "Cookie: JSESSIONID=$jsessionid; insert_cookie=$insert_cookie"
    Write-Output "DATA2= $DATA2"

    curl.exe $url -H 'Accept: */*' -H 'Accept-Language: zh-cn' `
        -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko' `
        -H 'Content-Type: application/x-www-form-urlencoded' `
        -H 'Connection: keep-alive' `
        -H "$DATA2"  `
        --data "$DATA">ret.html
    Write-Output "connect established."
}