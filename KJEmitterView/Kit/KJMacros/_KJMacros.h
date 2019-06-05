//
//  _KJMacros.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

#ifndef _KJMacros_h
#define _KJMacros_h

#pragma mark - ////////////////////////////// 宏相关 //////////////////////////////

#pragma mark ********** 1.缩写 ************
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow // KeyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate  // AppDelegate
#define kNotificationCenter [NSNotificationCenter defaultCenter] // 通知中心

#pragma mark ********** 2.自定义高效率的 NSLog ************
#ifdef DEBUG // 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] 😎😎 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#pragma mark ********** 3.弱引用   *********
#define WEAKSELF  __weak __typeof(&*self) weakSelf = self;
#define _weakself __weak typeof(self) weakself = self

// 推荐使用（摘自YYKit）
/**
 Synthsize a weak or strong reference.
 
 Example:
 @kWeakObject(self)
 [self doSomething^{
 @kStrongObject(self)
 if (!self) return;
 ...
 }];
 */
#ifndef kWeakObject
#if DEBUG
#if __has_feature(objc_arc)
#define kWeakObject(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define kWeakObject(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define kWeakObject(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define kWeakObject(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef kStrongObject
#if DEBUG
#if __has_feature(objc_arc)
#define kStrongObject(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define kStrongObject(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define kStrongObject(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define kStrongObject(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#pragma mark ********** 4.判断字符串、数组、字典、对象为空   *********
// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
// 字符串转换为非空
#define kStringChangeNotNil(str) (str ? : @"")

#pragma mark ********** 5.iPhoneX系列尺寸布局   *********
// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
// tabBar height
#define kTABBAR_HEIGHT (iPhoneX ? (49.f+34.f):49.f)
// statusBar height.
#define kSTATUSBAR_HEIGHT (iPhoneX ? 44.0f : 20.f)
// navigationBar height.
#define kNAVIGATION_HEIGHT (44.f)
// (navigationBar + statusBar) height.
#define kSTATUSBAR_NAVIGATION_HEIGHT (iPhoneX ? 88.0f : 64.f)
// 没有tabar 距 底边高度
#define kBOTTOM_SPACE_HEIGHT (iPhoneX ? 34.0f : 0.0f)
// 屏幕尺寸
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
// AutoSize
#define kAutoW(r)   (r * kScreenW / 375.0)
#define kAutoH(r)   (r * kScreenH / 667.0)

#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenMaxLength (MAX(kScreenW, kScreenH))
#define kScreenMinLength (MIN(kScreenW, kScreenH))
#define kISiPhone5 (kISiPhone && kScreenMaxLength == 568.0)
#define kISiPhone6 (kISiPhone && kScreenMaxLength == 667.0)
#define kISiPhone6P (kISiPhone && kScreenMaxLength == 736.0)
#define kISiPhoneX (kISiPhone && kScreenMaxLength == 812.0)
#define kISiPhoneXr (kISiPhone && kScreenMaxLength == 896.0)
#define kISiPhoneXX (kISiPhone && kScreenMaxLength > 811.0)


/// 支持横屏可以用下面的宏
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define kLandscapeScreenW    ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define kLandscapeScreenH    ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define kLandscapeScreenSize ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define kLandscapeScreenW    [UIScreen mainScreen].bounds.size.width
#define kLandscapeScreenH    [UIScreen mainScreen].bounds.size.height
#define kLandscapeScreenSize [UIScreen mainScreen].bounds.size
#endif

#pragma mark ********** 6.颜色和图片相关   *********
#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]  // rgb颜色+透明度
#define UIColorHexFromRGB(hex)    UIColorFromHEXA(hex,1.0)
#define RandomColor        [UIColorcolorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]  /// 随机颜色
/** 设置图片 */
#define kGetImage(imageName) ([UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]])

