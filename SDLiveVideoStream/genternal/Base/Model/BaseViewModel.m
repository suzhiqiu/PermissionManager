//
//  BaseViewModel.m
//  SDLiveVideoStream
//
//  Created by suzhiqiu on 2017/8/5.
//  Copyright © 2017年 suzq. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseViewModel()

/*网络请求命令*/
@property (nonatomic,strong) RACCommand *requestDataCommand;
/*异常错误*/
@property (nonatomic,strong) RACSubject *errors;

@end

@implementation BaseViewModel


/*错误集合*/
-(RACCommand *)requestDataCommand
{
    if (!_requestDataCommand) {
        @weakify(self);
        //_requestDataCommand= [RACCommand]
    }
    return _requestDataCommand;
}

/*请求远程数据*/
- (RACSignal *)requestRemoteData:(NSInteger)type params:(NSDictionary *)parameters
{
    return nil;
}

/*错误信号*/
-(RACSubject *)errors
{
    if (!_errors) {
        _errors= [RACSubject subject];
    }
    return _errors;
}

@end
