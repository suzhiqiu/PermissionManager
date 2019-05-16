//
//  FHWHoneyCell.h
//  fanhuanwang
//
//  Created by suzq on 2018/9/20.
//  Copyright © 2018年 lgfz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHWBaseTableViewCell.h"
#import "IMYItemProtocol.h"
#import "IMYStudent.h"


@interface FHWStudentCell : FHWBaseTableViewCell


/*设置数据界面*/
-(void)setModel:(id)model;


/*cell高度*/
+(CGFloat)cellHeight;


@end
