
  Pod::Spec.new do |s|
    s.name = 'CapacitorPluginPermissions'
    s.version = '0.0.1'
    s.summary = 'Capacitor permissions request and management plugin'
    s.license = 'MIT'
    s.homepage = 'https://github.com/diiiary/capacitor-plugin-permissions.git'
    s.author = 'diiiary.com'
    s.source = { :git => 'https://github.com/diiiary/capacitor-plugin-permissions.git', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
  end