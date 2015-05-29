//
//  AppDelegate.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecentView.h"
#import "GroupsView.h"
#import "FriendsView.h"
#import "ProfileView.h"

 @interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
 
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) RecentView *recentView;
@property (strong, nonatomic) GroupsView *groupsView;
@property (strong, nonatomic) PeopleView *peopleView;
@property (strong, nonatomic) ProfileView *settingsView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
