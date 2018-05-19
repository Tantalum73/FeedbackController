#
# Be sure to run `pod lib lint FeedbackController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FeedbackController'
  s.version          = '1.0'
  s.summary          = 'Makes it easy to integrate haptic feedback into your UIViewController 🔨'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This pod makes it easy to integrate haptic feedback into your app. It provides a class that wrapps the UIFeedbackGenerator API and provides a UIViewController extension. The mentioned class also performs availability cheking against the current iOS version as well as device capabilities for you.

It enables you to integrate haptic feedback in two lines of code.
'

  s.homepage         = 'https://github.com/Tantalum73/FeedbackController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andreas Neusüß' => 'developer@anerma.de' }
  s.source           = { :git => 'https://github.com/Tantalum73/FeedbackController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Klaarname'

  s.ios.deployment_target = '9.3'

  s.source_files = 'FeedbackController/Classes/**/*'
  s.swift_version = '4.2'
  # s.resource_bundles = {
  #   'FeedbackController' => ['FeedbackController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
