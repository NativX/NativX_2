# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'
target 'NativX_2' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
pod 'Firebase'
pod 'Firebase/Database'
pod 'Firebase/Auth'
pod 'FirebaseUI'
pod 'Firebase/Storage'
pod 'Firebase/Messaging'
pod 'Firebase/Crash'
pod 'Firebase/Analytics'
pod 'Firebase/AppIndexing'
pod 'FBSDKLoginKit'
pod 'GoogleSignIn'
pod 'Fabric'
pod 'TwitterKit'
pod 'NVActivityIndicatorView'
pod 'Koloda', '~> 3.1.1'
pod 'UITextField+Shake', '~> 1.1'
pod 'AZExpandableIconListView'
pod 'TextFieldEffects'
pod "GaugeKit"
pod "IntervalSlider"
  # Pods for NativX_2

  target 'NativX_2Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NativX_2UITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
      `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
      end

end
