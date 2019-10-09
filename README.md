# Aria2 + AriaNg

本镜像包含 Aria2、AriaNg

### 开启所有功能
```bash
  docker run -d --name ariang \
  -p 6080:6080 \
  -p 6800:6800 \
  -e ENABLE_AUTH=true \
  -e RPC_SECRET=Hello \
  -e ARIA2_USER=user \
  -e ARIA2_PWD=pwd \
  -v /yourdata:/data \
  -v /yourconf/:/app/conf \
  scolib/aria2-ng
```

### Docker 环境变量

  * ENABLE_AUTH 启用 Basic auth(网页简单认证) 用户认证
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
