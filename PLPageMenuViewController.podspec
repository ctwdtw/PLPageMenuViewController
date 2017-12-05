#
# Be sure to run `pod lib lint PLPageMenuViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PLPageMenuViewController'
  s.version          = '0.1.0'
  s.summary          = 'A simple UI component enable primary paging effect between view controllers.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A simple UI component enable primary paging effect between view controllers. The paging effect is resort to UICollectionView's animation effect.
                       DESC

  s.homepage         = 'https://github.com/ctwdtw/PLPageMenuViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ctwdtw' => 'ctwdtw@gmail.com' }
  s.source           = { :git => 'https://github.com/ctwdtw/PLPageMenuViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'PLPageMenuViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PLPageMenuViewController' => ['PLPageMenuViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Reusable'
end
