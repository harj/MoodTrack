//
//  MTAppDelegate.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MTAppDelegate.h"
#import "MoodTable.h"
#import <Parse/Parse.h>

@implementation MTAppDelegate

@synthesize window = _window;

- (void)scheduleAlarmForDate:(NSDate*)theDate
{
    UIApplication* app = [UIApplication sharedApplication];
    NSArray*    oldNotifications = [app scheduledLocalNotifications];
    
    // Clear out the old notification before scheduling a new one.
    if ([oldNotifications count] > 0)
        [app cancelAllLocalNotifications];
    
    // Create a new notification.
    UILocalNotification* alarm = [[UILocalNotification alloc] init];
    if (alarm) {
        alarm.fireDate = theDate;
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = 0;
        // alarm.soundName = @"alarmsound.caf";
        alarm.alertBody = @"How are you feeling?";
        
        [app scheduleLocalNotification:alarm];
        NSLog(@"scheduling notification...");
    } else {
        NSLog(@"COULD NOT ALLOCATE UILocalNotification!");
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"Received UILocalNotification!!!!!!!!!!");
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDate *currentTime = [[NSDate alloc] init];
    NSDate *d = [[NSDate alloc] initWithTimeInterval:15 sinceDate:currentTime];
    [self scheduleAlarmForDate:d];
    
    [Parse setApplicationId:@"pNRcpH7eSXGzWGXhejabGFeyJEAhcdBLSe0Ft7XH" 
                  clientKey:@"FIkw3oKAycqaL3MLiSw862gAEMxywhIHdoxsuuHM"];

    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
