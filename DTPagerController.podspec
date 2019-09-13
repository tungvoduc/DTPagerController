Pod::Spec.new do |s|
  s.name             = 'DTPagerController'
  s.version          = '3.1.0'
  s.summary          = 'A fully customizable container view controller to display a set of ViewControllers in a horizontal scroll view. Written in Swift.'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
DTPagerController is an extremely simple Swift control for you to show a collection of view controllers in a horizontal pager.
DESC

  s.homepage         = 'https://github.com/tungvoduc/DTPagerController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tungvoduc' => 'tung98.dn@gmail.com' }
  s.source           = { :git => 'https://github.com/tungvoduc/DTPagerController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'DTPagerController/Classes/**/*'
  
end
