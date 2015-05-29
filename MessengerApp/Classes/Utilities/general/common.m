//
//  common.m
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//
#import "common.h"
#import "WelcomeView.h"
#import "NavigationController.h"

 void LoginUser(id target)
 {
	NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:[[WelcomeView alloc] init]];
	[target presentViewController:navigationController animated:YES completion:nil];
}

 void PostNotification(NSString *notification)
 {
	[[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
}
