//
//  AppDelegate.m
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "AppConstant.h"
#import "common.h"
#import "AppDelegate.h"
#import "RecentView.h"
#import "GroupsView.h"
#import "FriendsView.h"
#import "ProfileView.h"
#import "NavigationController.h"

@implementation AppDelegate

 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 {
    [Parse setApplicationId:@"BdWLoFKY7oCVRkUlkH6EaLzhhy35CxmVreEmlpl7" clientKey:@"7sgHoyW9Xj6NjQpBSooomCNg9l4Zl500ytR4A9O0"];

    [PFFacebookUtils initializeFacebook];
     
 	if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
	{
		UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
		UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
		[application registerUserNotificationSettings:settings];
		[application registerForRemoteNotifications];
	}
 	[PFImageView class];
     
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
     [[UITabBar appearance] setTintColor:[UIColor blackColor]];

 	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	self.recentView = [[RecentView alloc] init];
	self.groupsView = [[GroupsView alloc] init];
	self.peopleView = [[PeopleView alloc] init];
	self.settingsView = [[ProfileView alloc] init];

	NavigationController *navController1 = [[NavigationController alloc] initWithRootViewController:self.recentView];
	NavigationController *navController2 = [[NavigationController alloc] initWithRootViewController:self.groupsView];
	NavigationController *navController3 = [[NavigationController alloc] initWithRootViewController:self.peopleView];
	NavigationController *navController4 = [[NavigationController alloc] initWithRootViewController:self.settingsView];

	self.tabBarController = [[UITabBarController alloc] init];
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, navController3, navController4, nil];
	self.tabBarController.tabBar.translucent = NO;
	self.tabBarController.selectedIndex = DEFAULT_TAB;

	self.window.rootViewController = self.tabBarController;
	[self.window makeKeyAndVisible];
 	return YES;
}

 - (void)applicationWillResignActive:(UIApplication *)application
 {
	
}

 - (void)applicationDidEnterBackground:(UIApplication *)application
 {
	
}

 - (void)applicationWillEnterForeground:(UIApplication *)application
 {
	
}

 - (void)applicationDidBecomeActive:(UIApplication *)application
 {
	[self locationManagerStart];
	[FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

 - (void)applicationWillTerminate:(UIApplication *)application
 {
	
}

#pragma mark - Facebook responses

 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
	return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

#pragma mark - Push notification methods

 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
 {
	PFInstallation *currentInstallation = [PFInstallation currentInstallation];
	[currentInstallation setDeviceTokenFromData:deviceToken];
	[currentInstallation saveInBackground];
}

 - (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
 {
	//NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
 {
	//[PFPush handlePush:userInfo];
 	if ([PFUser currentUser] != nil)
	{
		[self performSelector:@selector(refreshRecentView) withObject:nil afterDelay:4.0];
	}
}

 - (void)refreshRecentView
 {
	[self.recentView loadRecents];
}

#pragma mark - Location manager methods

 - (void)locationManagerStart
 {
	if (self.locationManager == nil)
	{
		self.locationManager = [[CLLocationManager alloc] init];
		[self.locationManager setDelegate:self];
		[self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
		[self.locationManager requestWhenInUseAuthorization];
	}
	[self.locationManager startUpdatingLocation];
}

 - (void)locationManagerStop
 {
	[self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

 - (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
 {
	self.coordinate = newLocation.coordinate;
}

 - (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
 {
	
}

@end
