//
//  KJEmitterHeader.h
//  KJEmitterDemo
//
//  Created by 杨科军 on 2018/11/26.
//  Copyright © 2018 杨科军. All rights reserved.
/*------------- 本人其他库 -------------
 实用又方便的Category和自定义控件(Switch、选择控件等等)
 pod 'KJEmitterView'
 pod 'KJEmitterView/Function'#
 pod 'KJEmitterView/Control' # 自定义控件
 
 播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
 - 视频可以边下边播，把播放器播放过的数据流缓存到本地，下次直接从缓冲读取播放
 pod 'KJPlayer'  # 播放器功能区
 pod 'KJPlayer/KJPlayerView'  # 自带展示界面
 
 轮播图 - 支持缩放 多种pagecontrol 支持继承自定义样式 自带网络加载和缓存
 pod 'KJBannerView'  # 轮播图，网络图片加载 支持网络GIF和网络图片和本地图片混合轮播
 
 加载Loading - 多种样式供选择 HUD控件封装
 pod 'KJLoadingAnimation' # 加载控件
 
 菜单控件 - 下拉控件 选择控件
 pod 'KJMenuView' # 菜单控件
 
 Github地址：https://github.com/yangKJ
 简书地址：https://www.jianshu.com/u/c84c00476ab6
 博客地址：https://blog.csdn.net/qq_34534179
 
 ####版本更新日志:
 #### Add 4.5.3
 1、UIImage+KJProcessing 新增 kj_jointImageWithMasterImage 拼接图片
 2、UIImage+KJProcessing 新增 kj_imageCompoundWithLocalImage 图片多次合成处理
 3、UIImage+KJProcessing 新增 kj_rotationImageWithOrientation 图片旋转
 
 #### Add 4.5.2
 1、NSArray+ElementDeal 新增对数组元素的处理 包括排序、查找、去重等等
 2、整理富文本扩展 UILabel+KJAttributedString
 
 #### Add 4.4.6
 1、UIImage+KJFrame 新增 kj_mergeImageWithFirstImage 合并两张图片 和 kj_waterMark 给图片添加水印
 2、宏 _KJMacros 中新增 FORMAT 字符串拼接-其他类型转字符串 和 VD_MULTILINE_TEXTSIZE 计算文字尺寸text size(文字尺寸)
 
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
 */

#ifndef KJEmitterHeader_h
#define KJEmitterHeader_h

/// 宏
#import "_KJMacros.h"

/******************* Kit ******************************/
#import "UIButton+KJBlock.h" // 点击事件ButtonBlock
#import "UIButton+KJEnlargeTouchArea.h" // 改变UIButton的响应区域
#import "UIButton+KJButtonContentLayout.h"  // 图文混排

#import "UILabel+KJAttributedString.h" // 富文本

#import "UIView+KJXib.h"   // Xib
#import "UIView+KJFrame.h" // Frame - 轻量级布局
#import "UIView+KJRectCorner.h" // 切圆角 - 渐变
#import "UIView+KJGestureBlock.h" // 手势Block
//#import "UIView+KJAppointView.h"  // 画一些指定图形（直线、虚线、五角星、六边形、八边形）

//#import "UINavigationBar+KJExtension.h" // 设置NavigationBar背景
#import "UIBarButtonItem+KJExtension.h" // 设置BarButtonItem

#import "UITextView+KJPlaceHolder.h"  // 输入框扩展
#import "UITextView+KJLimitCounter.h" // 限制字数

#import "UIImage+KJProcessing.h"  /// 图片加工处理相关
//#import "UIImage+KJFloodFill.h" /// 图片泛洪算法
//#import "UIImage+KJFilter.h"    /// 处理图片滤镜，渲染相关

/******************* Foundation ******************************/
//#import "NSArray+ElementDeal.h"  /// 对数组元素的处理 包括排序、查找、去重等等

#endif /* KJEmitterHeader_h */
