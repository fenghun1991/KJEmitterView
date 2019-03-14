# KJEmitterView
a simple project for KJEmitterDemo

* 这个工程提供了一些iOS开发中用到的类目, 方便开发
* pod 'KJEmitterView'

#### 相关Demo下载地址
[Demo下载地址](https://github.com/yangKJ/KJEmitterView）
#### 简书地址
[简书地址](https://www.jianshu.com/p/3ef51991c0e9）

### 一、先将代码传到github上
###### 1．创建本地仓库                 ```git init```
###### 2．添加名称为origin的远程连接    ```git remote add origin 'Github项目地址'```
###### 3．将本地代码加入到本地仓库       ```git add .```
###### 4．提交修改到本地仓库            ```git commit -m '修改记录'```
###### 5．推送master分支的代码到名称为orgigin的远程仓库   ```git push origin master```

### 二、给你git打上tag
#### 打tag的目的就相当于给你的开源框架制定版本号，每个版本一个tag
###### 1．cd仓库目录
###### 2．查看本地tag           ```git tag```
###### 3．添加本地tag 1.0.0     ```git tag -a 1.0.0 -m 'release 1.0.0'```
![图片 1.png](https://upload-images.jianshu.io/upload_images/1933747-44046777bef06be9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
###### 4．将tag传到远程       ```git push origin --tags```

#### tag的其他操作
###### 1．删除本地tag         ```git tag -d 1.0.0```
###### 2．删除远程tag          ```git push origin -d tag 1.0.0```

### 三、注册Trunk
###### 1．注册Trunk        ```pod trunk register 邮箱 '用户名' --description='描述'```
![图片 2.png](https://upload-images.jianshu.io/upload_images/1933747-c852db27cf095480.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
成功的话就会受到一份邮件，点击邮件中的链接后验证一下：

###### 2．打开邮箱点击地址：https://trunk.cocoapods.org/sessions/verify/965b5e96
点击红色terminal跳转回到终端
![图片 3.png](https://upload-images.jianshu.io/upload_images/1933747-3cf982eb2f41ea66.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 3．注册    ```pod trunk me```
成功会看到如下类似字段：
![图片 4.png](https://upload-images.jianshu.io/upload_images/1933747-4456967244d3c848.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 4．如果你的pod是由多人维护的，你也可以添加其他维护者
```pod trunk add-owner 名称 邮箱```

### 四、获取MIT文件
###### 1．网页链接     https://choosealicense.com/
![图片 5.png](https://upload-images.jianshu.io/upload_images/1933747-a5a136dae00879bd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
复制，修改相应的数据
![图片 6.png](https://upload-images.jianshu.io/upload_images/1933747-a46585d76822d013.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 2．将生成的LICENSE文件同步至Github

### 五、创建自己项目的Podspec描述文件
###### 1．创建podspec文件            ```pod spec create KJEmitterView```
###### 2．podspec文件代码
```
Pod::Spec.new do |s|
  s.name         = "KJEmitterView"
  s.version      = "1.0.0"
  s.summary      = "Some iOS Emitter"
  s.homepage     = "https://github.com/yangKJ/KJEmitterView"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.license      = "Copyright (c) 2018 yangkejun"
  s.author       = { "77" => "393103982@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yangKJ/KJEmitterView.git", :tag => "#{s.version}" }
  s.framework    = "UIKit"
  # s.dependency "JSONKit", "~> 1.4"
  s.requires_arc = true

  s.subspec 'Classes' do |ss|
    ss.source_files = "KJEmitterView/Classes/**/*.{h,m}" # 添加文件
    ss.public_header_files = 'KJEmitterView/Classes/*.h',"KJEmitterView/Classes/**/*.h"   # 添加头文件
    ss.resources    = "KJEmitterView/Classes/**/*.{bundle}" # 添加数据资料
  end
  
end
```
###### 3．验证你本地的podspec文件     ```pod spec lint KJEmitterView.podspec```
###### 4．忽略警告     ```pod spec lint KJEmitterView.podspec --allow-warnings```
验证成功，
![图片 7.png](https://upload-images.jianshu.io/upload_images/1933747-a0561698c89fcacf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 六、传到CocoaPods上
###### 1．首先验证你本地的podspec文件，之后会上传spec文件到trunk
###### 2．将podspec文件传到trunk上    ```pod trunk push KJEmitterView.podspec```
成功如下：
![图片 8.png](https://upload-images.jianshu.io/upload_images/1933747-f534f0b699fd2e63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 3．一直处于Updating spec repo master 状态   
可以选择更新下              ```pod repo update --verbose```
###### 4．检查是否上传成功：        ```pod search KJEmitterView```

### 七、Bug总结
###### 1、[!] There was an error registering with trunk: getaddrinfo: nodename nor servname provided, or not known
- 解决方案：开启了ShadowSocks，把ShadowSocks关闭再重试就好了，根本原因是DNS不对
- 附上解决方案链接：https://link.jianshu.com/?t=https://github.com/CocoaPods/CocoaPods/issues/2174

###### 2、- WARN | [iOS] license: Unable to find a license file
- 原因：没有找到License文件，根据规则也可以直接把文本写在podspec文件里
- 解决方案：podspec文件里面添加
- s.license = "Copyright (c) 2018 yangkejun"

###### 3、- WARN | source: The version should be included in the Git tag.
- 原因：podspec里的version要跟git上的tag相匹配
- 解决方案：
- 查看当前tag：    git tag 
- 推到远端：       git push --tags

###### 4、[!] Unable to accept duplicate entry for: KJEmitterDemo (1.0.0)
- 原因：重复
- 解决方案：
- 4.1．重新给git库添加tag     git tag -a 1.0.1 -m'release 1.0.1'
- 4.2．上传到远端             git push origin --tags
- 4.3．重新修改podspec文件   s.version      = "1.0.1"
- 4.4．再次校验             pod spec lint KJEmitterDemo.podspec --allow-warnings
- 4.5．最后上传到trunk        pod trunk push KJEmitterDemo.podspec

###### 5、[!] Unable to find a pod with name, author, summary, or description matching KJEmitterDemo
- 原因：审核过程是要两三天
- 解决方案：
- 执行```pod setup```命令进行本地依赖库更新，然后再搜索
- 如果还是不行删除~/Library/Caches/CocoaPods目录下的search_index.json文件
- 执行```rm ~/Library/Caches/CocoaPods/search_index.json``` 
- 然后再执行搜索```pod search KJEmitterDemo```
- 成功如下：
![WX20181126-131802@2x.png](https://upload-images.jianshu.io/upload_images/1933747-bfc239f54b544d92.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 6、校验不通过
![Pasted Graphic 2.png](https://upload-images.jianshu.io/upload_images/1933747-85e4d416150a49df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 可能原因：github上面的tag文件格式已经确定,下图位置下载下来看一下，是否和本地的文件格式保持一致。如果不一致按照下列方式解决bug。

- 查看git上面的文件格式
![Pasted Graphic.png](https://upload-images.jianshu.io/upload_images/1933747-011ceece15976fbe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- Github上面下载下来的文件格式：
![Pasted Graphic 2 2.png](https://upload-images.jianshu.io/upload_images/1933747-69bbe45ff06fc811.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 本地文件格式：
![Pasted Graphic 1.png](https://upload-images.jianshu.io/upload_images/1933747-c835b2f776a6ffeb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 需要校验的格式：
![WX20181126-171236@2x.png](https://upload-images.jianshu.io/upload_images/1933747-06d4be5c495d6cb2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


- 解决方案：很明显不一样
- 删除本地tag： ```git tag -d 1.0.0```
- 删除远端tag： ```git push origin -d tag 1.0.0```
- 重新添加本地tag：```git tag -a 1.0.0 -m ‘release 1.0.0’```
- 重新上传到远端：```git push origin --tags```
- 再次校验：```pod spec lint KJEmitterView.podspec```

###### 7、[!] There was an error pushing a new version to trunk: execution expired

- 原因：推送过期
- 解决方案：重新将podspec文件传到trunk上 ```pod trunk push KJEmitterView.podspec```

###### 8、- ERROR | [iOS] public_header_files: The pattern includes header files that are not listed in source_files 

- 原因：文件夹层次结构过浅，导致无法找到对应的文件
- 解决方案：默认的头文件目录设置为：
- s.public_header_files = 'KJEmitterView/Classes/** / *.h'
- 但是如果Classes目录中，你的代码文件夹层次结构超过两级，就会出现该错误。修改文件层级

###### 9、搜索不到最新版本pod库

- 原因：没有更新pod库
- 解决方案：更新pod库
- pod update 要更新库的名字
- 查看Podfile文件中的依赖库的最新版本：pod outdated

###### 10、代码中有`__weak typeof(self) weakSelf = self;`

- 原因：有__weak就一直验证不通过
- 解决方案：s.frameworks当中加入可以用__weak的库

###### 11、代码中有`dispatch_source_t`库相关

- 原因：有`dispatch_source_t`相关的库函数，也一直验证不通过
- 解决方案：s.frameworks当中加入可以用`dispatch_source_t`的库

###### 12、- ERROR | [KJEmitterView/Classes] xcodebuild:  KJEmitterView/KJEmitterView/Classes/AlertView/KJAlertView.m:163:116: error: property 'height' not found on object of type 'UILabel *'
![2.png](https://upload-images.jianshu.io/upload_images/1933747-7de6a4b6abcac480.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 原因：未引入头文件UIView+KJFrame在KJAlertView当中
- 解决方案：引入头文件

###### 13、- NOTE  | [iOS] [KJEmitterView/Classes] xcodebuild:  KJEmitterView/KJEmitterView/Classes/AlertView/KJAlertView.m:10:9: fatal error: 'UIView+KJFrame.h' file not found
![3.png](https://upload-images.jianshu.io/upload_images/1933747-fab29564332b8919.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 原因：不在同一个文件夹下面
- 解决方案：修改不引入该头文件的错误，或者将需要引入的头文件和KJAlertView放在同一个文件夹之下。

