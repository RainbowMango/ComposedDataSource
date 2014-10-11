Pod::Spec.new do |s|
  s.name         = "ComposedDataSource"
  s.version      = "0.5"
  s.summary      = "A simple library that allows you to create complex table view layouts."
  s.homepage     = "http://github.com/ortuman/ComposedDataSource"
  s.license      = 'MIT'
  s.author       = { "Miguel Ángel Ortuño" => "ortuman@gmail.com" }
  s.social_media_url = "http://twitter.com/ortuman"
  s.source = { :git => "https://github.com/ortuman/ComposedDataSource.git", :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'ComposedDataSource/*.{swift}'
  s.requires_arc = true
  s.frameworks = ['Foundation'];
end
