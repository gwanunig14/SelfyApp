//
//  SLFStartUp.m
//  Selfy
//
//  Created by T.J. Mercer on 4/22/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFStartUp.h"

#import <Parse/Parse.h>

#import "SLFTableViewController.h"

#import "SLFSignUpViewController.h"

@interface SLFStartUp ()

@end

@implementation SLFStartUp

{
    UITextField * userName;
    UITextField * password;
    UIButton * submit;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        userName = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, SCREEN_WIDTH - 100, 20)];
        userName.backgroundColor = [UIColor lightGrayColor];
        userName.autocapitalizationType = NO;
        [self.view addSubview:userName];
        
        password = [[UITextField alloc]initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 100, 20)];
        password.backgroundColor = [UIColor lightGrayColor];
        password.secureTextEntry = YES;
        [self.view addSubview:password];
        
        submit = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 280, 40)];
        [submit addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
        submit.backgroundColor = [UIColor redColor];
        submit.layer.cornerRadius = 20;
        [self.view addSubview:submit];
        
        UIButton * signupButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 150, 280, 40)];
        [signupButton addTarget:self action:@selector(showSignUp) forControlEvents:UIControlEventTouchUpInside];
        signupButton.backgroundColor = [UIColor blueColor];
        signupButton.layer.cornerRadius = 6;
        [self.view addSubview:signupButton];
        
    }
    return self;
}

-(void)showSignUp
{
    SLFSignUpViewController * signUpVC = [[SLFSignUpViewController alloc]initWithNibName:nil bundle:nil];
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:signUpVC];
    
    nc.navigationBar.barTintColor = [UIColor blueColor];
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logIn
{
    [self hideKeyboard];
    
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.color = [UIColor orangeColor];
    activityIndicator.frame = CGRectMake(0, 200, 280, 50);
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [PFUser logInWithUsernameInBackground:userName.text password:password.text block:^(PFUser *user, NSError *error)
    {
        if (error == nil)
        {
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc]initWithStyle:UITableViewStylePlain]];
        } else {
            password.text = nil;
            
            [activityIndicator removeFromSuperview];
            
            UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"NO! WRONG!" message:error.userInfo[@"error"] delegate:self cancelButtonTitle:@"Try Something Else" otherButtonTitles: nil];
            
            [alertview show];
        }
    }];
}

-(void)hideKeyboard
{
    [userName resignFirstResponder];
    [password resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
