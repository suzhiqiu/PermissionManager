//
//  NSData+BCCategory.m
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import "NSData+SDCategory.h"

@implementation NSData (SDCategory)



//转化成16进制
- (NSString *)sd_convertToHexString
{
    
    if ([self length]==0)
    {
        return @"";
    }
    
    Byte * bytes = (Byte *)[self bytes];
    
    NSString * hexString = @"";
    
    for (NSInteger i=0; i<[self length]; i++)
    {
        NSString * newHexStr = [NSString stringWithFormat:@"%X",bytes[i] & 0xFF]; //16进制数
        
        if ([newHexStr length]==1)
        {
            hexString = [NSString stringWithFormat:@"%@0%@", hexString,newHexStr];
        }
        else
        {
            hexString = [NSString stringWithFormat:@"%@%@", hexString,newHexStr];
        }
    }
    
    return hexString;
}



@end
