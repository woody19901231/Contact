//
//  NSString+Extension.m
//  ContactTest
//
//  Created by zygl on 2019/3/19.
//  Copyright © 2019年 zygl.com. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)randomNameMaxLength:(int)maxLength minLength:(int)minLength {
    
    int x = minLength + arc4random() % (maxLength - minLength + 1);
    
    NSString *name = @"";
    
    for (int i = 0; i<x; i++) {
        
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *str = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        name = [name stringByAppendingFormat:@"%@", str];
        
    }
    
    return name;
    
}


@end
