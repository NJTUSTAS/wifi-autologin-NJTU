# wifi-autologin-NJTU

## 注意

~~由于校园网登录验证切换，本库现在已经不能工作。~~
现在已经修复，可以正常使用

## 正文

用于自动连接南京工业大学校园网。本项目部分代码来源于[此项目](https://github.com/dingyang666/autologin) 。

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
  - 已经可以使用

鸣谢：

- [卢曼可](https://github.com/dingyang666)

- [杨凯](https://github.com/Secack)
