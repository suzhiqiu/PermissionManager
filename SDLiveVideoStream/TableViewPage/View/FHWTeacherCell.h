//
//  FHWTecherCell.h
//  SDLiveVideoStream
//
//  Created by suzhiqiu on 2019/5/15.
//  Copyright © 2019 suzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHWBaseTableViewCell.h"
#import "IMYTeacher.h"

NS_ASSUME_NONNULL_BEGIN

@interface FHWTeacherCell : FHWBaseTableViewCell


/*设置数据界面*/
-(void)setModel:(id)model;
/*cell高度*/
+(CGFloat)cellHeight;


@end

NS_ASSUME_NONNULL_END
