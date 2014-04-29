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

@interface SLFStartUp ()

@end

@implementation SLFStartUp

{
    UITextField * userName;
    UITextField * password;
    UIButton * logIn;
    UIButton * signUp;
    UIButton * submit;
    UITextField * fullName;
    UITextField * eMail;
    UIImageView * avatar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        userName = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, SCREEN_WIDTH - 100, 20)];
        userName.backgroundColor = [UIColor lightGrayColor];
        userName.autocapitalizationType = NO;
        userName.placeholder = @"username";
        [self.view addSubview:userName];
        
        password = [[UITextField alloc]initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 100, 20)];
        password.backgroundColor = [UIColor lightGrayColor];
        password.secureTextEntry = YES;
        password.placeholder = @"password";
        [self.view addSubview:password];
        
        fullName = [[UITextField alloc]initWithFrame:CGRectMake(20, -20, SCREEN_WIDTH/4, 20)];
        fullName.backgroundColor = [UIColor lightGrayColor];
        fullName.placeholder = @"your name";
        [self.view addSubview:fullName];
        
        eMail = [[UITextField alloc]initWithFrame:CGRectMake(20, -20, SCREEN_WIDTH/4, 20)];
        eMail.backgroundColor = [UIColor lightGrayColor];
        eMail.placeholder = @"e-mail address";
        [self.view addSubview:eMail];
        
        avatar = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.75 -20,-100, SCREEN_WIDTH/4, SCREEN_WIDTH/4)];
        avatar.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:avatar];
        
        submit = [[UIButton alloc]initWithFrame:CGRectMake(50, 180, SCREEN_WIDTH - 100, 40)];
        [submit setTitle:@"submit" forState:UIControlStateNormal];
        submit.titleLabel.font = [UIFont systemFontOfSize:8];
        submit.backgroundColor = [UIColor redColor];
        submit.layer.cornerRadius = 20;
        [self.view addSubview:submit];
        
        logIn = [[UIButton alloc]initWithFrame:CGRectMake(50, 180, SCREEN_WIDTH - 100, 40)];
        [logIn setTitle:@"Log In" forState:UIControlStateNormal];
        [logIn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
        logIn.backgroundColor = [UIColor redColor];
        logIn.layer.cornerRadius = 20;
        [self.view addSubview:logIn];
        
        signUp =  [[UIButton alloc]initWithFrame:CGRectMake(50, 240, SCREEN_WIDTH - 100, 40)];
        [signUp setTitle:@"Sign Up" forState:UIControlStateNormal];
        [signUp addTarget:self action:@selector(newSignUp) forControlEvents:UIControlEventTouchUpInside];
        signUp.backgroundColor = [UIColor blueColor];
        signUp.layer.cornerRadius = 20;
        [self.view addSubview:signUp];
        
        
        //sign in button. sign up button.
        //sign in show username password and log in
        //sign up will present a view with username password email first name last name and add avatar
        //find pfuser log in method
        
        
        
    }
    return self;
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
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.color = [UIColor orangeColor];
    activityIndicator.frame = CGRectMake(0, 240, self.view.frame.size.width, 50);
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [PFUser logInWithUsernameInBackground:userName.text password:password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (error == nil)
                                        {
                                            self.navigationController.navigationBarHidden = NO;
                                            self.navigationController.viewControllers = @[[[SLFTableViewController alloc]initWithStyle:UITableViewStylePlain]];
                                        } else {
                                            
                                            [activityIndicator removeFromSuperview];
                                            
                                            UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"NO! WRONG!" message:error.userInfo[@"error"] delegate:self cancelButtonTitle:@"Try Something Else" otherButtonTitles: nil];
                                            
                                            [alertview show];
                                        }
                                    }];
}

-(void)newSignUp
{
    [UIView animateWithDuration:1.0 animations:^{
        userName.frame = CGRectMake(20, 120, SCREEN_WIDTH/2-20, 20);
        password.frame = CGRectMake(20, 150, SCREEN_WIDTH/2-20, 20);
        avatar.frame = CGRectMake(SCREEN_WIDTH*0.75 -20, 180-(SCREEN_WIDTH/4 + 10), SCREEN_WIDTH/4, SCREEN_WIDTH/4);
        eMail.frame = CGRectMake(20, 90, SCREEN_WIDTH/2-20, 20);
        fullName.frame = CGRectMake(20, 60, SCREEN_WIDTH/2-20, 20);
        signUp.alpha = 0.0;
        logIn.frame = CGRectMake(240, 180, 40, 40);
        submit.frame = CGRectMake(240, 180, 40, 40);
    }];
    [signUp removeFromSuperview];
    [logIn removeFromSuperview];
    [submit addTarget:self action:@selector(contactParse) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)contactParse
{
    
    PFUser * user = [PFUser currentUser];
    user.username = userName.text;
    user.password = password.text;
    
    NSData * imageData = UIImagePNGRepresentation(avatar.image);
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    PFObject * addedUser = [PFObject objectWithClassName:@"UserAvatar"];
    addedUser[@"avatar"]=imageFile;
    addedUser[@"name"]=fullName.text;
    addedUser[@"email"]=eMail.text;
    
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.color = [UIColor orangeColor];
    activityIndicator.frame = CGRectMake(0, 240, self.view.frame.size.width, 50);
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error == nil)
         {
             self.navigationController.navigationBarHidden = NO;
             self.navigationController.viewControllers = @[[[SLFTableViewController alloc]initWithStyle:UITableViewStylePlain]];
             [addedUser saveInBackground];
         } else {
             
             [activityIndicator removeFromSuperview];
             
             UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"NO! WRONG!" message:error.userInfo[@"error"] delegate:self cancelButtonTitle:@"Try Something Else" otherButtonTitles: nil];
             
             [alertview show];
         }
     }];
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
