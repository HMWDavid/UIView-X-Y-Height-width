Pod::Spec.new do |s|
  s.name         = "UIViewFrame+Extension"
  s.version      = "0.0.1"
  s.summary      = "simple Custom UIView+YRExtension.”
  s.description  = "simple Custom UIView+YRExtension."
  s.homepage     = "https://github.com/HMWDavid/UIView-X-Y-Height-width"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "洪绵卫" => "244160918@qq.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/HMWDavid/UIView-X-Y-Height-width.git", :tag => “0.0.1”}
  s.source_files  = "YRLayoutConstraint/**/UIView+YRExtension.{h,m}"
  s.requires_arc = true
end

