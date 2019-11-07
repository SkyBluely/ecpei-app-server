//
//  AppRootViewController.m
//  ryp_rn_supplier
//
//  Created by ryp-app01 on 2019/6/3.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import "AppRootViewController.h"
#import "ZeroMacros.h"
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
@interface AppRootViewController ()

@end

@implementation AppRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (void)viewWillLayoutSubviews{
   [super viewWillLayoutSubviews];
  if(IPHONE_X){return;}
  UIView *containView = [self.view   viewWithTag:self.view.tag];
  [UIView animateWithDuration:0.25
                   animations:^{
                     if (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]) > 20) {
                          [containView setFrame:CGRectMake(0, -20, self.view.frame.size.width, SCREEN_HEIGHT+20)];
                     } else {
                          [containView setFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT)];
                     }
                   }];
}

@end