#pragma mark ********** 7.方法    *********
// 属性快速声明（建议使用代码块）
#define kPropertyString(name) @property(nonatomic,copy)NSString *name
#define kPropertyAssign(name) @property(nonatomic,assign)NSInteger name
#define kPropertyStrong(type,name) @property(nonatomic,strong)type *name
// 发送通知
#define KPostNotification(name,obj,info) [[NSNotificationCenter defaultCenter]postNotificationName:name object:obj userInfo:info]
// NSString 类型 并不为空
#define kIsStrNotEmpty(_ref) ([_ref isKindOfClass:[NSString class]] && ![_ref isEqualToString:@""])
// block相关宏
#define kBlockSafeRun(block, ...) block ? block(__VA_ARGS__) : nil
// 数组获取index位置的元素
#define kArrayObjectAtIndex(array,index) (array.count > index ? array[index] : nil)
/** 去掉首尾空格和换行符 */
#define kFirstAndLastSpace(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
/** 去掉所有空格 */
#define kRemoveAllSpaces(str) [str stringByReplacingOccurrencesOfString:@" " withString:@""]
// 加载xib
#define kLoadNib(nibName) [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]]
// 字符串拼接
#define kStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
// alert
#define kAlert(_S_, ...)  [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]
// 带自动提示的keypath宏(源自Reactive Cocoa) 要添加@符号，就是为了能预编译出TARGET中所有的KEYPATH属性
#define kKeypath2(OBJ, PATH) (((void)(NO && ((void)OBJ.PATH, NO)), #PATH))
/** 方法替换
 @param clazz class
 @param orig 原函数
 @param new 新函数
 */
#define kSwizzle(clazz, orig, new) \
{\
Method origMethod = class_getInstanceMethod(clazz, orig);\
Method newMethod = class_getInstanceMethod(clazz, new);\
if (class_addMethod(clazz, orig,\
method_getImplementation(newMethod),\
method_getTypeEncoding(newMethod)))\
{\
class_replaceMethod(clazz, new,\
method_getImplementation(origMethod),\
method_getTypeEncoding(origMethod));\
} else {\
method_exchangeImplementations(origMethod, newMethod);\
}\
}

/** 单例宏 单例的目的 : 希望对象只创建一个实例，并且提供一个全局的访问点
 使用方法:
 .h文件
 kSingletonImplementation_H(类名)
 
 .m文件
 kSingletonImplementation_M(类名)
 
 调用方法
 类名 *vc = [类名 shared类名];
 */
// 1. 解决.h文件
#define kSingletonImplementation_H(className) \
+ (instancetype)shared##className;

// 2. 解决.m文件
// 判断 是否是 ARC
#if __has_feature(objc_arc)
#define kSingletonImplementation_M(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
\
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
}
#else
// MRC 部分
#define kSingletonImplementation_M(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return instance;} \
- (instancetype)autorelease {return instance;} \
- (NSUInteger)retainCount {return ULONG_MAX;}

#endif
// 提示，最后一行不要使用


/* 根据当前view 找所在tableview 里的 indexpath */
#define kIndexpathSubviewTableview(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *tabIndexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
tabIndexPath;\
})\

/* 根据当前view 找所在collectionview 里的 indexpath */
#define kIndexpathSubviewCollectionview(subview,collectionview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:collectionview];\
NSIndexPath *tabIndexPath = [collectionview indexPathForItemAtPoint:subviewFrame.origin];\
tabIndexPath;\
})\

/* 根据当前view 找所在tableview 里的 tableviewcell */
#define kCellSubviewTableview(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
UITableViewCell *tabCell  = [tableview cellForRowAtIndexPath:indexPath];\
tabCell;\
})\



#pragma mark ********** 8.获取一些沙盒路径    *********
//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath  NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//Library/Caches 文件路径
#define kFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])

#pragma mark ********** 9.系统默认字体设置和自选字体设置    *********
#define kSystemFontSize(fontsize)  [UIFont systemFontOfSize:(fontsize)]
#define kSystemBlodFontSize(fontsize)   [UIFont boldSystemFontOfSize:(fontsize)] /// 粗体
#define kSystemItalicFontSize(fontsize) [UIFont italicSystemFontOfSize:(fontsize)]

#pragma mark ********** 10.NSUserDefaults相关    *********
#define kUserDefaults [NSUserDefaults standardUserDefaults]
// 永久存储对象
#define kSetUserDefaults(object, key) \
({ \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];  \
[defaults setObject:object forKey:key];   \
[defaults synchronize];  \
})
// 获取对象
#define kGetUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
// 删除某一个对象
#define kRemoveUserDefaults(key)  \
({ \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; \
[defaults removeObjectForKey:key];  \
[defaults synchronize];  \
})
// 清除 NSUserDefaults 保存的所有数据
#define kRemoveAllUserDefaults  [kUserDefaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]]

