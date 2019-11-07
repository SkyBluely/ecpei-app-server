//
//  AppDelegate+AppCategory.m
//  ryp_rn_supplier
//
//  Created by ryp-app01 on 2018/11/9.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AppDelegate+AppCategory.h"
#import <UMAnalytics/MobClick.h>
#import <UMShare/UMShare.h>
#import "ZeroConstant.h"
#import "RNUMConfigure.h"
#import "AlipayModule.h"
#import "PushAliyun.h"
#import "RCTLinkingManager.h"

#import "ZeroMacros.h"
#import "NSString+IMAdditions.h"
#import <Bugly/Bugly.h>

@implementation AppDelegate (AppCategory)

//注册UM服务SDK
-(void)registerUMSDK{
  [RNUMConfigure initWithAppkey:UM_AppAppID  channel:UM_AppStore];
  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_APPID appSecret:WX_SECRET redirectURL:nil];
  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPID  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
  [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

//注册PushAliyun通知第三方服务
-(void)registerPushAliyun:(NSDictionary *)launchOptions{
  [[PushAliyun  sharedInstance] setParams:Aliyun_APPID
                                appSecret:Aliyun_SECRET
                             lauchOptions:launchOptions
        createNotificationCategoryHandler:^{
        }];
}

//注册魔窗第三方服务
-(void)registerMWApiServe{

}


//注册Bugly第三方服务
-(void)registerBuglyLog{
     [Bugly startWithAppId:Bugly_AppID ];
     [RNUMConfigure initWithAppkey:UM_Appkey channel:UM_AppStore];
}

/**NOTE: 9.0以前使用新API接口 回到第三方应用中**/
- (BOOL)appCategory:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
  BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
  if (!result) {
    // 支付SDK的回调
    result = [RCTLinkingManager application:application openURL:url
                          sourceApplication:sourceApplication annotation:annotation];
    [AlipayModule  handleCallback:url];
  }
  return  result;
}


- (BOOL)appCategory:(UIApplication *)application handleOpenURL:(NSURL *)url{
  BOOL  result = [[UMSocialManager defaultManager] handleOpenURL:url];
  if (!result) {
    // 其他如支付等SDK的回调
    result = [RCTLinkingManager application:application openURL:url
                          sourceApplication:nil annotation:nil];
    [AlipayModule  handleCallback:url];
  }
  return  result;
}

//通过universal link来唤起app
- (BOOL)appCategory:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
  //必写  return [MWApi continueUserActivity:userActivity];
  return YES;
}

/**NOTE: 9.0以后使用新API接口**/
- (BOOL)appCategory:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
  BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
  if (!result) {
    // 其他如支付等SDK的回调
    result = [RCTLinkingManager application:app openURL:url
                          sourceApplication:nil annotation:nil];
    [AlipayModule  handleCallback:url];
  }
  return  result;
}

// APNs注册成功回调，将返回的deviceToken上传到CloudPush服务器
- (void)appCategory:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  [[PushAliyun sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// APNs注册失败回调
- (void)appCategory:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
  [[PushAliyun sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

// 打开／删除通知回调
- (void)appCategory:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
  [[PushAliyun sharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

// 请求注册设定后，回调
- (void)appCategory:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
  [[PushAliyun sharedInstance] application:application didRegisterUserNotificationSettings:notificationSettings];
  
}


@end
