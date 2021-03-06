//
//  AppDelegate.m
//  XYRouter
//
//  Created by heaven on 15/1/21.
//  Copyright (c) 2015年 heaven. All rights reserved.
//

#import "AppDelegate.h"
#import "XYRouter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSString *manifestPath          = [[NSBundle mainBundle] pathForResource:@"manifest" ofType:@"json"];
    NSData *manifestData            = [[NSString stringWithContentsOfFile:manifestPath encoding:NSUTF8StringEncoding error:NULL] dataUsingEncoding:NSUTF8StringEncoding];;
    NSDictionary *manifest          = [NSJSONSerialization JSONObjectWithData:manifestData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *applicationRoutes = [manifest valueForKeyPath:@"application.routes"];
    NSString *applicationMain       = [manifest valueForKeyPath:@"application.main"];
    NSLog(@"%@", applicationRoutes);
    [applicationRoutes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [[XYRouter sharedInstance] mapKey:key
                    toControllerClassName:obj];
    }];

    UIViewController *vc        = [[XYRouter sharedInstance] viewControllerForKey:applicationMain];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.navigationBar.backgroundColor = [UIColor blueColor];

    self.window                                  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [XYRouter sharedInstance].rootViewController = nvc;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *, id> *)options
{
    NSLog(@"%@", url);
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"%@", url);
    return YES;
}

@end
