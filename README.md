## Cupkee Clinet

cupkit 是定制cupkee系统固件的客户端，它被设计用来帮助开发者:

1. 创建目标板的cupkee系统定制代码

1. 提供通用的交叉编译环境


<!-- more -->

```
关于[cupkee](https://github.com/cupkee/cupkee):

cupkee是一个C语言编写的微型操作系统，它专门设计用于微控制器硬件板。

cupkee建立了一个类似node的运行环境，在内部包含一个简化的javascript解释器作为shell。

cupkee为硬件板提供了即时交互的能力，开发者可以随时对硬件编程并获得即时响应。
```

## 依赖

* Docker: 17.03.0或更新的版本

    较老的版本未经过测试

## 安装

```
$ git clone https://github.com/cupkee/cupkit.git ~/.cupkit
$ cd ~/.cupkit && setup.sh
```

## 为你的目标板创建cupkee操作系统

```
$ cd your_working_path
$ cupkee init your_project
```

## 编译cupkee操作系统

```
// in your_project_path
$ cupkit build CPU=stm32f103 atom // BOARD=target
```

## 其他

1. 对于中国大陆用户，从docker hub下载的速度较慢。建议配置国内的镜像服务器：
  * ustc: https://docker.mirrors.ustc.edu.cn
  * aliyun: https://{your_id}.mirror.aliyuncs.com  (需要向aliyun注册获取ID)

2. 对于Ubuntu系统等linux系统，首先应将用户加入到docker组中，否则需要采用sudo执行docker命令。
    ```
    $ gpasswd -a ${USER} docker
    ```
