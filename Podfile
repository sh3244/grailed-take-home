# Uncomment the next line to define a global platform for your project
platform :ios, '11.4'

target 'GrailedTakeHome' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GrailedTakeHome

  # View/network debugger
  pod 'FLEX', '2.0', :configurations => ['Debug']

  # Networking
  pod 'Alamofire', '4.8.0'
  pod 'AlamofireImage', '3.5.0'

  pod 'SwiftyJSON', '4.0.0'

  pod 'PromiseKit', '4.5.2'

  # AutoLayout
  pod 'SteviaLayout', '4.3.0'

  # LCS diff calculator
  pod 'Dwifft', '0.8'

  target 'GrailedTakeHomeTests' do
    inherit! :search_paths
    # Pods for testing

    pod 'Quick', '1.2.0'
    pod 'Nimble', '7.0.3'
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['SteviaLayout', 'PromiseKit', 'Dwifft'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end
