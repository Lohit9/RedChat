//
//  SelectSingleView.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <Parse/Parse.h>

 @protocol SelectSingleDelegate
 
- (void)didSelectSingleUser:(PFUser *)user;

@end

 @interface SelectSingleView : UITableViewController <UISearchBarDelegate>
 
@property (nonatomic, assign) IBOutlet id<SelectSingleDelegate>delegate;

@end
