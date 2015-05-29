//
//  SelectMultipleView.h
//  MessengerApp
//
///  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//
#import <UIKit/UIKit.h>

 @protocol SelectMultipleDelegate
 
- (void)didSelectMultipleUsers:(NSMutableArray *)users;

@end

 @interface SelectMultipleView : UITableViewController
 
@property (nonatomic, assign) IBOutlet id<SelectMultipleDelegate>delegate;

@end
