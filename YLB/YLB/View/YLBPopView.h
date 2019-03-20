//
//  YLBPopView.h
//  YLB
//
//  Created by goulala on 2019/3/19.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBPopView : UIView

@property (nonatomic, copy) void(^againBlock)(void);

-(void)showView;


@end

NS_ASSUME_NONNULL_END
