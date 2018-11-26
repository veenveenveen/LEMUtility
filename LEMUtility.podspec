Pod::Spec.new do |s|
  s.name         = "LEMUtility" #项目名称
  s.version      = "0.0.1"	# 版本号 与 你仓库的 标签号 对应
  s.summary      = "通用组件" # 项目简介
  s.homepage     = "https://github.com/veenveenveen/LEMUtility" # 主页
  s.license      = "MIT" # 开源证书
  s.author             = { "Himin" => "745685567@qq.com" } # 作者信息
  # s.social_media_url   = "http://twitter.com/Himin" # 个人主页
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/veenveenveen/LEMUtility.git", :tag => "#{s.version}" }
  s.source_files  = "LEMUtility/**/*.{h,m}"
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  s.requires_arc = true # 是否启用ARC
end
