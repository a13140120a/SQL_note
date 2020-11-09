# docker 安裝(Centos7)

* 反安裝舊版docker
```js
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
```

* 安裝docker(centos7)  
```js
sudo curl -sSL https://get.docker.com | sh
```
* 安裝完成之後，需要重新開機  
`reboot`
* 啟動docker  
```js
sudo systemctl start docker
sudo systemctl enable docker
```
* 安裝git  
```js
yum install git
```
* 安裝docker-compose  

```js
yum install epel-release
```
```js
curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -
s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
* 更改權限
```js
chmod +x /usr/local/bin/docker-compose
```
* 將帳號加入 docker 群組
```js
sudo usermod -aG docker USERNAME
```

* 基本操作
  * 列出所有的容器 ID
  ```js
  docker ps -aq
  ```
  * 停止所有的容器
  ```js
  docker stop $(docker ps -aq)
  ```
  * 删除所有的容器
  ```js
  docker rm $(docker ps -aq)
  ```
  * 删除所有的image
  ```js
  docker rmi $(docker images -q)
  ```
  * 複製文件
  ```js
  docker cp mycontainer:/opt/file.txt /opt/local/
  docker cp /opt/local/file.txt mycontainer:/opt/
  ```














