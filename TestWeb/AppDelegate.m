//
//  AppDelegate.m
//  TestWeb
//
//  Created by huangbo on 17/5/5.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "UserViewController.h"
#import "ThirdViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    RootViewController *root = [[RootViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:root];
    navi.tabBarItem.image = [[UIImage imageNamed:@"tabbar_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navi.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navi.tabBarItem.title = @"首页";
    UserViewController *user = [[UserViewController alloc] init];
    UINavigationController *userNavi = [[UINavigationController alloc] initWithRootViewController:user];
    userNavi.tabBarItem.image = [[UIImage imageNamed:@"tabbar_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userNavi.tabBarItem.title = @"我的";
    
    ThirdViewController *third = [[ThirdViewController alloc] init];
    UINavigationController *thirdNavi = [[UINavigationController alloc] initWithRootViewController:third];
    thirdNavi.tabBarItem.image = [[UIImage imageNamed:@"tabbar_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdNavi.tabBarItem.title = @"我的";


    UITabBarController *tabBarC = [[UITabBarController alloc] init];
    tabBarC.viewControllers = @[navi, userNavi, thirdNavi];

    
    
    
    self.window.rootViewController = tabBarC;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
