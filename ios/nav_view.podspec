#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint nav_view.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'nav_view'
  s.version          = '0.0.5'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
#  s.public_header_files = ['HYDouglasPeucker.h', 'LatLngEntity.h']
  s.source_files = 'Classes/**/*'
  s.resource_bundles = {
    'nav_view_Bundle' => ['Assets/*.xcassets']
  }
  s.dependency 'Flutter'
  s.dependency 'AMapNavi'
  s.dependency 'AMapSearch'
  s.dependency 'AMapLocation'
  s.dependency 'AFNetworking'
  s.dependency 'SnapKit', '~> 5.0.1'
  s.dependency 'SwiftyJSON'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
