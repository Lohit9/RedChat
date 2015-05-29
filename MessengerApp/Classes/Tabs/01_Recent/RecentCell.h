//
//  RecentCell.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <Parse/Parse.h>

 @interface RecentCell : UITableViewCell
 
- (void)bindData:(PFObject *)recent_;

@end
