//
//  ProfileView.m
//  MessengerApp
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "ProgressHUD.h"

#import "AppConstant.h"
#import "camera.h"
#import "common.h"
#import "image.h"
#import "push.h"

#import "ProfileView.h"
#import "PrivacyView.h"
#import "TermsView.h"
#import "NavigationController.h"

 @interface ProfileView()

@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet PFImageView *imageUser;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellName;
@property (strong, nonatomic) IBOutlet UITableViewCell *changeProfileImage;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPrivacy;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellTerms;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellButton;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellLogout;
@property (strong, nonatomic) IBOutlet UITextField *fieldName;


@end
 
@implementation ProfileView

@synthesize viewHeader, imageUser;
@synthesize cellPrivacy, cellTerms, cellLogout, fieldName, cellName, changeProfileImage, cellButton;

 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
		[self.tabBarItem setImage:[UIImage imageNamed:@"tab_profile"]];
		self.tabBarItem.title = @"Profile";
	}
	return self;
}

 - (void)viewDidLoad
 {
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(actionSave:)];

	[super viewDidLoad];
	self.title = @"Profile";
 	self.tableView.tableHeaderView = viewHeader;
 	imageUser.layer.cornerRadius = imageUser.frame.size.width/2;
	imageUser.layer.masksToBounds = YES;
}

 - (void)viewDidAppear:(BOOL)animated
 {
	[super viewDidAppear:animated];
 	if ([PFUser currentUser] != nil)
	{
		[self loadUser];
	}
	else LoginUser(self);
}

#pragma mark - Backend actions

 - (void)loadUser
 {
	PFUser *user = [PFUser currentUser];

	[imageUser setFile:user[PF_USER_PICTURE]];
	[imageUser loadInBackground];

     fieldName.text = user[PF_USER_FULLNAME];

}

#pragma mark - User actions

 - (void)actionPrivacy
 {
	PrivacyView *privacyView = [[PrivacyView alloc] init];
	privacyView.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:privacyView animated:YES];
}

 - (void)actionTerms
 {
	TermsView *termsView = [[TermsView alloc] init];
	termsView.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:termsView animated:YES];
}

 - (void)actionCleanup
 {
	imageUser.image = [UIImage imageNamed:@"settings_blank"];
}

 - (void)actionLogout
 {
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel"
										  destructiveButtonTitle:@"Log out" otherButtonTitles:nil];
	[action showFromTabBar:[[self tabBarController] tabBar]];
}

#pragma mark - UIActionSheetDelegate

 - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
 {
	if (buttonIndex != actionSheet.cancelButtonIndex)
	{
		[PFUser logOut];
		ParsePushUserResign();
		PostNotification(NOTIFICATION_USER_LOGGED_OUT);
		[self actionCleanup];
		LoginUser(self);
	}
}

 - (IBAction)actionPhoto:(id)sender
 {
	PresentPhotoLibrary(self, YES);
}

#pragma mark - UIImagePickerControllerDelegate

 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
 {
	UIImage *image = info[UIImagePickerControllerEditedImage];
 	UIImage *picture = ResizeImage(image, 280, 280);
	UIImage *thumbnail = ResizeImage(image, 60, 60);
 	imageUser.image = picture;
 	PFFile *filePicture = [PFFile fileWithName:@"picture.jpg" data:UIImageJPEGRepresentation(picture, 0.6)];
	[filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil) [ProgressHUD showError:@"Network error."];
	}];
 	PFFile *fileThumbnail = [PFFile fileWithName:@"thumbnail.jpg" data:UIImageJPEGRepresentation(thumbnail, 0.6)];
	[fileThumbnail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil) [ProgressHUD showError:@"Network error."];
	}];
 	PFUser *user = [PFUser currentUser];
	user[PF_USER_PICTURE] = filePicture;
	user[PF_USER_THUMBNAIL] = fileThumbnail;
	[user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil) [ProgressHUD showError:@"Network error."];
	}];
 	[picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
	return 3;
}

 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     switch (section) {
         case 0:
             return 1;
             break;
         case 1:
             return 3;
             break;
         case 2:
             return 1;
             break;
         default:
             return 0;
     };

}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
	if ((indexPath.section == 1) && (indexPath.row == 0)) return cellPrivacy;
	if ((indexPath.section == 1) && (indexPath.row == 1)) return cellTerms;
	if ((indexPath.section == 2) && (indexPath.row == 0)) return cellLogout;
     if (indexPath.section == 0) return cellName;
     if (indexPath.section == 1) {
         if (indexPath.row == 2) {
             return changeProfileImage;
         }
        
     }
     return nil;
}

#pragma mark - Table view delegate

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
 	if ((indexPath.section == 1) && (indexPath.row == 0)) [self actionPrivacy];
	if ((indexPath.section == 1) && (indexPath.row == 1)) [self actionTerms];
	if ((indexPath.section == 2) && (indexPath.row == 0)) [self actionLogout];
     
    
}
- (IBAction)actionSave:(id)sender

{
    [self dismissKeyboard];
    [self saveUser];
}
- (void)saveUser

{
    NSString *fullname = fieldName.text;
    if ([fullname length] != 0)
    {
        PFUser *user = [PFUser currentUser];
        user[PF_USER_FULLNAME] = fullname;
        user[PF_USER_FULLNAME_LOWER] = [fullname lowercaseString];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (error == nil)
             {
                 [ProgressHUD showSuccess:@"Saved."];
             }
             else [ProgressHUD showError:@"Network error."];
         }];
    }
    else [ProgressHUD showError:@"Name field must be set."];
}
- (void)dismissKeyboard

{
    [self.view endEditing:YES];
}

@end
