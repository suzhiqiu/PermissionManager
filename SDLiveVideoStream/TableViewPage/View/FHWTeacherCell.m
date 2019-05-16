//
//  FHWTecherCell.m
//  SDLiveVideoStream
//
//  Created by suzhiqiu on 2019/5/15.
//  Copyright © 2019 suzq. All rights reserved.
//

#import "FHWTeacherCell.h"

@interface FHWTeacherCell ()

/*最终价*/
@property (nonatomic, strong) UILabel *title;

@end

@implementation FHWTeacherCell

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
    if(![model  isKindOfClass:[IMYTeacher class]]){
        return;
    }
    IMYTeacher *teacher =(IMYTeacher*)model;
    self.title.text=teacher.name;
}

/*cell高度*/
+(CGFloat)cellHeight{
    return 44;
}

/*最终价*/
- (UILabel *)title{
    if (!_title){
        _title = [[UILabel alloc]init];
        _title.font = [UIFont boldSystemFontOfSize:14];
    }
    return _title;
}

@end
