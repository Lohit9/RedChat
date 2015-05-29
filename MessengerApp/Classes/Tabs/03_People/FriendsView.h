//
//  FriendsView.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SelectSingleView.h"
#import "SelectMultipleView.h"
#import "AddressBookView.h"
#import "FacebookFriendsView.h"

 @interface PeopleView : UITableViewController <UIActionSheetDelegate, SelectSingleDelegate, SelectMultipleDelegate, AddressBookDelegate, FacebookFriendsDelegate>
 
@end
