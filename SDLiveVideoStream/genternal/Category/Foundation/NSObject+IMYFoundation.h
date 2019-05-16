//
//  NSObject+IMYFoundation.h
//  IMYFoundation
//
//  Created by mario on 2017/7/13.
//  Copyright © 2017年 meiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IMYFoundation)

- (NSString *)maybeNSString;

- (NSMutableString *)maybeNSMutableString;

- (NSArray *)maybeNSArray;

- (NSMutableArray *)maybeNSMutableArray;

- (NSDictionary *)maybeNSDictionary;

- (NSMutableDictionary *)maybeNSMutableDictionary;

- (NSSet *)maybeNSSet;

- (NSMutableSet *)maybeNSMutableSet;

- (NSData *)maybeNSData;

- (NSMutableData *)maybeNSMutableData;

- (NSNumber *)maybeNSNumber;

- (NSError *)maybeNSError;

- (NSValue *)maybeNSValue;

- (NSURL *)maybeNSURL;

- (NSDate *)maybeNSDate;

- (instancetype)imy_callSuper;
- (instancetype)imy_callWithSuperClass:(Class)superClass;

///异步主线程调用block
+ (void)imy_asyncMainBlock:(void (^)(void))block __deprecated_msg("使用imy_asyncMainBlock()");

///second秒后 异步主线程调用block
+ (void)imy_asyncMainBlock:(void (^)(void))block afterSecond:(double)second __deprecated_msg("使用imy_asyncMainBlock()");

///如果在主线程 就立即执行  如果不在 则用  async来执行
+ (void)imy_asyncMainExecuteBlock:(void (^)(void))block __deprecated_msg("使用imy_asyncMainExecuteBlock()");

///如果在主线程 就立即执行  如果不在 则用  async来执行
+ (void)imy_syncMainExecuteBlock:(void (^)(void))block __deprecated_msg("使用imy_syncMainExecuteBlock()");

- (void)imy_asyncMainBlock:(void (^)(void))block __deprecated_msg("使用imy_asyncMainBlock()");
- (void)imy_asyncMainBlock:(void (^)(void))block afterSecond:(double)second __deprecated_msg("使用imy_asyncMainBlock()");
- (void)imy_asyncMainExecuteBlock:(void (^)(void))block __deprecated_msg("使用imy_asyncMainExecuteBlock()");
- (void)imy_syncMainExecuteBlock:(void (^)(void))block __deprecated_msg("使用imy_syncMainExecuteBlock()");

///可取消的 异步调用block
+ (void)imy_asyncBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue afterSecond:(double)second forKey:(NSString *)key;

///取消之前的block
+ (void)imy_cancelBlockForKey:(NSString *)key;

///是否存在这个异步block
+ (BOOL)imy_hasAsyncBlockForKey:(NSString *)key;

/// 获取默认优先级的queue
+ (dispatch_queue_t)imy_defaultQualityQueue;

/**
 *  @brief 判断字符串非 nil or @"" or null or (null) or <null>
 */
- (BOOL)imy_isNotEmptyString __deprecated_msg("请使用对应的 C function");
- (BOOL)imy_isEmptyString __deprecated_msg("请使用对应的 C function");

/**
 *  @brief 只判断字符串非 nil or @""
 */
- (BOOL)imy_isNotBlankString __deprecated_msg("请使用对应的 C function");
- (BOOL)imy_isBlankString __deprecated_msg("请使用对应的 C function");

+ (BOOL)imy_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError **)error_;
+ (BOOL)imy_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError **)error_;
+ (BOOL)imy_replaceMethod:(SEL)origSel_ withBlock:(id)block_ error:(NSError **)error_;
+ (BOOL)imy_replaceClassMethod:(SEL)origSel_ withBlock:(id)block_ error:(NSError **)error_;

@end

@interface NSProxy (IMYSwizzle)

+ (BOOL)imy_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError **)error_;
+ (BOOL)imy_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError **)error_;

@end

FOUNDATION_EXTERN void imy_asyncMainBlock(void (^block)(void)) __attribute__((overloadable));
FOUNDATION_EXTERN void imy_asyncMainBlock(double afterSecond, void (^block)(void)) __attribute__((overloadable));
FOUNDATION_EXTERN void imy_asyncMainExecuteBlock(void (^block)(void));
FOUNDATION_EXTERN void imy_syncMainExecuteBlock(void (^block)(void));

FOUNDATION_EXTERN void IMY_RUN_ON_UI_THREAD(void (^)(void));

FOUNDATION_EXTERN BOOL imy_isEmptyString(NSString *_Nullable);
FOUNDATION_EXTERN BOOL imy_isNotEmptyString(NSString *_Nullable);
FOUNDATION_EXTERN BOOL imy_isBlankString(NSString *_Nullable);
FOUNDATION_EXTERN BOOL imy_isNotBlankString(NSString *_Nullable);
