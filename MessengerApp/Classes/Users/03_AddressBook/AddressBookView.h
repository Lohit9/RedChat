//
//  AdressBookView.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <Parse/Parse.h>

 @protocol AddressBookDelegate
 
- (void)didSelectAddressBookUser:(PFUser *)user;

@end

 @interface AddressBookView : UITableViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>
 
@property (nonatomic, assign) IBOutlet id<AddressBookDelegate>delegate;

@end
