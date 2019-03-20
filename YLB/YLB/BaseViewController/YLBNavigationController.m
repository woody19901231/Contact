//
//  CLBNavigationController.m
//  引流宝
//
//  Created by goulala on 2019/3/18.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import "YLBNavigationController.h"

@interface YLBNavigationController ()<UINavigationControllerDelegate>

@end

@implementation YLBNavigationController

+ (void)initialize
{
    [super initialize];
    [self setNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setShadowImage:[UIImage new]];
    
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isShowNav = [viewController isKindOfClass:[YLBMainViewController class]] || [viewController isKindOfClass:[YLBGenerateController class]];
    [navigationController setNavigationBarHidden:isShowNav animated:YES];
    
}

-(UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height < 1) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

+ (void)setNavigationBar
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = UIColorFromRGB(0x333333);
    navBar.barTintColor = [UIColor whiteColor];//LSOrangeColor;
    navBar.translucent = NO;
    [navBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
       
       NSForegroundColorAttributeName:UIColorFromRGB(0x333333)}];
//    navBar.shadowImage = [UIImage imageWithColor:kCutColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *image = [[UIImage imageNamed:@"back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        if (self.isWhiteBackArrow) {
            image = [[UIImage imageNamed:@"back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                                           style:UIBarButtonItemStyleDone
                                                                                          target:self
                                                                                          action:@selector(leftBarButtonItemClicked)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)leftBarButtonItemClicked
{
    [self popViewControllerAnimated:YES];
}



@end
