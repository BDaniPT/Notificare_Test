//
//  AppDelegate.m
//  Notificare_Test
//
//  Created by Bruno Tavares on 06/07/15.
//  Copyright (c) 2015 Bruno Tavares. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Notifications
    [[NotificarePushLib shared] launch];
    [[NotificarePushLib shared] setDelegate:self];
    [[NotificarePushLib shared] handleOptions:launchOptions];
    
    // Location Services
    //[[NotificarePushLib shared] startLocationUpdates];
    
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

#pragma mark NotificarePushLibDelegate methods

- (void)notificarePushLib:(NotificarePushLib *)library onReady:(NSDictionary *)info{
    
    [[NotificarePushLib shared] registerForWebsockets];
}

-(void)notificarePushLib:(NotificarePushLib *)library didRegisterForWebsocketsNotifications:(NSString *)token{
    
    //If you don't identify users you can just use this:
    //[[NotificarePushLib shared] registerDeviceForWebsockets:token completionHandler:^(NSDictionary *info) {} errorHandler:^(NSError *error) {}];
    //If you want to create a user profile with just an id:
    //[[NotificarePushLib shared] registerDeviceForWebsockets:token withUserID:@"[SOME_ID]" completionHandler:^(NSDictionary *info) errorHandler:^(NSError *error)
    //If you use an id and a display name:
    [[NotificarePushLib shared] registerDeviceForWebsockets:token withUserID:@"[SOME_ID]" withUsername:@"[SOME_NAME]" completionHandler:^(NSDictionary *info) {
        
        //User is registered now it's safe to add tags, start location services and maybe save the deviceToken?
        [[NotificarePushLib shared] startLocationUpdates];
        [[NotificarePushLib shared] addTags:@[@"onetag",@"twotags"]];
        
    } errorHandler:^(NSError *error) {
        
        //error registering the device act accordingly
        
    }];
}

-(void)notificarePushLib:(NotificarePushLib *)library didFailToRegisterWebsocketNotifications:(NSError *)error{
    
    //You might want to reconnect again
    [[NotificarePushLib shared] registerForWebsockets];
}
-(void)notificarePushLib:(NotificarePushLib *)library didCloseWebsocketConnection:(NSString *)reason{
    
    //You might want to reconnect again
    [[NotificarePushLib shared] registerForWebsockets];
}

-(void)notificarePushLib:(NotificarePushLib *)library didReceiveWebsocketNotification:(NSDictionary *)info{
    
    NSMutableDictionary * payload = [NSMutableDictionary dictionaryWithDictionary:info];
    [payload setObject:@{@"alert":[info objectForKey:@"alert"]} forKey:@"aps"];
    [[NotificarePushLib shared] openNotification:payload];
}


- (void)notificarePushLib:(NotificarePushLib *)library willOpenNotification:(NotificareNotification *)notification{
    
    NSLog(@"%@",notification);
}

- (void)notificarePushLib:(NotificarePushLib *)library didOpenNotification:(NotificareNotification *)notification{
    
    NSLog(@"%@",notification);
}

- (void)notificarePushLib:(NotificarePushLib *)library didCloseNotification:(NotificareNotification *)notification{
    
    NSLog(@"%@",notification);
}

- (void)notificarePushLib:(NotificarePushLib *)library didFailToOpenNotification:(NotificareNotification *)notification{
    
    NSLog(@"%@",notification);
}

- (void)notificarePushLib:(NotificarePushLib *)library willExecuteAction:(NotificareNotification *)notification{
    
    NSLog(@"%@",notification);
}

- (void)notificarePushLib:(NotificarePushLib *)library didExecuteAction:(NSDictionary *)info{
    
    NSLog(@"%@",info);
}

-(void)notificarePushLib:(NotificarePushLib *)library shouldPerformSelector:(NSString *)selector{
    
    SEL mySelector = NSSelectorFromString(selector);
    
    if([self respondsToSelector:mySelector]){
        
        Suppressor([self performSelector:mySelector]);
    }
}

- (void)notificarePushLib:(NotificarePushLib *)library didNotExecuteAction:(NSDictionary *)info{
    
    NSLog(@"%@",info);
}

- (void)notificarePushLib:(NotificarePushLib *)library didFailToExecuteAction:(NSError *)error{
    
    NSLog(@"%@",error);
}

#pragma mark Location Services methods

- (void)notificarePushLib:(NotificarePushLib *)library didReceiveLocationServiceAuthorizationStatus:(NSDictionary *)status{
    
    NSLog(@"Location Services status: %@", status);
}

- (void)notificarePushLib:(NotificarePushLib *)library didFailToStartLocationServiceWithError:(NSError *)error{
    
    NSLog(@"didFailWithError: %@", error);
}
/*
- (void)notificarePushLib:(NotificarePushLib *)library didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"didUpdateLocations: %@", locations);
}
*/
- (void)notificarePushLib:(NotificarePushLib *)library didStartMonitoringForRegion:(CLRegion *)region{
    
    NSLog(@"didStartMonitoringForRegion: %@", region);
}

- (void)notificarePushLib:(NotificarePushLib *)library monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    
    NSLog(@"monitoringDidFailForRegion: Region > %@ Error > %@", region, error);
}

- (void)notificarePushLib:(NotificarePushLib *)library didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
    switch (state) {
        case CLRegionStateInside:
            
            NSLog(@"didDetermineStateForRegion: State > Inside Region > %@", region);
            break;
        case CLRegionStateOutside:
            
            NSLog(@"didDetermineStateForRegion: State > Outside Region > %@", region);
            break;
        case CLRegionStateUnknown:
            
            break;
        default:
            
            break;
    }
}

@end
