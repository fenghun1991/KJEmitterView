//
//  KJMacros.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/5/13.
//  Copyright © 2019 杨科军. All rights reserved.
//  常用宏

#ifndef KJMacros_h
#define KJMacros_h

#pragma mark ********** 1.缩写 ************
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow // KeyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate  // AppDelegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter] // 通知中心

#pragma mark ********** 2.自定义高效率的 NSLog ************
#ifdef DEBUG // 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#define NSLog(format, ...)printf("\n[%s] %s [第%d行] 😎😎 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#pragma mark ********** 3.弱引用   *********
#define WEAKSELF  __weak __typeof(&*self) weakSelf = self;
#define _weakself __weak typeof(self) weakself = self

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
#define kTABBAR_HEIGHT (iPhoneX?(49.f+34.f):49.f)
// statusBar height.
#define kSTATUSBAR_HEIGHT (iPhoneX?44.0f:20.f)
// navigationBar height.
#define kNAVIGATION_HEIGHT (44.f)
// (navigationBar + statusBar) height.
#define kSTATUSBAR_NAVIGATION_HEIGHT (iPhoneX?88.0f:64.f)
// 没有tabar 距 底边高度
#define kBOTTOM_SPACE_HEIGHT (iPhoneX?34.0f:0.0f)
// 屏幕尺寸
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
// AutoSize
#define kAutoW(r)   r*kScreenW / 375.0
#define kAutoH(r)   r*kScreenH / 667.0

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

#pragma mark ********** 6.颜色相关   *********
#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]  // rgb颜色+透明度
#define UIColorHexFromRGB(hex)    UIColorFromHEXA(hex,1.0)
#define RandomColor        [UIColorcolorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]  /// 随机颜色

#pragma mark ********** 7.方法    *********
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

#pragma mark ********** 8.获取一些沙盒路径    *********
//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//Library/Caches 文件路径
#define kFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])


#endif /* KJMacros_h */
