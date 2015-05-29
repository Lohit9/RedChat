//
//  RegisterView.m
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppConstant.h"
#import "push.h"

#import "RegisterView.h"


@interface RegisterView()

@property (strong, nonatomic) IBOutlet UITableViewCell *cellName;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPassword;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellEmail;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellButton;

@property (strong, nonatomic) IBOutlet UITextField *fieldName;
@property (strong, nonatomic) IBOutlet UITextField *fieldPassword;
@property (strong, nonatomic) IBOutlet UITextField *fieldEmail;

@end


@implementation RegisterView

@synthesize cellName, cellPassword, cellEmail, cellButton;
@synthesize fieldName, fieldPassword, fieldEmail;


- (void)viewDidLoad

{
	[super viewDidLoad];
	self.title = @"Register";
	
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
}


- (void)viewDidAppear:(BOOL)animated

{
	[super viewDidAppear:animated];
	[fieldName becomeFirstResponder];
}


- (void)dismissKeyboard

{
	[self.view endEditing:YES];
}

#pragma mark - User actions


- (IBAction)actionRegister:(id)sender

{
	NSString *name		= fieldName.text;
	NSString *password	= fieldPassword.text;
	NSString *email		= [fieldEmail.text lowercaseString];
	
	if ([name length] == 0)		{ [ProgressHUD showError:@"Name must be set."]; return; }
	if ([password length] == 0)	{ [ProgressHUD showError:@"Password must be set."]; return; }
	if ([email length] == 0)	{ [ProgressHUD showError:@"Email must be set."]; return; }
	
	[ProgressHUD show:@"Please wait..." Interaction:NO];

	PFUser *user = [PFUser user];
	user.username = email;
	user.password = password;
	user.email = email;
	user[PF_USER_EMAILCOPY] = email;
	user[PF_USER_FULLNAME] = name;
	user[PF_USER_FULLNAME_LOWER] = [name lowercaseString];
	[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error == nil)
		{
			ParsePushUserAssign();
			[ProgressHUD showSuccess:@"Succeed."];
			[self dismissViewControllerAnimated:YES completion:nil];
		}
		else [ProgressHUD showError:error.userInfo[@"error"]];
	}];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
	return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
	if (indexPath.row == 0) return cellName;
	if (indexPath.row == 1) return cellPassword;
	if (indexPath.row == 2) return cellEmail;
	if (indexPath.row == 3) return cellButton;
	return nil;
}

#pragma mark - UITextField delegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
	if (textField == fieldName)
	{
		[fieldPassword becomeFirstResponder];
	}
	if (textField == fieldPassword)
	{
		[fieldEmail becomeFirstResponder];
	}
	if (textField == fieldEmail)
	{
		[self actionRegister:nil];
	}
	return YES;
}

@end
