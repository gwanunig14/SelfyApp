//
//  SLFStartUp.m
//  Selfy
//
//  Created by T.J. Mercer on 4/22/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFStartUp.h"

#import "SLFTableViewController.h"

#import "SLFPhoto.h"

#import <Parse/Parse.h>

@interface SLFStartUp () <UITextFieldDelegate>

@end

@implementation SLFStartUp

{
    UIView * buttonSpace;
    UITextField * userName;
    UITextField * password;
    UIButton * submit;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        buttonSpace = [[UIView alloc]initWithFrame: self.view.frame];
        [self.view addSubview:buttonSpace];
        
        [self.navigationController setNavigationBarHidden:YES];
        
//        [self.navigationController.navigationBar removeFromSuperview];
        
        userName = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, SCREEN_WIDTH - 100, 40)];
        userName.backgroundColor = [UIColor lightGrayColor];
        [buttonSpace addSubview:userName];
        userName.delegate = self;
        
        password = [[UITextField alloc]initWithFrame:CGRectMake(50, 180, SCREEN_WIDTH - 100, 40)];
        password.backgroundColor = [UIColor lightGrayColor];
        password.secureTextEntry = YES;
        [buttonSpace addSubview:password];
        password.delegate = self;
        
        submit = [[UIButton alloc]initWithFrame:CGRectMake(50, 240, SCREEN_WIDTH - 100, 80)];
        [submit addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
        submit.backgroundColor = [UIColor redColor];
        submit.layer.cornerRadius = 40;
        [buttonSpace addSubview:submit];
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 5, SCREEN_WIDTH/3, 20)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"Selfy";
        [self.navigationController.navigationBar addSubview:title];
        
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
    
    if(![uName isEqualToString:@""])
    {
    PFUser * user = [PFUser currentUser];
    user.username = uName;
    user.password = pWord;
    
    [user saveInBackground];
    }
    
    UITableViewController * pastPhotos = [[SLFTableViewController alloc]init];
    
    [self.navigationController pushViewController:pastPhotos animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        buttonSpace.frame = CGRectMake(0, -60, SCREEN_WIDTH, self.view.frame.size.height);

    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
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
