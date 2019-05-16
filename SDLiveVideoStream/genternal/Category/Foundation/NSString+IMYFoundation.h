//
//  NSString+IMYFoundation.h
//  IMYFoundation
//
//  Created by mario on 15/12/8.
//  Copyright © 2015年 meiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (IMYFoundation)

/**
 *  @brief 判断字符串为 nil or @"" or null or (null) or <null>
 */
+ (BOOL)imy_isEmptyString:(nullable NSString *)string;

/**
 *  只判断是否为空字符串   不判断是否为 "null"
 */
+ (BOOL)imy_isBlankString:(nullable NSString *)string;

/**
 *  @brief 获取去除空格后的字符串, 只能去除两端
 */
- (NSString *)imy_trimString;

/// 获取完全去除空格、换行、制表符、回车符号后的字符串
- (NSString *)imy_trimAllSpace;

- (void)times:(void (^)(void))task;

// 是否是纯数字 [0,9]
- (BOOL)imy_isAllNumbers;

// 是否是纯英文字母 [A-Za-z]
- (BOOL)imy_isAllLetters;

// 是否包含空格
- (BOOL)imy_containsWhitespace;

- (NSString *)imy_md5;

- (NSString *)imy_sha1;

+ (NSString *)imy_documentsDirectory;

+ (NSString *)imy_cachesDirectory;

+ (NSString *)imy_tmpDirectory;

/*
 将文件移动到目录 `directory`
 
 @params directory 目标目录，如果不存在，会被自动创建
 @params overwritten 是否要覆盖目标目录中的同名文件，如果是，目标目录下的同名文件会被删除，否则本文件会被重命名
 @return 如果成功，返回移动后的路径名，失败则返回 nil
 */
- (NSString *)imy_moveFileToDirectory:(NSString *)directory overwritten:(BOOL)overwritten;

- (NSString *)imy_copyFileToDirectory:(NSString *)directory overwritten:(BOOL)overwritten;

// 数字+英文字母
+ (NSString *)imy_randomStringWithLength:(NSUInteger)length;

// 纯数字
+ (NSString *)imy_randomNumberStringWithLength:(NSUInteger)length;

// 纯英文字母
+ (NSString *)imy_randomLetterStringWithLength:(NSUInteger)length;

- (NSArray *)split:(NSString *)separator;

- (NSString *)strip;

- (NSString *)imy_URLEncodedString __deprecated_msg("使用imy_URLEncode");

- (NSString *)imy_URLDecodedString __deprecated_msg("使用imy_URLDecode");

- (NSString *)imy_replaceUnicode;

- (NSString *)imy_URLEncode;
- (NSString *)imy_URLDecode;

// 版本号比较
// 例如
//  "1.2.3" > "1.2.0"
//  "2.0.0" > "1.9.9"

- (BOOL)isNewerVersionThan:(NSString *)version;

- (BOOL)isNewerOrEqualVersionThan:(NSString *)version;

- (BOOL)isOlderVersionThan:(NSString *)version;

- (BOOL)isOlderOrEqualVersionThan:(NSString *)version;

@end

NS_ASSUME_NONNULL_END
