#
# Be sure to run `pod lib lint RSocketSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RSocketSwift'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RSocketSwift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Sumit Nathany/RSocketSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sumit Nathany' => 'sumit_nathany@intuit.com' }
  s.source           = { :git => 'https://github.com/Sumit Nathany/RSocketSwift.git', :branch => 'master' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'


  s.ios.deployment_target = '10.0'

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |core|
    s.source_files = 'RSocketSwift/Core/**/*.swift'
    s.dependency 'SwiftNIO', '2.23.0'
  end
  # s.resource_bundles = {
  #   'RSocketSwift' => ['RSocketSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
