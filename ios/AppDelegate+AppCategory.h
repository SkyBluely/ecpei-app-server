//
//  AppDelegate+AppCategory.h
//  ryp_rn_supplier
//
//  Created by ryp-app01 on 2018/11/9.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppCategory)
-(void)registerUMSDK;
-(void)registerPushAliyun:(NSDictionary *)launchOptions;
-(void)registerMWApiServe;
-(void)registerBuglyLog;
- (BOOL)appCategory:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)appCategory:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (BOOL)appCategory:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler;
- (BOOL)appCategory:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
- (void)appCategory:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)appCategory:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)appCategory:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;
- (void)appCategory:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;
@end
