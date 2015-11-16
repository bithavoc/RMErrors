Pod::Spec.new do |s|
  s.name     = 'RMErrors'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.summary  = 'Powerful error handling for iOS and OSX'
  s.homepage = 'https://github.com/ride/RMErrors'
  s.authors  = { 'Bithavoc' => 'im@bithavoc.io' }
  s.source   = { :git => 'https://github.com/ride/RMErrors.git', :tag=>s.version }

  s.requires_arc = true
  
  s.public_header_files = 'RMErrors/*.{h}'
  s.source_files = 'RMErrors/*.{h,m}'
  
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
end
