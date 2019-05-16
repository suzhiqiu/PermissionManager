//
//  FHWSecretModel.h
//  fanhuanwang
//
//  Created by suzq on 2019/4/25.
//  Copyright © 2019 lgfz. All rights reserved.
//

#import <Foundation/Foundation.h>

/*隐私类型*/
typedef NS_ENUM(NSInteger,SecretType )
{
    SecretType_Location=1,//位置
    SecretType_Camera=2,//相机
    SecretType_Photo=3, //相册
    SecretType_Calendar=4,//日历
    SecretType_Voice=5, //语音
    SecretType_Push =6  //推送
};

NS_ASSUME_NONNULL_BEGIN

@interface FHWSecretModel : NSObject
/*主标题*/
@property (nonatomic,copy) NSString *title;
/*右标题*/
@property (nonatomic,copy) NSString *detail;
/*高亮部分*/
@property (nonatomic,copy) NSString *detailHighLight;
/*隐私类型*/
@property (nonatomic,assign) SecretType  type;
/*是否开启*/
@property (nonatomic,assign) BOOL bOpen;
    
@end

NS_ASSUME_NONNULL_END
