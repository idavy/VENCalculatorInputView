
Pod::Spec.new do |s|
  s.name             = "VENCalculatorInputView"
  s.version          = "0.1.0"
  s.summary          = "VENCalculatorInputView"
  
  s.description      = <<-DESC
                       This is VENCalculatorInputView
                       DESC

  s.homepage         = "https://github.com/idavy/VENCalculatorInputView"
  s.license          = 'MIT'
  s.author           = { "Davy" => "aidave@126.com" }
  s.source           = { :git => "https://github.com/idavy/VENCalculatorInputView.git", :tag => "#{s.version}" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource = 'Pod/Assets/*.{png,xib}'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
