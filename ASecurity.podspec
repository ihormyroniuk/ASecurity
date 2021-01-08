Pod::Spec.new do |s|
  s.name         = "ASecurity"
  s.version      = "1.0.0"
  s.summary      = "ASecurity is an advanced extension for Security framework."
  s.description  = "ASecurity is an advanced extension for Security framework. Description."
  s.homepage     = "https://github.com/ihormyroniuk/ASecurity"
  s.license      = "MIT"
  s.author       = { "Ihor Myroniuk" => "ihormyroniuk@gmail.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/ihormyroniuk/ASecurity.git", :tag => "1.0.0" }
  s.source_files = "ASecurity/**/*.{swift}"
  s.swift_version = "4.2"
end
