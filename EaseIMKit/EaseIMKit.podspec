Pod::Spec.new do |s|
  s.name = 'EaseIMKit'
  s.version = '3.8.0.1'

  s.platform = :ios, '10.0'

  s.license = { :type => 'Copyright', :text => 'Hyphenate Inc. 2017' }
  s.summary = 'easemob im sdk UIKit'
  s.homepage = 'http://docs-im.easemob.com/im/ios/other/easeimkit'
  s.description = <<-DESC
                    EaseIMKit Supported features:

                    1. Conversation list
                    2. Chat page (singleChat,groupChat,chatRoom)
                    3. Contact list
                  DESC
  s.author = { 'easemob' => 'dev@easemob.com' }
  s.source = {:http => 'https://downloadsdk.easemob.com/downloads/EaseKit/EaseIMKit_3.8.0.zip' }

  s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}

  s.requires_arc = true
  s.preserve_paths = '*.framework'
  s.vendored_frameworks = '*.framework'

  s.frameworks = 'UIKit'
  s.libraries = 'stdc++'
  s.dependency 'EMVoiceConvert', '~> 0.1.0'
  s.dependency 'HyphenateChat'

end
