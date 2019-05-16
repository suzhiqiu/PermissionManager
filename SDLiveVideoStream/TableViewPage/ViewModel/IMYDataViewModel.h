//
//  IMYDataViewModel.h
//  SDLiveVideoStream
//
//  Created by suzhiqiu on 2019/5/15.
//  Copyright © 2019 suzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMYStudent.h"
#import "IMYTeacher.h"

typedef enum {
    Type_Student = 0,
    Type_Teacher,
} TypePeople;

NS_ASSUME_NONNULL_BEGIN

@interface IMYDataViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *dataArray;

/*正常请求数据返回解析后*/
-(void)getData;

@end

NS_ASSUME_NONNULL_END
