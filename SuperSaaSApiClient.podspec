#
# Be sure to run `pod lib lint SuperSaaSApiClient.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SuperSaaSApiClient'
  s.version          = '0.1.0'
  s.summary          = 'Appointment Scheduling and Reservation Booking Calendar.'

  s.description      = <<-DESC
Online appointment scheduler for any type of business. Flexible and affordable booking software that can be integrated into any site.
                       DESC

  s.homepage         = 'https://www.supersaas.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SuperSaaS' => 'support@supersaas.com' }
  s.source           = { :git => 'https://github.com/Travis Dunn/SuperSaaSApiClient.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/supersaas'

  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'SuperSaaSApiClient/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SuperSaaSApiClient' => ['SuperSaaSApiClient/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'UICKeyChainStore', '~> 2.0'
end
