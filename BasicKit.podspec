#
# Be sure to run `pod lib lint BasicKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BasicKit'
  s.version          = '0.0.5'
  s.summary          = 'A short description of BasicKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Changzw/BasicKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'czw' => 'changzhongwei3@gmail.com' }
  s.source           = { :git => 'https://github.com/Changzw/BasicKit', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  # s.source_files = 'BasicKit/Classes/**/*'
  s.swift_version = "5.0"
  # s.resource_bundles = {
  #   'BasicKit' => ['BasicKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'Moya', '15.0.0'
  s.dependency 'SnapKit', '5.6.0'
# s.default_subspec =
  s.subspec 'Rx' do |ss| 
    ss.source_files = 'BasicKit/Classes/Rx/*'
    ss.dependency 'RxSwift', '6.5'
    ss.dependency 'Action', '5.0.0'
    ss.dependency 'RxCocoa', '6.5'
    ss.dependency 'RxRelay', '6.5'
  end 

  s.subspec 'Tool' do |ss| 
    ss.source_files = 'BasicKit/Classes/Tool/*'
  end

  s.subspec 'StackBuilder' do |ss| 
    ss.source_files = 'BasicKit/Classes/StackBuilder/*'
  end
end
