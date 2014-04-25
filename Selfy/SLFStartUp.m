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
    UIButton * submit;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //remove auto caps
        //animate boxes moving up
        userName = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, SCREEN_WIDTH - 100, 20)];
        userName.backgroundColor = [UIColor lightGrayColor];
        userName.autocapitalizationType = NO;
        [self.view addSubview:userName];
        
        password = [[UITextField alloc]initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 100, 20)];
        password.backgroundColor = [UIColor lightGrayColor];
        password.secureTextEntry = YES;
        [self.view addSubview:password];
        
        submit = [[UIButton alloc]initWithFrame:CGRectMake(50, 180, SCREEN_WIDTH - 100, 40)];
        [submit addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
        submit.backgroundColor = [UIColor redColor];
        submit.layer.cornerRadius = 20;
        [self.view addSubview:submit];
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
    NSString * uName = userName.text;
    NSString * pWord = password.text;
    
    PFUser * user = [PFUser currentUser];
    user.username = uName;
    user.password = pWord;
        
    userName.text = nil;
    password.text = nil;
    
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [activityIndicator setColor:[UIColor orangeColor]];
    activityIndicator.color = [UIColor orangeColor];
    activityIndicator.frame = CGRectMake(0, 240, self.view.frame.size.width, 50);
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    //uiactivityindicatorview
    //start...
    //addsubview
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
        if (error == nil)
        {
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc]initWithStyle:UITableViewStylePlain]];
        } else {
//            error.userInfo[@"error"];
            
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
