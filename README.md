# docker-for-mac-ros
## 必要なソフト
* [Docker for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
* [Xquartz](https://www.xquartz.org)
    * DockerコンテナからGUIを表示するのに必要らしい。
    * 起動したら環境設定->セキュリティと進んでネットワーク・クライアントからの接続を許可にチェックを入れて、アプリを再起動。
* https://qiita.com/ryo_21/items/4e0006adcb300173acda が参考になる。

## build Docker image
```bash
cd docker-for-mac-ros
docker build -t <tag for docker image> .
```

## and then...
```bash
open -a Xquartz
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
echo $ip
xhost + $ip
docker run --rm -e DISPLAY=$ip:0 --name ros-test <tag for docker image> roscore
```
別のターミナルで、
```
docker exec -it ros-test bin/bash
# コンテナ内に入る
source opt/ros/melodic/setup.bash
rosrun turtlesim turtlesim_node
```
これで亀さんが出てくる。
さらに別のターミナルで、
```
docker exec -it ros-test bin/bash
# コンテナ内に入る
source opt/ros/melodic/setup.bash
rosrun turtlesim turtle_teleop_key
```
十字キーで先ほどの亀さんを動かせるようになる。
# reference
* https://qiita.com/ryo_21/items/4e0006adcb300173acda