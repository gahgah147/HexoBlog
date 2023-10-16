---
title: Docker 容器操作
date: 2023-10-16 14:23:09
tags: Docker
---

Docker 進入容器 

以下文章是在使用 Docker 時查詢到的好文章 我覺得[這篇](https://philipzheng.gitbook.io/docker_practice/)記錄的很詳細，所以記錄一下

# exec 命令
docker exec 是Docker內建的命令。下面示範如何使用該命令。
```
$ sudo docker run -idt ubuntu
243c32535da7d142fb0e6df616a3c3ada0b8ab417937c853a9e1c251f499f550
$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
243c32535da7        ubuntu:latest       "/bin/bash"         18 seconds ago      Up 17 seconds                           nostalgic_hypatia
$sudo docker exec -ti nostalgic_hypatia bash
root@243c32535da7:/#
```

# attach 命令
docker attach 亦是Docker內建的命令。下面示例如何使用該命令。
```
$ sudo docker run -idt ubuntu
243c32535da7d142fb0e6df616a3c3ada0b8ab417937c853a9e1c251f499f550
$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
243c32535da7        ubuntu:latest       "/bin/bash"         18 seconds ago      Up 17 seconds                           nostalgic_hypatia
$sudo docker attach nostalgic_hypatia
root@243c32535da7:/#
```
按下 ctrl + P 然後 ctrl + Q 跳離容器，讓它繼續在背景執行。
但是使用 attach 命令有時候並不方便。當多個視窗同時 attach 到同一個容器的時候，所有視窗都會同步顯示。當某個視窗因命令阻塞時,其他視窗也無法執行操作了。

# nsenter 命令

## 安裝
nsenter 工具已含括在 util-linux 2.23 後的版本內。 如果系統中 util-linux 包沒有該命令，可以按照下面的方法從原始碼安裝。

```
$ cd /tmp; curl https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz | tar -zxf-; cd util-linux-2.24;
$ ./configure --without-ncurses
$ make nsenter && sudo cp nsenter /usr/local/bin
```

## 使用
nsenter 可以存取另一個程式的命名空間。nsenter 要正常工作需要有 root 權限。 很不幸，Ubuntu 14.4 仍然使用的是 util-linux 2.20。安裝最新版本的 util-linux（2.24）版，請按照以下步驟：
```
$ wget https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz; tar xzvf util-linux-2.24.tar.gz
$ cd util-linux-2.24
$ ./configure --without-ncurses && make nsenter
$ sudo cp nsenter /usr/local/bin
```

為了連線到容器，你還需要找到容器的第一個程式的 PID，可以透過下面的命令取得。
```
PID=$(docker inspect --format "{{ .State.Pid }}" <container>)
```
透過這個 PID，就可以連線到這個容器：
```
$ nsenter --target $PID --mount --uts --ipc --net --pid
```
下面給出一個完整的例子。
```
$ sudo docker run -idt ubuntu
243c32535da7d142fb0e6df616a3c3ada0b8ab417937c853a9e1c251f499f550
$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
243c32535da7        ubuntu:latest       "/bin/bash"         18 seconds ago      Up 17 seconds                           nostalgic_hypatia
$ PID=$(docker-pid 243c32535da7)
10981
$ sudo nsenter --target 10981 --mount --uts --ipc --net --pid
root@243c32535da7:/#
```
更簡單的，建議大家下載 .bashrc_docker，並將內容放到 .bashrc 中。
```
$ wget -P ~ https://github.com/yeasy/docker_practice/raw/master/_local/.bashrc_docker;
$ echo "[ -f ~/.bashrc_docker ] && . ~/.bashrc_docker" >> ~/.bashrc; source ~/.bashrc
```
這個檔案中定義了很多方便使用 Docker 的命令，例如 docker-pid 可以取得某個容器的 PID；而 docker-enter 可以進入容器或直接在容器內執行命令。
```
$ echo $(docker-pid <container>)
$ docker-enter <container> ls
```


參考文章: https://philipzheng.gitbook.io/docker_practice/container/enter