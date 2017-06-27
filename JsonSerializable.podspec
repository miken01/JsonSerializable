#
#  Be sure to run `pod spec lint SwiftData.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name                    = "JsonSerializable"
  s.version                 = "1.0.0"
  s.summary                 = "JsonSerializable is a protocol that simplifies the process of deserializing JSON data into Swift types."
  s.description             = <<-DESC
'JsonSerializable' is a protocol that simplifies the process of deserializing JSON data into Swift types. This protocol is similar to Mappable but is not weighed down by extra functionality. The purpose of this protocol is to be a lightweight alternative to Mappable when the additional functionality provided by Mappable is not necessary.
                   DESC
  s.homepage                = "https://github.com/miken01/JsonSerializable"
  s.license                 = "LICENSE"
  s.author                  = { "Mike Neill" => "michael_neill@me.com" }
  s.platform                = :ios, "9.3"
  s.source                  = { :git => "https://github.com/miken01/JsonSerializable.git", :tag => "1.0.0" }
  s.source_files            = "JsonSerializable.swift"
  s.requires_arc            = true
  s.ios.deployment_target   = '9.3'
  s.ios.frameworks          = 'Foundation'
end