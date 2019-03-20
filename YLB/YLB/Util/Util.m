//
//  Util.m
//  OTC
//
//  Created by kevin on 2018/3/29.
//  Copyright © 2018年 dhffcw. All rights reserved.
//

#import "Util.h"

@implementation Util

// appdelegate
+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+(void)markIsNotFirstLog
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"Key_FIRSTLOGIN"];
    [defaults synchronize];
}

+(BOOL)isNotFirtLog
{
    NSNumber *firstlog =  [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_FIRSTLOGIN"];
    return [firstlog boolValue];
}


@end
