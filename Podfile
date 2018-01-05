# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MVVM_GitHub' do
 # Comment the next line if you're not using Swift and don't want to use dynamic 
  use_frameworks!

  pod 'RxCocoa'
  pod 'RxOptional'
  pod 'ObjectMapper', '~> 2.2'
  pod 'RxObjectMapper'
  pod 'SwiftIcons', '~> 1.5.1'
  pod 'SDWebImage'
  pod 'RxDataSources', '~> 2.0.2'

  target 'MVVM_GitHubTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MVVM_GitHubUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end
