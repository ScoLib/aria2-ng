# Aria2 + AriaNg

本镜像包含 Aria2、AriaNg

### 开启所有功能
```bash
  docker run -d --name ariang \
  -p 6080:80 \
  -e RPC_SECRET=Hello \
  -e ARIA2_USER=user \
  -e ARIA2_PWD=pwd \
  -v /yourdata:/data \
  -v /yourconf/:/app/conf \
  scolib/aria2-ng
```

### Docker 环境变量

  * ARIA2_USER Basic Auth 用户认证用户名
  * ARIA2_PWD Basic Auth 密码
  * RPC_SECRET Aria2 RPC 加密 token


### Docker volume
  * `/data` 用来放置所有下载的文件的目录
  * `/app/conf` 该目录下可以放置你的自定义`aria2.conf`配置文件，`aria2.session`，且必须包含这两个文件。第一次使用`aria2.session`时，创建一个空文件即可，该文件会包含aria2当前的下载列表，这样即使容器被销毁也不用担心文件列表丢失了。你也可以直接拷贝当前项目下`conf`目录中的两个文件并使用。


## 自行构建镜像
```
git clone https://github.com/ScoLib/aria2-ng.git
cd aria2-ng
docker build -t aria2-ng .
```

## 访问
Aria-Ng： http://serverip:6080/


## 常见问题
  1. 当你以非其他`80` 端口运行程序时，会出现`Aria2 状态 未连接`的错误，这是因为本镜像中aria2没有使用6800端口，而是和网站同一个端口。因此你需要在 `AriaNg设置` -> 页面顶端的 `RPC`页面，将你的Aria2 RPC 地址中的端口从`80`改成你使用的正确端口。
  2. 因为 AriaNg 仅仅将设置保存在浏览器中，因为当你使用不同的浏览器，或者将浏览器清除缓存后，你都需要重新设置一次。
  3. 下载的BT或者磁力完全没有速度怎么办？ 建议先下载一个热门的BT种子文件，而不是磁力链接。这样可以帮助缓存DHT文件，渐渐地，速度就会起来了。比如试试下载树莓派操作系统的BT种子？[前往下载](https://www.raspberrypi.org/downloads/raspbian/)
