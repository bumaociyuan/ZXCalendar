Pod::Spec.new do |s|
  s.name     = 'ZXCalendar'
  s.version  = '1.0.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE.md' }
  s.summary  = "支持农历的日历 ,simple canledar support lunar , and customizable"
  s.homepage = 'https://github.com/bumaociyuan/ZXCalendar'
  s.authors  = { 'bumaociyuan' => 'http://bumaociyuan.github.io/' }
  s.source   = { :git => 'https://github.com/bumaociyuan/ZXCalendar.git', :tag => s.version.to_s }
  s.source_files = 'Class/*{h,m}'
  s.requires_arc = true
end