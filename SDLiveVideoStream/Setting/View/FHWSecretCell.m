//
//  FHWSecretCell.m
//  fanhuanwang
//
//  Created by suzq on 2019/4/25.
//  Copyright © 2019 lgfz. All rights reserved.
//

#import "FHWSecretCell.h"

@interface FHWSecretCell ()
/*主标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/*右标题*/
@property (nonatomic, strong) UILabel *rightLabel;
/*箭头*/
@property (nonatomic, strong) UIImageView *arrowImageView;
    
@end

@implementation FHWSecretCell

- (void)prepareUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowImageView.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
}

/**/
-(void)setModel:(FHWSecretModel *)model{
    self.titleLabel.text=model.title;
    NSString *openState=@"去设置";
    if(model.bOpen){
        openState=@"已开启";
    }
    self.rightLabel.text=openState;
}
    
/*cell高度*/
+(CGFloat)cellHeight{
    return 46;
}
/*主标题*/
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
/*右标题*/
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:15];
        _rightLabel.textColor = UIColorFromRGB(0x999999);
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}
/*箭头*/
- (UIImageView *)arrowImageView{
    if (!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image =[UIImage imageNamed:@"my_arrow"];
    }
    return _arrowImageView;
}
    
@end
