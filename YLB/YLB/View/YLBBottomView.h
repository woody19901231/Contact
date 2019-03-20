//
//  YLBBottomView.h
//  YLB
//
//  Created by goulala on 2019/3/19.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBBottomView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *allSelectBtn;

@property (nonatomic, copy) void(^allSelectBlock) (void);

@property (nonatomic, copy) void(^deleteBlock) (void);


@end

NS_ASSUME_NONNULL_END
