//
//  SLFAppDelegate.m
//  Selfy
//
//  Created by T.J. Mercer on 4/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFAppDelegate.h"

#import "SLFTableViewController.h"

#import "SLFStartUp.h"

#import "SLFPhoto.h"

#import <Parse/Parse.h>

@implementation SLFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    [Parse setApplicationId:@"H1JHLiA7kFRmIWvtbkHDcnA1Caj4UofHxRx6UZAB"
//                  clientKey:@"dKLyXccYHUy1MXNgrdR2Sq5b1fNQoTr4clSXVd3p"];
    
    //my app key
    [Parse setApplicationId:@"3pRyf1ZJCSsHrvxnXJ2ByqFoosleRgNuZkymyGPd"
                  clientKey:@"cP84RvksuZhKaL6d4Na4QmETtMGThMAVaWOlDk70"];
    
    [PFUser enableAutomaticUser];
    
    UINavigationController * navController;
    
    PFUser * user = [PFUser currentUser];
    
    NSString * username = user.username;
    
//    username = nil;
    
    if (username == nil) {
        navController = [[UINavigationController alloc]initWithRootViewController:[[SLFStartUp alloc]initWithNibName:nil bundle:nil]];
        navController.navigationBarHidden = YES;
    }else{
        navController = [[UINavigationController alloc]initWithRootViewController:[[SLFTableViewController alloc]initWithStyle:UITableViewStylePlain]];
    }
    self.window.rootViewController = navController;
    
//    self.window.rootViewController = [[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
//    self.window.rootViewController = [[SLFStartUp alloc] initWithNibName:nil bundle:nil];
    
//    self.window.rootViewController = [[SLFPhoto alloc] initWithNibName:nil bundle:nil];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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



@end
