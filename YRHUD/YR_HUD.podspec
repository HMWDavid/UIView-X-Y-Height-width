Pod::Spec.new do |s|
  s.name         = "YR_HUD"
  s.version      = "0.0.1"
  s.summary      = "simple Custom YR_HUD."
  s.description  = "simple Custom YR_HUD."
  s.homepage     = "https://github.com/HMWDavid/UIView-X-Y-Height-width"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "洪绵卫" => "244160918@qq.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/HMWDavid/UIView-X-Y-Height-width", :tag => "1.0.5"}
  s.source_files  = "YRHUD/**/YRHUD/*.{h,m}”
  s.requires_arc = true
end
