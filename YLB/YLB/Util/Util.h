//
//  Util.h
//  OTC
//
//  Created by kevin on 2018/3/29.
//  Copyright © 2018年 dhffcw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface Util : NSObject

// appdelegate
+ (AppDelegate *)getAppDelegate;

+(BOOL)isNotFirtLog;

+(void)markIsNotFirstLog;

@end
