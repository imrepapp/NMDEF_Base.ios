Pod::Spec.new do |s|
  s.name             = 'NMDEF.Base'
  s.version          = '0.2.0'
  s.summary          = 'Mobile Framework for NAXT 365'

  s.description      = <<-DESC
  Swift SDK for framework of XAPT Kft. Microsoft Dynamics Finance and Operations product.
                       DESC

  s.homepage         = 'https://mobile-demo.xapt.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Papp Imre' => 'imre.papp@xapt.com' }
  s.source           = { :git => 'https://xaptdev.visualstudio.com/CE_Mobile/_git/nmdef.fwrk.ios', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.0'

  s.source_files = 'NMDEF.Base/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NAXTMobileDataEntityFramework' => ['NAXTMobileDataEntityFramework/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RxViewController', '~>0.4'
  s.dependency 'RxFlow', '~>1.6'
  s.dependency 'RxCocoa', '~>4.4'
  s.dependency 'Reusable', '~>4.0'
  s.dependency 'Moya' , '~> 12.0'
  s.dependency 'Moya/RxSwift' , '~> 12.0'
  s.dependency 'Swinject'
  s.dependency 'Spry'
  s.dependency 'RxReachability'
  s.dependency 'RxKeyboard'
end
