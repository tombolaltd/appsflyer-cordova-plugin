//
//  AppsFlyerX+AppController.m
//  Created by Jonathan Wesfield on 26/12/2018.
//

#import <Foundation/Foundation.h>
#import "AppsFlyerX+AppController.h"
#import <objc/runtime.h>
#import "AppsFlyerAttribution.h"

@implementation AppDelegate (AppsFlyerX)
BOOL useDeepLink;

- (id) init{
    if (self = [super init]) {
        id deepLinkFlag = [[NSBundle mainBundle] objectForInfoDictionaryKey:APPSFLYER_DEEPLINK_FLAG];
        useDeepLink = deepLinkFlag ? ![deepLinkFlag boolValue] : YES;
    }
    return self;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)openURL options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if(useDeepLink){
        [[AppsFlyerAttribution shared] handleOpenUrl:openURL options:options];
        return YES;
    } else {
        return [super application:application openURL:openURL options:options];
    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    if(useDeepLink){
        [[AppsFlyerAttribution shared] continueUserActivity:userActivity restorationHandler:restorationHandler];
        return YES;
    } else {
        return [super application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if(useDeepLink){
        [[AppsFlyerAttribution shared] handleOpenUrl:url sourceApplication:sourceApplication annotation:annotation];
        return YES;
    } else {
        return [super application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
}

@end
