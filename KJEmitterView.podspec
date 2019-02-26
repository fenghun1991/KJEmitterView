Pod::Spec.new do |s|
  s.name         = "KJEmitterView"
  s.version      = "2.6.0"
  s.summary      = "Some iOS Emitter"
  s.homepage     = "https://github.com/yangKJ/KJEmitterView"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.license      = "Copyright (c) 2018 yangkejun"
  s.author       = { "77" => "393103982@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yangKJ/KJEmitterView.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://www.jianshu.com/u/c84c00476ab6'
  s.requires_arc = true
  
  
  s.ios.source_files = 'KJEmitterView/KJHeader.h' # 添加头文件
  
  s.subspec 'Classes' do |ss|
    ss.source_files = "KJEmitterView/Classes/**/*.{h,m}" # 添加文件
    ss.public_header_files = "KJEmitterView/Classes/**/*.h",'KJEmitterView/Classes/*.h'# 添加头文件
    ss.resources    = "KJEmitterView/Classes/**/*.{bundle}" # 添加数据资料
  end

  s.subspec 'KeJun' do |y|
    y.source_files = "KJEmitterView/UIKit/**/*.{h,m}" # 添加文件
    y.public_header_files = 'KJEmitterView/UIKit/*.h',"KJEmitterView/UIKit/**/*.h"   # 添加头文件
    # y.resources    = "KJEmitterView/UIKit/**/*.{bundle}" # 添加数据资料
  end

  s.subspec 'Function' do |fun|
    fun.source_files = "KJEmitterView/Foundation/**/*.{h,m}" # 添加文件
    fun.public_header_files = 'KJEmitterView/Foundation/*.h',"KJEmitterView/Foundation/**/*.h"   # 添加头文件
  end
  
  
  s.frameworks = 'Foundation','UIKit','QuartzCore','Accelerate'#,'AssetsLibrary','MobileCoreServices','CoreFoundation','CoreGraphics','CoreImage','ImageIO','CoreText','SystemConfiguration'
  # s.dependency "JSONKit", "~> 1.4"
  
end


