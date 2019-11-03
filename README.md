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

しかし、亀さん🐢は表示できても、rvizを立ち上げようとすると以下のエラーが出てしまう。
```
root@6e71b34bae6f:/# rviz 
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
[ INFO] [1569895993.768481400]: rviz version 1.13.4
[ INFO] [1569895993.768740100]: compiled against Qt version 5.9.5
[ INFO] [1569895993.768873700]: compiled against OGRE version 1.9.0 (Ghadamon)
[ INFO] [1569895993.784786100]: Forcing OpenGl version 0.
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
Segmentation fault
root@6e71b34bae6f:/# rviz 
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
[ INFO] [1569896001.332680500]: rviz version 1.13.4
[ INFO] [1569896001.332799600]: compiled against Qt version 5.9.5
[ INFO] [1569896001.332860800]: compiled against OGRE version 1.9.0 (Ghadamon)
[ INFO] [1569896001.347868300]: Forcing OpenGl version 0.
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
Segmentation fault
```
VNCを使う方法( https://github.com/bpinaya/robond-docker )で一応RvizとGazeboは動いたが、遅すぎてもはやバーチャルマシンの方が速そうだった。

# reference
* OS-1 ROS Package Deployment with Docker https://www.wilselby.com/2019/05/os-1-ros-package-deployment-with-docker/
* Docker for MacでROSの亀さんと戯れた https://qiita.com/ryo_21/items/4e0006adcb300173acda
* Dockerを使用してPepperをROSで動かす手順（Mac・Ubuntu対応） https://qiita.com/ykoga/items/1ffe02c9cd4af42e4200
* http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration
* https://github.com/bpinaya/robond-docker
* https://stackoverflow.com/questions/40597959/running-gui-from-a-container-on-a-mac-resolve-in-libgl-error-no-matching-fbcon
* https://heptech.wpblog.jp/2017/02/26/solution-to-fix-opengl-issue-on-recent-xquartz/
* https://qiita.com/cielavenir/items/89881e46ed69785fec6c
* https://kokensha.xyz/docker/access-headless-docker-linux-desktop-container-via-vnc/

* https://medium.com/@viirya/setting-up-linux-gui-container-on-mac-728194b20e78
* https://hub.docker.com/r/ct2034/vnc-ros-kinetic-full/
