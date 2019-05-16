//
//  FHWHoneyCell.m
//  fanhuanwang
//
//  Created by suzq on 2018/9/20.
//  Copyright © 2018年 lgfz. All rights reserved.
//

#import "FHWStudentCell.h"

@interface FHWStudentCell ()

/*最终价*/
@property (nonatomic, strong) UILabel *title;

@end

@implementation FHWStudentCell

/*布局*/
- (void)prepareUI {
    //
    [self.contentView addSubview:self.title];
    //
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

/*设置数据界面*/
-(void)setModel:(id)model{
    if(![model  isKindOfClass:[IMYStudent class]]){
        return;
    }
    IMYStudent *student =(IMYStudent*)model;
    self.title.text=student.name;
}

+(NSString *)identifier{
    return  NSStringFromClass(self);
}
/*cell高度*/
+(CGFloat)cellHeight{
    return 44;
}

/*最终价*/
- (UILabel *)title
{
    if (!_title){
        _title = [[UILabel alloc]init];
        _title.font = [UIFont boldSystemFontOfSize:14];
        _title.textColor = UIColorFromRGB(0xff3444);
    }
    return _title;
}


@end
