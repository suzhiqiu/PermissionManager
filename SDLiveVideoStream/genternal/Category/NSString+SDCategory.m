//
//  NSString+BCCategory.m
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import "NSString+SDCategory.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SDCategory)


//获取指定单个字符
- (unichar) sd_charAt:(NSInteger)index
{
    return [self characterAtIndex:index];
}
//是某个字符串为开始
- (BOOL) sd_startsWith:(NSString*)prefix
{
    return [self hasPrefix:prefix];
}
//是某个字符串为结束
- (BOOL) sd_endsWith:(NSString*)suffix
{
    return [self hasSuffix:suffix];
}
//字符串是否相等
- (BOOL) sd_equals:(NSString*) anotherString
{
    return [self isEqualToString:anotherString];
}
//字符串是否相等忽略大小写
- (BOOL) sd_equalsIgnoreCase:(NSString*) anotherString
{
    return [[self sd_toLowerCase] sd_equals:[anotherString sd_toLowerCase]];
}
//是否包含某一个字符串
- (BOOL)sd_contains:(NSString*) str
{
    NSRange range = [self rangeOfString:str];
    return (range.location != NSNotFound);
}
//转化小写字母
- (NSString *)sd_toLowerCase
{
    return [self lowercaseString];
}
//转化大写字母
- (NSString *)sd_toUpperCase
{
    return [self uppercaseString];
}
//去掉两端空格
- (NSString *)sd_trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
// 替换字符串
- (NSString *)sd_replaceAll:(NSString*)origin with:(NSString*)replacement
{
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}
//拆分为数组
- (NSArray *)sd_split:(NSString*)separator
{
    return [self componentsSeparatedByString:separator];
}
//截取字符串
- (NSString *) sd_substringFromIndex:(NSInteger)beginIndex toIndex:(NSInteger)endIndex
{
    if (endIndex <= beginIndex)
    {
        return @"";
    }
    NSRange range = NSMakeRange(beginIndex, endIndex - beginIndex);
    return [self substringWithRange:range];
}

//判断字符串是否为空
+ (BOOL)sd_isEmpty:(NSString *)string
{
    
    if (string == nil || string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    
    return NO;
}

//把nil转成“”
+(NSString *)sd_removeNil:(NSString*)content
{
    if([NSString sd_isEmpty:content])
    {
        return @"";
    }
    return content;
}
//右边补几位
-(NSString *)sd_leftPad:(NSInteger)sum  withString:(NSString *)withString
{
    NSInteger leave= sum-  self.length;
    NSString *str=@"";
    
    if (leave<=0)
    {
        return self;
    }
    
    for (NSInteger i=0; i<leave; i++)
    {
        str=[str stringByAppendingString:withString];
    }
    
    str=[str stringByAppendingString:self];
    
    return str;
}
//左边用空格补齐
-(NSString *)sd_leftPadWithEmtpy:(NSInteger)sum
{
    return [self sd_leftPad:sum withString:@" "];
}

//左边用0补齐
-(NSString *)sd_leftPadWithZero:(NSInteger)sum
{
    return [self sd_leftPad:sum withString:@"0"];
}

//生成md5
- (NSString *)sd_md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)(strlen(cStr)), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 *  url 编码
 *  IOS中对Url进行编码和解码
 *  http://blog.csdn.net/tianyitianyi1/article/details/17579997
 */
- (NSString *)sd_encodeURLString
{
    NSString* outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                             
                                                                             NULL, /* allocator */
                                                                             
                                                                             (__bridge CFStringRef)self,
                                                                             
                                                                             NULL, /* charactersToLeaveUnescaped */
                                                                             
                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                             
                                                                             kCFStringEncodingUTF8);
    
    
    return outputStr;
}
/**
 *  url解码
 */
