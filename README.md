# wifi-autologin-NJTU

用于自动连接南京工业大学校园网。本项目直接起源于https://github.com/dingyang666/autologin。

- sh 文件，主要目标是路由器用。配置方法：

```shell
  #需要提前手动设置账号密码和运营商。
 mv wifiautologin.sh /etc/
 chmod 755 /etc/wifiautologin.sh
 echo 'nohup /etc/wifiautologin.sh &' >> /etc/profile #设置登陆后自动后台运行
```

- py 文件 主要用于无路由器的情况下 win 电脑使用。
  - 配置任务计划程序在 windows 连接无线局域网时运行目标文件
  - 需要安装解释器，或者打包为 exe 文件（可以使用 pyinstaller）使用。
- ps1 文件 解决 win 平台无法使用 sh 的问题。
  - 还没写

鸣谢：
- [卢曼可](https://github.com/dingyang666)

- [杨凯](https://github.com/Secack)

  