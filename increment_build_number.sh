cd ..
git pull
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "iou/Info.plist")
buildNumber=$(($buildNumber + 1))
echo Incrementing buildnumber from $((buildNumber-1)) to $buildNumber
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" iou/Info.plist

