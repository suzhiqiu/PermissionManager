# UITableView_MVVM

1.plist添加权限声明。 没有使用到权限 ，就不要引入相关api。

<key>NSCalendarsUsageDescription</key>
<string>用于大促活动的提醒</string>
<key>NSCameraUsageDescription</key>
<string>用于设置头像</string>
<key>NSContactsUsageDescription</key>
<string>可以找到您的好友</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>进行营销活动时防止刷单</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>进行营销活动时防止刷单</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>进行营销活动时防止刷单</string>
<key>NSMicrophoneUsageDescription</key>
<string>与客服联系时使用</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>用于设置头像</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>用于设置头像</string>
<key>Privacy - Photo Library addUsage Description</key>
<string>用于设置头像</string>


2.要区分 是否首次授权。
首次授权，弹出提示框。第二次直接跳转。

3.推送 不用请求弹窗权限。
正常一启动应用就会设置。这个时候 只要获取状态就可以了。




![image](https://github.com/suzhiqiu/UITableView_MVVM/blob/master/SDLiveVideoStream/%E7%BB%93%E6%9E%84%E5%9B%BE.png)
