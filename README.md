# KJEmitterView
![coverImage](https://raw.githubusercontent.com/yangKJ/CommonDatas/master/CommonDatas/Res/coverImage.jpg)

* 这个工程提供了一些iOS开发中用到的类目，方便开发
* 这里有我经常用到的一些扩展，方便好用开发
* 整理一些好用的自定义控件，部分数据来源于网络 

----------------------------------------
### 框架整体介绍
* [作者信息](#作者信息)
* [作者其他库](#作者其他库)
* [功能介绍](#功能介绍)
* [Cocoapods安装](#Cocoapods安装)
* [更新日志](#更新日志)
* [效果图](#效果图)
* [打赏作者 &radic;](#打赏作者)

----------------------------------------

#### <a id="作者信息"></a>作者信息
> Github地址：https://github.com/yangKJ  
> 简书地址：https://www.jianshu.com/u/c84c00476ab6  
> 博客地址：https://blog.csdn.net/qq_34534179  


#### <a id="作者其他库"></a>作者其他Pod库
```
播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
pod 'KJPlayer'  # 播放器功能区
pod 'KJPlayer/KJPlayerView'  # 自带展示界面

实用又方便的Category和一些自定义控件
pod 'KJEmitterView'
pod 'KJEmitterView/Function'#
pod 'KJEmitterView/Control' # 自定义控件

轮播图 - 支持缩放 多种pagecontrol 支持继承自定义样式 自带网络加载和缓存
pod 'KJBannerView'  # 轮播图，网络图片加载

菜单控件 - 下拉控件 选择控件
pod 'KJMenuView' # 菜单控件

加载Loading - 多种样式供选择
pod 'KJLoadingAnimation' # 加载控件

```

##### Issue
如果您在使用中有好的需求及建议，或者遇到什么bug，欢迎随时issue，我会及时的回复，有空也会不断优化更新这些库

#### <a id="Cocoapods安装"></a>Cocoapods安装
```
pod 'KJEmitterView'
pod 'KJEmitterView/Control' # 自定义控件
```

#### <a id="更新日志"></a>更新日志
```
####版本更新日志:
#### Add 4.5.0
1、NSArray+ElementDeal 新增对数组元素的处理 包括排序、查找、去重等等
2、整理富文本扩展 UILabel+KJAttributedString

#### Add 4.4.5
1、修改bug，修改更明显的提示内容

#### Add 4.3.9
1、修改Bug
2、NSMutableArray当中新增 处理空对象方法交换
3、Function文件夹中新增 NSString+KJStringDebug 解决字典 或者 数组 每次都崩溃到 Main函数，无法定位到位置的问题

#### Add 4.3.8
1、Function文件夹中新增 NSDictionary+KJNilSafe 字典防止键和值为空的时候崩溃
2、Function文件夹中新增 NSArray+KJOverstep 数组解决数组越界异常崩溃问题
3、Function文件夹中新增 NSNull+KJSafe 解决后台返回数据为空造成程序崩溃

#### Add 4.3.7
1、新增画一些指定图形 UIView+KJAppointView （直线、虚线、五角星、六边形、八边形）

#### Add 4.3.5
1、新增改变UIButton的响应区域 扩大点击域 UIButton+KJEnlargeTouchArea
2、重新将宏转移到 _KJMacros 文件
3、全部文件都引入 NS_ASSUME_NONNULL_BEGIN 宏
4、UIView+KJXib 新增高效查找子视图方法 kj_FindSubviewRecursively

#### Add 4.3.3
1、修改单例宏  kSingletonImplementation_H
2、添加一些宏的高级用法
3、新增手势Block UIView+KJGestureBlock

#### Add 4.3.0
1、KJMacros 重新整理放入 KJEmitterHeader当中
2、KJEmitterHeader 新增一些好用的方法

#### Add 4.2.2
1、引入自己常用宏 KJMacros

#### Add 4.2.1
1、暂时移出UIView+KJXib中布局相关
2、移出UINavigationController+FDFullscreenPopGesture
3、默认只引入Kit里面的文件
4、重新整理Control、Classes和Foundation独立为文件夹

#### Add 4.1.0
1、整理新增控件类 Control
2、KJSelectControl   自定义一款动画选中控件
3、KJSwitchControl   自定义一款可爱的动画Switch控件
4、KJMarqueeLabel    自定义一款跑马灯Label
5、UINavigationController+FDFullscreenPopGesture 侧滑返回扩展

##### Add 4.0.0
1、加入弱引用宏 kWeakObject 和 kStrongObject
2、新增扩展 UIButton+KJBlock 点击事件ButtonBlock
3、新增扩展 UILabel+KJAttributedString   富文本
4、UIView+KJFrame   新增一些轻量级布局链式属性
5、UIView+KJRectCorner  新增方法  虚线边框  kj_DashedLineColor


备注：部分资料来源于网络～  就不一一指出道谢，整理起来方便自己和大家使用
```

#### <a id="打赏作者"></a>打赏作者
* 如果你觉得有帮助，还请为我Star
* 如果在使用过程中遇到Bug，希望你能Issues，我会及时修复
* 大家有什么需要添加的功能，也可以给我留言，有空我将补充完善
* 谢谢大家的支持 - -！

[![LOGO](https://github.com/yangKJ/KJPlayerDemo/blob/master/KJPlayerDemo/Demo/Assets.xcassets/AppIcon.appiconset/WechatIMG57486iPhoneSpootlight7_40pt@3x.png?raw=true)](https://www.jianshu.com/u/c84c00476ab6)

[![谢谢老板](https://raw.githubusercontent.com/yangKJ/CommonDatas/master/CommonDatas/Money/77%E3%80%82/All.png)](https://github.com/yangKJ/KJPlayerDemo)


#### 救救孩子吧，谢谢各位老板～～～～

