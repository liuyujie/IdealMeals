//
//  IMAppDelegate.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 17/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMAppDelegate.h"
#import "Flurry.h"
#import <Crashlytics/Crashlytics.h>
@implementation IMAppDelegate
@synthesize tabController,VChome;

- (void)encodeWithCoder:(NSCoder *)enCoder {
    //[super encodeWithCoder:enCoder];
    
    [enCoder encodeObject:VChome];
    
    // Similarly for the other instance variables.
   
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{   
   // UIImage *tabBackground = [[UIImage imageNamed:@"IM_iP4_bottom-bar.jpg"]
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
         {
             [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"bottom-bar2.png"]];
             
             
             [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"press.png"]];
         }
    // resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 320, 49)];
    else
    {
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"IM_tab-bar_640x98.jpg"]];

    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"IM_i5_tab-bar_press-bg.jpg"]];
    }
    // Override point for customization after application launch.
   [Crashlytics startWithAPIKey:@"9a344ba4644c7661f8ee12e1e5573f21396bbaf0"];
   
    
    [Flurry startSession:@"WH3C8SKH4PC8FSJFYSH"];
    
    [Flurry logEvent:@"Application Started"];
    
   [Flurry setSessionReportsOnCloseEnabled:FALSE];
    
   [Flurry setSessionReportsOnPauseEnabled:FALSE];
    
    
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
