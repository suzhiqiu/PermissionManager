//
//  NSString+IMYFoundation.m
//  IMYFoundation
//
//

#import "NSObject+IMYFoundation.h"
#import "NSString+IMYFoundation.h"
#include <CommonCrypto/CommonCrypto.h>
#include <zlib.h>

@implementation NSString (IMYFoundation)

+ (BOOL)imy_isEmptyString:(NSString *)string {
    return imy_isEmptyString(string);
}

+ (BOOL)imy_isBlankString:(NSString *)string {
    return imy_isBlankString(string);
}

- (NSString *)imy_trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)imy_trimAllSpace {
    NSString *trimed = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    trimed = [trimed stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    trimed = [trimed stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    trimed = [trimed stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return trimed;
}



// 是否是纯数字 [0,9]
- (BOOL)imy_isAllNumbers {
    NSCharacterSet *set = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *set2 = [NSCharacterSet characterSetWithCharactersInString:self];
    return [set isSupersetOfSet:set2];
}

// 是否是纯英文字母 [A-Za-z]
- (BOOL)imy_isAllLetters {
    //NOTE: only English letters
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
    NSCharacterSet *inverted = [set invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:inverted];
    return range.location == NSNotFound;
}

// 是否包含空格
- (BOOL)imy_containsWhitespace {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    NSRange range = [self rangeOfCharacterFromSet:set];
    return range.location != NSNotFound;
}

- (NSString *)imy_sha1 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

- (NSString *)imy_md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+ (NSString *)imy_documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];

    return docDirectory;
}

+ (NSString *)imy_cachesDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];

    return cacheDirectory;
}

+ (NSString *)imy_tmpDirectory {
    return NSTemporaryDirectory();
}

- (NSString *)_imy_movedFileToDirectory:(NSString *)directory overwritten:(BOOL)overwritten {
    if (nil == directory) {
        return nil;
    }

    if (NO == [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil]) {
        return nil;
    }

    NSString *name = [self lastPathComponent];
    NSString *expectedPath = [directory stringByAppendingPathComponent:name];
    NSString *targetPath = expectedPath;

    if (overwritten) {
        // delete existing
        [[NSFileManager defaultManager] removeItemAtPath:targetPath error:nil];
    } else {
        int i = 1;
        while ([[NSFileManager defaultManager] fileExistsAtPath:targetPath]) {
            targetPath = [expectedPath stringByAppendingString:[NSString stringWithFormat:@"-%d", i++]];
        }
    }

    return targetPath;
}

- (NSString *)imy_moveFileToDirectory:(NSString *)directory overwritten:(BOOL)overwritten {
    NSString *targetPath = [self _imy_movedFileToDirectory:directory overwritten:overwritten];
    if (nil == targetPath) {
        return nil;
    }

    if (NO == [[NSFileManager defaultManager] moveItemAtPath:self toPath:targetPath error:nil]) {
        return nil;
    }

    return targetPath;
}

- (NSString *)imy_copyFileToDirectory:(NSString *)directory overwritten:(BOOL)overwritten {
    NSString *targetPath = [self _imy_movedFileToDirectory:directory overwritten:overwritten];
    if (nil == targetPath) {
        return nil;
    }

    if (NO == [[NSFileManager defaultManager] copyItemAtPath:self toPath:targetPath error:nil]) {
        return nil;
    }

    return targetPath;
}

+ (NSString *)imy_randomStringWithSet:(NSString *)set length:(NSUInteger)length {
    NSMutableString *string = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0; i < length; i++) {
        u_int32_t index = arc4random() % [set length];
        unichar character = [set characterAtIndex:index];
        [string appendFormat:@"%C", character];
    }
    return [NSString stringWithString:string];
}

+ (NSString *)imy_randomStringWithLength:(NSUInteger)length {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    return [self imy_randomStringWithSet:letters length:length];
}

+ (NSString *)imy_randomNumberStringWithLength:(NSUInteger)length {
    NSString *letters = @"0123456789";
    return [self imy_randomStringWithSet:letters length:length];
}

+ (NSString *)imy_randomLetterStringWithLength:(NSUInteger)length {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return [self imy_randomStringWithSet:letters length:length];
}

- (NSArray *)split:(NSString *)separator {
    return [self componentsSeparatedByString:separator];
}

- (NSString *)strip {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)imy_URLEncodedString {
    static CFStringRef toEscape = CFSTR(":/=,!$&'()*+;[]@#?%");
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 toEscape,
                                                                                 kCFStringEncodingUTF8);
}

- (NSString *)imy_URLDecodedString {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 kCFStringEncodingUTF8);
}
- (NSString *)imy_replaceUnicode {
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:nil error:nil];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (NSString *)imy_URLEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)imy_URLDecode {
    return [self stringByRemovingPercentEncoding];
}

- (NSComparisonResult)versionCompare:(NSString *)version {
    NSArray *arrVersion1 = [self componentsSeparatedByString:@"."];
    NSArray *arrVersion2 = [version componentsSeparatedByString:@"."];
    for (NSInteger index = 0; index < MAX([arrVersion1 count], [arrVersion2 count]); index++) {
        NSInteger num1 = index < [arrVersion1 count] ? [[arrVersion1 objectAtIndex:index] integerValue] : 0;
        NSInteger num2 = index < [arrVersion2 count] ? [[arrVersion2 objectAtIndex:index] integerValue] : 0;
        if (num1 > num2) {
            return NSOrderedDescending;
        } else if (num1 < num2) {
            return NSOrderedAscending;
        }
    }
    return NSOrderedSame;
}

- (BOOL)isNewerVersionThan:(NSString *)version {
    return [self versionCompare:version] == NSOrderedDescending;
}

- (BOOL)isNewerOrEqualVersionThan:(NSString *)version {
    NSComparisonResult res = [self versionCompare:version];
    return res == NSOrderedDescending || res == NSOrderedSame;
}

- (BOOL)isOlderVersionThan:(NSString *)version {
    return [self versionCompare:version] == NSOrderedAscending;
}

- (BOOL)isOlderOrEqualVersionThan:(NSString *)version {
    NSComparisonResult res = [self versionCompare:version];
    return res == NSOrderedAscending || res == NSOrderedSame;
}

@end
