pod 'BrightFutures', '3.3.0'
link_with 'iou', 'iouTests'
use_frameworks!

pod 'SwiftyJSON', '2.3.2'
link_with 'iou', 'iouTests'

pod 'SwiftHTTP', '1.0.4'
link_with 'iou', 'iouTests'

pod 'JSONJoy-Swift', '2.0.0'
link_with 'iou', 'iouTests'

pod 'FBSDKLoginKit', '4.10.0'
link_with 'iou', 'iouTests'

pod 'SwiftValidator', '3.0.3'
link_with 'iou', 'iouTests'

pod 'SnapKit', '0.19.1'
link_with 'iou', 'iouTests'

post_install do |installer|
  plist_buddy = "/usr/libexec/PlistBuddy"

  installer.pods_project.targets.each do |target|
    plist = "Pods/Target Support Files/#{target}/Info.plist"
    version = `#{plist_buddy} -c "Print CFBundleShortVersionString" "#{plist}"`.strip

    stripped_version = /^([\d\.]*)/.match(version).captures[0]

    version_parts = stripped_version.split('.').map { |s| s.to_i }

    # ignore properly formatted versions
    unless version_parts.slice(0..2).join('.') == version

      major, minor, patch = version_parts

      minor ||= 0
      patch = 999

      fixed_version = "#{major}.#{minor}.#{patch}"

      puts "Changing version of #{target} from #{version} to #{fixed_version} to make it pass iTC verification."

      `#{plist_buddy} -c "Set CFBundleShortVersionString #{fixed_version}" "#{plist}"`
    end
  end
end