- (NSString *)sd_decodeURLString
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,[outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



// 把16进制RGB字符串转成UIColor务必对UIColor值为真进行判断进行判断
+(UIColor *)sd_hexToColor:(NSString *)strHex
{
    strHex = [strHex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    NSInteger len=[strHex length];
    
    if (len!=6)
    {
        return  nil;
    }
    
   //NSLog(@"strHex::%@",strHex);
    
    GLfloat  red = strtoul([[strHex substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
    GLfloat  green = strtoul([[strHex substringWithRange:NSMakeRange(2, 2)] UTF8String],0,16);
    GLfloat  blue = strtoul([[strHex substringWithRange:NSMakeRange(4, 2)] UTF8String],0,16);
    
    //NSLog(@"%f,%f,%f",red,green,blue);
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

//获取文本的宽度
+(CGFloat)sd_getWith:(NSString *)text   font:(UIFont *)font
{
    
    NSDictionary *attriPreTip = @{NSFontAttributeName:font};
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT,0)
                                     options:    NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attriPreTip
                                     context:nil].size;
    
    return size.width;
}



//获取文本的宽度
+(CGFloat)sd_getHeight:(NSString *)text   font:(UIFont *)font
{
    
    NSDictionary *attriPreTip = @{NSFontAttributeName:font};
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(0,MAXFLOAT)
                                     options:    NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attriPreTip
                                     context:nil].size;
    
    return size.height;
}

//JSON字符串转字典
+ (NSDictionary *)sd_JsonStringToDictionary:(NSString *)jsonString
{
    if (!jsonString)
    {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err)
    {
       // NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


//字典转JSON字符串
+ (NSString*)sd_dictionaryToJsonString:(NSDictionary *)dic
{
    if(!dic)
    {
        return @"";
    }
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    if(!jsonData)
    {
        return @"";
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


//根据文件得到md5串
+ (NSString *)sd_fileMD5:(NSString *)filePath
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if(!handle)
    {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while (!done)
    {
        NSData *fileData = [handle readDataOfLength:256];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if([fileData length] == 0)
        done = YES;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSString *result = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        digest[0], digest[1],
                        digest[2], digest[3],
                        digest[4], digest[5],
                        digest[6], digest[7],
                        digest[8], digest[9],
                        digest[10], digest[11],
                        digest[12], digest[13],
                        digest[14], digest[15]];
    return result;
}

//NSData加密base64成串
+ (NSString *)sd_base64EncodeDataToString:(NSData *)data
{
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

//解密base64串 成 NSData
+ (NSData *)sd_base64DecodeStringToData:(NSString *)str
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

// 是否是纯数字 [0,9]
- (BOOL)sd_isAllNumbers
{
    NSCharacterSet* set = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet* set2 = [NSCharacterSet characterSetWithCharactersInString:self];
    return [set isSupersetOfSet:set2];
}

// 是否是纯英文字母 [A-Za-z]
- (BOOL)sd_isAllLetters
{
    //NOTE: only English letters
    NSCharacterSet* set = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
    NSCharacterSet* inverted = [set invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:inverted];
    return range.location == NSNotFound;
}
// 是否包含空格
- (BOOL)sd_containsWhitespace
{
    NSCharacterSet* set = [NSCharacterSet whitespaceCharacterSet];
    NSRange range = [self rangeOfCharacterFromSet:set];
    return range.location != NSNotFound;
}
//判断是否为空 null
+ (BOOL)sd_isEmptyString:(NSString*)string
{
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    NSString* trimString = string.sd_trim;
    if (trimString.length == 0) {
        return YES;
    }
    NSString* lowercaseString = trimString.lowercaseString;
    if ([lowercaseString isEqualToString:@"(null)"] || [lowercaseString isEqualToString:@"null"] || [lowercaseString isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}
//判断是空格字符串
+ (BOOL)sd_isBlankString:(NSString*)string
{
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    NSString* trimString = string.sd_trim;
    if (trimString.length == 0) {
        return YES;
    }
    return NO;
}

//去掉回车 换行
- (NSString *)sd_trimAllSpace {
    NSString *trimed = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    trimed = [trimed stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    trimed = [trimed stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    trimed = [trimed stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return trimed;
}



@end
