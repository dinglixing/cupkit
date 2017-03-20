## Cupkee Clinet

cupkee-cli 是cupkee开发环境客户端，它被设计用来帮助开发者:

1. 快速建立用于嵌入式开发的交叉编译环境

2. 快速初始化，及构建应用项目

<!-- more -->

```
关于[cupkee](https://github.com/cupkee/cupkee):

cupkee是一个C语言编写的微型操作系统，它专门设计用于微控制器硬件板。

cupkee建立了一个类似node的运行环境，在内部包含一个简化的javascript解释器作为shell。

cupkee为硬件板提供了即时交互的能力，开发者可以随时对硬件编程并获得即时响应。
```

## 依赖

* Docker: 17.03.0或更新的版本
* Git:    2.10.1或更新的版本

    较老的版本未经过测试

## 安装

```
$ git clone https://github.com/cupkee/cupkee-cli.git ~/.cupkee-cli
$ cd ~/.cupkee-cli && setup.sh
```

## 创建cupkee app项目

```
$ cd your_working_path
$ cupkee init your_project
```

## 编译cupkee app

```
// in your project
$ cupkee build BOARD=stm32f103 // BOARD=target
```

