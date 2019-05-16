//
//  FHWBaseTableViewCell.m
//  fanhuanwang
//
//  Created by suzq on 2019/3/21.
//  Copyright © 2019 lgfz. All rights reserved.
//

#import "FHWBaseTableViewCell.h"

@implementation FHWBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    
}

+(NSString *)identifier{
    return  NSStringFromClass(self);
}

/*cell高度*/
+(CGFloat)cellHeight{
    return 0;
}


@end