#pragma mark ********** 11.获取时间    *********
//获得当前的年份
#define kCurrentYear [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]
//获得当前的月份
#define kCurrentMonth [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
//获得当前的日期
#define kCurrentDay  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
//获得当前的小时
#define kCurrentHour [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
//获得当前的分
#define kCurrentMin [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
//获得当前的秒
#define kCurrentSec [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]

#pragma mark ********** 12.线程 GCD   *********
/* 使用方式  kGCD_MAIN_ASYNC(^{ NSLog(@"77"); }); */
//GCD - 异步主线程
#define kGCD_MAIN_ASYNC(main_queue_block) dispatch_async(dispatch_get_main_queue(), main_queue_block)
//GCD - 异步子线程
#define kGCD_QUEUE_ASYNC(global_queue_block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), global_queue_block)
//GCD - 一次性执行
#define kGCD_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 异步并行队列
#define kGCD_GROUP_ASYNC(group_async_block,group_notify_block) \
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);\
dispatch_group_t group = dispatch_group_create();\
dispatch_group_async(group, queue, group_async_block);\
dispatch_group_notify(group, queue, ^{\
dispatch_async(dispatch_get_main_queue(), group_notify_block);\
})\

#pragma mark ********** 宏的用法总结   *********
/* 宏的基本用法
  1.宏定义需要加括号的两种情况:
    (1)如果宏的替换列表中带有运算符,那么使用要将替换列表放到括号中。例如#define MAX_VALUE(X,Y) ((X) > (Y) ? (X) : (Y))
    (2)如果宏有参数,每次参数在替换列表中出现时都要放在括号中。同上
 #define MAX_VALUE(X,Y) ((X) > (Y) ? (X) : (Y))// 求两个数中的最大值
 
  2.#运算符和##运算符
  (1)出现在宏定义中的#运算符把跟在其后的参数转换成一个字符串。有时把这种用法的#称为字符串化运算符。例如：
  #define PASTE(n) "adhfkj"#n
  main(){
  printf("%s\n",PASTE(15));
  }
  宏定义中的#运算符告诉预处理程序，把源代码中任何传递给该宏的参数转换成一个字符串。所以输出应该是adhfkj15。
 
 针对Window,dos,os2不同的系统对WIDTH进行不同的定义
 单独一行的#是空指令
 #ifdef WINDOWS
 #
 #define WIDTH 375
 #
 #elif defined(DOS)
 #
 #define WIDTH 414
 #
 #elif defined(OS)
 #
 #define WIDTH 320
 #
 #else
 #
 //#error no sysytem;
 #
 #endif
  (2)##运算符用于把参数连接到一起。预处理程序把出现在##两侧的参数合并成一个符号。看下面的例子：
  #define NUM(a,b,c) a##b##c
  #define STR(a,b,c) a##b##c
  main(){
  printf("%d\n",NUM(1,2,3));
  printf("%s\n",STR("aa","bb","cc"));
  }
  最后程序的输出为:
  123
  aabbcc
 
 #define IMAGE_NAME(NAME) @"image_name"#NAME // IMAGE_NAME(3)=image_name3
 #define STR(NAME,AGE,SEX) @"名字:"#NAME@".年龄:"#AGE@".性别:"#SEX// 名字:@“王五".年龄:24.性别:@"男"
 
  3.取消宏定义
  #undef NUM1
 
  4.复杂宏的定义
 #define NSLOG_ARRAY_OR_DICT(ARRAY,DICT) (NSLog(@"array = %@,dict = %@",[(ARRAY) description],[(DICT) description]));
 //设计技巧:dowhile中出现;
 #define NSLOG_ARRAY_OR_DICT2(ARRAY,DICT) do {int a =1;NSLog(@"a = %d",a);NSLog(@"array = %@,dict = %@",[(ARRAY) description],[(DICT) description]);}while(0)
 
 5.条件编译args...表示有多个参数
 (1)打印信息
 #define DEBUG1
 #if DEBUG
 #define MY_NSLog(fmt,args...) NSLog(@fmt,##args)
 #else
 #define MY_NSLog(fmt,args...)
 #endif
 
 */



#endif /* _KJMacros_h */
