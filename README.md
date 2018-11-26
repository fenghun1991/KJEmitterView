# KJEmitterDemo
a simple project for KJEmitterDemo

* 这个工程提供了一些iOS开发中用到的类目, 方便开发
* pod 'KJEmitterDemo'，'～> 1.0.1'

# 开源框架到CocoaPods

#### 相关Demo下载地址
[Demo下载地址](https://github.com/yangKJ/KJEmitterDemo）
#### 简书地址
[简书地址](https://www.jianshu.com/p/3ef51991c0e9）


### 一、先将代码传到github上
###### 1．创建本地仓库                 ```git init```
###### 2．添加名称为origin的远程连接    ```git remote add origin '你的github项目地址'```
###### 3．将本地代码加入到本地仓库       ```git add .```
###### 4．提交修改到本地仓库            ```git commit -m '你的修改记录'```
###### 5．推送master分支的代码到名称为orgigin的远程仓库   ```git push origin master```

### 二、给你git打上tag
#### 打tag的目的就相当于给你的开源框架制定版本号，每个版本一个tag
###### 1．cd仓库目录
###### 2．查看本地tag           ```git tag```
###### 3．添加本地tag 1.0.0     ```git tag -a 1.0.0 -m ‘release 1.0.0’```
![图片 1.png](https://upload-images.jianshu.io/upload_images/1933747-44046777bef06be9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
###### 4．将tag传到远程       ```git push origin --tags```

#### tag的其他操作
###### 1．删除本地tag         ```git tag -d 1.0.0```
###### 2．删除远程tag          ```git push origin -d tag 1.0.0```

### 三、注册Trunk
###### 1．注册Trunk        ```pod trunk register 你的邮箱 '你的用户名' --description='你的描述'```
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
###### 1．创建podspec文件            ```pod spec create KJEmitterDemo```
###### 2．验证你本地的podspec文件     ```pod spec lint KJEmitterDemo.podspec```
###### 3．忽略警告     ```pod spec lint KJEmitterDemo.podspec --allow-warnings```
验证成功，
![图片 7.png](https://upload-images.jianshu.io/upload_images/1933747-a0561698c89fcacf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 六、传到CocoaPods上
###### 1．首先验证你本地的podspec文件，之后会上传spec文件到trunk
###### 2．将podspec文件传到trunk上    ```pod trunk push KJEmitterDemo.podspec```
成功如下：
![图片 8.png](https://upload-images.jianshu.io/upload_images/1933747-f534f0b699fd2e63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 3．一直处于Updating spec repo `master`状态   可以选择更新下                 pod repo update --verbose
###### 4．检查是否上传成功：          ```pod search KJEmitterDemo```

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
- 再次校验：```pod spec lint KJEmitterDemo.podspec```
