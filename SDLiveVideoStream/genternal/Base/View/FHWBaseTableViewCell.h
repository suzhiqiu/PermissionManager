//
//  FHWBaseTableViewCell.h
//  fanhuanwang
//
//  Created by suzq on 2019/3/21.
//  Copyright © 2019 lgfz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHWBaseTableViewCell : UITableViewCell

/**/
- (void)prepareUI;

+(CGFloat)cellHeight;

+(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
