//
//  IMYItemProtocol.h
//  SDLiveVideoStream
//
//  Created by suzhiqiu on 2019/5/14.
//  Copyright © 2019 suzq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 协议中能够声明方法，以及属性。 但是不能定义变量。
 属性=变量+get+set。这就要求该协议的遵守者必须自己写出setter和getter方法的实现。但是有一种情况是不需要的，
 那就是遵守者本来就有这个属性，此时系统会为这个属性自动生成设置获取方法。
 
 https://www.jianshu.com/p/26735972cfcc
 */

@protocol IMYItemProtocol <NSObject>

@property(nonatomic, assign) NSInteger type;
@property(nonatomic, assign) NSInteger rowCount;
@property(nonatomic, copy)   NSString *sectionTitle;


@end

NS_ASSUME_NONNULL_END
