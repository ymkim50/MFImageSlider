#
# Be sure to run `pod lib lint MFImageSlider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MFImageSlider'
  s.version          = '0.1.0'
  s.summary          = 'A image slider based UIView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Slider control based background image
- Reference from RSSliderView: https://github.com/rsimenok/RSSliderView
                       DESC

  s.homepage         = 'https://github.com/ymkim50/MFImageSlider'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Youngmin Kim' => 'ymkim50@me.com' }
  s.source           = { :git => 'https://github.com/ymkim50/MFImageSlider.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ymkim50'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MFImageSlider/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MFImageSlider' => ['MFImageSlider/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
