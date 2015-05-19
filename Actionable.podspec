Pod::Spec.new do |s|
  s.name        = "Actionable"
  s.version     = "0.0.1"
  s.summary     = "Actionable adds event objects to Swift"
  s.homepage    = "https://github.com/onebytegone/actionable"
  s.license     = { :type => "MIT" }
  s.authors     = { "Ethan Smith" => "ethan@onebytegone.com" }

  s.requires_arc = true
  s.ios.deployment_target = "8.0"
  s.source   = { :git => "https://github.com/onebytegone/actionable.git", :tag => "0.0.1"}
  s.source_files = "Actionable/*.swift"
end
