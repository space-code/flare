Pod::Spec.new do |s|
    s.name = 'Flare'
    s.version = '2.1.0'
    s.license = 'MIT'
    s.summary = 'Flare is a framework written in Swift that makes it easy for you to work with in-app purchases and subscriptions.'
    s.homepage = 'https://github.com/space-code/flare'
    s.authors = { 'Nikita Vasilev' => 'nv3212@gmail.com' }
    s.source = { :git => 'https://github.com/space-code/flare.git', :tag => s.version }
    s.documentation_url = 'https://github.com/space-code/flare'

    s.ios.deployment_target = '13.0'
    s.osx.deployment_target = '10.15'
    s.tvos.deployment_target = '13.0'
    s.watchos.deployment_target = '7.0'

    s.source_files = 'Sources/*.swift'
end