//
//  FacebookFriendsView.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <Parse/Parse.h>

 @protocol FacebookFriendsDelegate
 
- (void)didSelectFacebookUser:(PFUser *)user;

@end

 @interface FacebookFriendsView : UITableViewController <UISearchBarDelegate>
 
@property (nonatomic, assign) IBOutlet id<FacebookFriendsDelegate>delegate;

@end
