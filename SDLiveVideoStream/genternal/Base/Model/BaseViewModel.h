//
//  BaseViewModel.h
//  SDLiveVideoStream
//
//  Created by suzhiqiu on 2017/8/5.
//  Copyright © 2017年 suzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BaseViewModel : NSObject

/*数据源*/
@property (nonatomic,copy) NSArray *dataSource;
/*网络请求命令*/
@property (nonatomic,strong,readonly) RACCommand *requestDataCommand;
/*是否要自动加载下一页*/
@property (nonatomic,assign) BOOL isAutoRefresh;
/*异常错误*/
@property (nonatomic,strong,readonly) RACSubject *errors;


/*请求远程数据*/
- (RACSignal *)requestRemoteData:(NSInteger)type params:(NSDictionary *)parameters;

@end
