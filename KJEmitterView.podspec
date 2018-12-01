Pod::Spec.new do |s|
  s.name         = "KJEmitterView"
  s.version      = "1.2.2"
  s.summary      = "Some iOS Emitter"
  s.homepage     = "https://github.com/yangKJ/KJEmitterView"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.license      = "Copyright (c) 2018 yangkejun"
  s.author       = { "77" => "393103982@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yangKJ/KJEmitterView.git", :tag => "#{s.version}" }
  s.framework    = "UIKit","Foundation"
  # s.dependency "JSONKit", "~> 1.4"
  
  s.ios.source_files = 'KJEmitterView/KJHeader.h' # 添加头文件

  s.subspec 'Classes' do |ss|
    ss.source_files = "KJEmitterView/Classes/**/*.{h,m}" # 添加文件
    ss.public_header_files = 'KJEmitterView/Classes/*.h',"KJEmitterView/Classes/**/*.h"   # 添加头文件
    ss.resources    = "KJEmitterView/Classes/**/*.{bundle}" # 添加数据资料
  end

  # s.subspec 'KJUIKit' do |kj|
  #   kj.source_files = "KJEmitterView/UIKit/**/*.{h,m}" # 添加文件
  #   kj.public_header_files = 'KJEmitterView/UIKit/*.h',"KJEmitterView/UIKit/**/*.h"   # 添加头文件
  # end

  s.requires_arc = true
  
end


