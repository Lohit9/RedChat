//
//  recent.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//
#import <Parse/Parse.h>

 NSString*		StartPrivateChat		(PFUser *user1, PFUser *user2);
NSString*		StartMultipleChat		(NSMutableArray *users);

 void			CreateRecentItem		(PFUser *user, NSString *groupId, NSString *description);

 void			UpdateRecentCounter		(NSString *groupId, NSInteger amount, NSString *lastMessage);
void			ClearRecentCounter		(NSString *groupId);
