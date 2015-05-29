//
//  LoginView.m
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppConstant.h"
#import "push.h"

#import "LoginView.h"


@interface LoginView()

@property (strong, nonatomic) IBOutlet UITableViewCell *cellEmail;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPassword;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellButton;

@property (strong, nonatomic) IBOutlet UITextField *fieldEmail;
@property (strong, nonatomic) IBOutlet UITextField *fieldPassword;

@end


@implementation LoginView

@synthesize cellEmail, cellPassword, cellButton;
@synthesize fieldEmail, fieldPassword;


- (void)viewDidLoad

{
	[super viewDidLoad];
	self.title = @"Login";
    
	
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
}


- (void)viewDidAppear:(BOOL)animated

{
	[super viewDidAppear:animated];
	[fieldEmail becomeFirstResponder];
}


- (void)dismissKeyboard

{
	[self.view endEditing:YES];
}

#pragma mark - User actions


- (IBAction)actionLogin:(id)sender

{
	NSString *email = [fieldEmail.text lowercaseString];
	NSString *password = fieldPassword.text;
	
	if ([email length] == 0)	{ [ProgressHUD showError:@"Email must be set."]; return; }
	if ([password length] == 0)	{ [ProgressHUD showError:@"Password must be set."]; return; }
	
	[ProgressHUD show:@"Signing in..." Interaction:NO];
	[PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error)
	{
		if (user != nil)
		{
			ParsePushUserAssign();
			[ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
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
	return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
	if (indexPath.row == 0) return cellEmail;
	if (indexPath.row == 1) return cellPassword;
	if (indexPath.row == 2) return cellButton;
	return nil;
}

#pragma mark - UITextField delegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
	if (textField == fieldEmail)
	{
		[fieldPassword becomeFirstResponder];
	}
	if (textField == fieldPassword)
	{
		[self actionLogin:nil];
	}
	return YES;
}

@end
