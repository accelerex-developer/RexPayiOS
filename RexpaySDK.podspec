
Pod::Spec.new do |spec|

  spec.name         = "RexpaySDK"
  spec.version      = "0.0.1"
  spec.summary      = "RexpaySDK"
  spec.description  = "The RexpaySDK simplifies payment integration for developers and businesses, offering a flexible and secure solution for seamless transactions and support for diverse payment methods."
  spec.homepage     = "https://github.com/accelerex-developer/RexPayiOS"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Babatunde Jimoh" => "abdullahijimoh3.ja@gmail.com" }
  spec.ios.deployment_target = '13.0'
  spec.swift_versions = '5.0'


  spec.source       = { :git => "https://github.com/accelerex-developer/RexPayiOS.git", :branch => "main"}
  #s.source = { :git => 'https://github.com/accelerex-developer/RexPayiOS.git', :tag => s.version.to_s }
  
  spec.source_files = 'RexpaySDK/**/*.{swift}'
  spec.resources =  'RexpaySDK/Resources/*.{xcassets,json,png}'
   
  #spec.public_header_files = 'Classes/*.h'

  spec.frameworks = 'UIKit'
  #spec.dependency 'RexpaySDK/Frameworks'
  spec.vendored_frameworks = 'RexpaySDK/Frameworks/ObjectivePGP.xcframework'
  #spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = [
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/ios-arm64_x86_64/ObjectivePGP.framework/PrivateHeaders",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/ObjectivePGP",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/Current/Resources/Info.plist",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/A/Resources/Info.plist",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/Current/Resources/LICENSE.txt",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Resources/Info.plist",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/A/ObjectivePGP",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Resources/LICENSE.txt",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/A/Resources/LICENSE.txt",
                "RexpaySDK/Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/Current/ObjectivePGP"
        ]

  # spec.public_header_files = "Classes/**/*.h"



end
