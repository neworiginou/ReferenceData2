## FamilyEducationApp
> ####开发环境:xcode 7.1 /ios >= 8.0
###项目简介
>框架采用MVC结构。按功能界面划分。
Model存放对应功能模块的数据模型
View存放对应功能界面的View视图和重定义视图
Controller存放对应功能视图的视图控制器。

![frame](https://github.com/mgoofyy/FamilyEducationApp/blob/master/img/frame.png)
####项目展示图片
启动图片
![launch](https://github.com/mgoofyy/FamilyEducationApp/blob/master/img/launch.gif)
#####Other目录存放内容
	AppDelegate.swift
	以及swift oc桥接头文件
	系统的一些单例数据 
		DeviceData.swift
	Extension
		用户自定义的一些公共的类拓展。
		
#####外部引入的一些框架
* MJRefresh
* AFNetWorking
* MJExtension
等等

#####项目注意事项
	图片暂时未归类。使用较多的和 尺寸较为规范的 @2x 和 @3x 放入Assets.xcassets
	测试图片暂时放入ImageE目录 图片格式规定注明@2x 和 @3X
	程序支持CoreData本地持久数据化存储，加载网络数据采用 异步多线程网络请求，经常使用的数据需加入缓存
#####自定义视图
* 自定义消息显示
文件CustomFrauleinViewCell.swift 自适应高度，假如NSCache缓存，滑动不会出现内存暴增
图片展示


![cell](https://github.com/mgoofyy/FamilyEducationApp/blob/master/img/customcell.png)
* 自定义聊天
	UUChat StoryBoard布局。之前github一个大牛写的。可以直接拿来用的。用的时候把UUchat拖过去和storyBoard文件拖过去。做好关联即可
	图片展示

![cell](https://github.com/mgoofyy/FamilyEducationApp/blob/master/img/customchat.png)
* 自定义课程表视图
	这个是用贝塞尔曲线画出来的。当然也会有其他的方法。小编goofyy就抛砖引玉啦。大家尽管自己根据自己的想法尽管做。
	图片展示

	![cell](https://github.com/mgoofyy/FamilyEducationApp/blob/master/img/customClass.png)
	

#### License

本项目采用 MIT license 开源，你可以利用采用该协议的代码做任何事情，只需要继续继承 MIT 协议即可。

