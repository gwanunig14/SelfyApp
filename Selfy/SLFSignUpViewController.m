//
//  SLFSignUpViewController.m
//  Selfy
//
//  Created by T.J. Mercer on 4/29/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFSignUpViewController.h"

#import "SLFTableViewController.h"

#import <Parse/Parse.h>

@interface SLFSignUpViewController () <UITextFieldDelegate>

@end

@implementation SLFSignUpViewController
{
    UIView * signupForm;
    UIImageView * avatar;
    
    NSArray * fieldNames;
    NSMutableArray * fields;
    
    float signupOrigY;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        [self.view addGestureRecognizer:tap];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem * cancelSignupButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSignUp)];
    
    cancelSignupButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelSignupButton;
    
    signupOrigY = (self.view.frame.size.height -240)/2;
    
    signupForm = [[UIView alloc] initWithFrame:CGRectMake(20, signupOrigY, 280, 240)];
    [self.view addSubview:signupForm];
    
    fieldNames = @[@"Username",
                   @"Password",
                   @"Display Name",
                   @"Email"];
    
    fields = [@[] mutableCopy];
    
    for (NSString * name in fieldNames)
    {
        NSInteger index = [fieldNames indexOfObject:name];
        
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(0, index * 50, 280, 40)];
        textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        textField.layer.cornerRadius = 6;
        textField.placeholder = name;
        textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.delegate = self;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [fields addObject:textField];
        
        [signupForm addSubview:textField];
    }
    
    UIButton * submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, [fieldNames count] * 50, 280, 40)];
    submitButton.backgroundColor = [UIColor blueColor];
    submitButton.layer.cornerRadius = 6;
    [submitButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [signupForm addSubview:submitButton];
    
}

-(void)signUp
{
    [self hideKeyboard];
    
    PFUser * user = [PFUser user];
    
    UIImage * avatarImage = [UIImage imageNamed:@"Me"];
    NSData * imageData = UIImagePNGRepresentation(avatarImage);
    PFFile * imageFile = [PFFile fileWithName:@"avatar.png" data:imageData];
   
 
    user.username = ((UITextField *)fields[0]).text;
    user.password = ((UITextField *)fields[1]).text;
    user.email = ((UITextField *)fields[3]).text;
    user[@"displayName"] = ((UITextField *)fields[2]).text;
    user[@"avatar"] = imageFile;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error == nil)
        {
            UINavigationController * pnc = (UINavigationController *)self.presentingViewController;
            [self cancelSignUp];
            pnc.navigationBarHidden = NO;
            pnc.viewControllers = @[[[SLFTableViewController alloc]initWithStyle:UITableViewStylePlain]];
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc]initWithStyle:UITableViewStylePlain]];
        } else {
            NSString * errorDescription = error.userInfo[@"error"];
            
            UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"NO! WRONG!" message:errorDescription delegate:self cancelButtonTitle:@"Try Something Else" otherButtonTitles: nil];
            
            [alertview show];
        }
    }];
}

-(void)cancelSignUp
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    NSInteger index = [fields indexOfObject:textField];
//    NSInteger emptyIndex =[fields count];
//    
//    for (UITextField * textFieldItem in fields)
//    {
//        NSInteger fieldIndex = [fields indexOfObject:textFieldItem];
//        if (emptyIndex == [fields count])
//        {
//            if ([textField.text isEqualToString:@""]) {
//                emptyIndex = fieldIndex;
//            }
//        }
//    }
//    
//    if (index <= emptyIndex) {
//        return YES;
//    }
//    return NO;
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    int extraSlide = 0;
    
    if (self.view.frame.size.height > 500) {
        extraSlide = 107;
    } else {
        NSInteger index = [fields indexOfObject:textField];
        extraSlide = index * 25 + 65;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        signupForm.frame = CGRectMake(20, signupOrigY - 107, 280, 240);
    }];
}

- (void)hideKeyboard
{
    for (UITextField * textFieldItem in fields)
    {
        [textFieldItem resignFirstResponder];
    }
    [UIView animateWithDuration:0.3 animations:^{
        signupForm.frame = CGRectMake(20, signupOrigY, 280, 240);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
