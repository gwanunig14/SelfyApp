//
//  SLFSettingsMenu.m
//  Selfy
//
//  Created by T.J. Mercer on 4/29/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFSettingsMenu.h"

#import <Parse/Parse.h>

@interface SLFSettingsMenu ()

@end

@implementation SLFSettingsMenu
{
    UIImageView * userAvatar;
    
    UILabel * selfyUser;
    UILabel * displayName;
    UILabel * emailAddress;
    
    UIButton * changePassword;
    UIButton * saveChanges;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        PFUser * user = [PFUser currentUser];
        
        selfyUser = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 40)];
        selfyUser.layer.cornerRadius = 6;
        selfyUser.text = user.username;
        selfyUser.textColor = [UIColor blackColor];
        [self.view addSubview:selfyUser];
        
        displayName = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 40)];
        displayName.layer.cornerRadius = 6;
        displayName.text = user[@"displayName"];
        displayName.textColor = [UIColor blackColor];
        [self.view addSubview:displayName];
        
        emailAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 200, 40)];
        emailAddress.layer.cornerRadius = 6;
        emailAddress.text = user.email;
        emailAddress.textColor = [UIColor blackColor];
        [self.view addSubview:emailAddress];
        
        changePassword = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 80, 40)];
        changePassword.layer.cornerRadius = 6;
        [changePassword setTitle:@"Change Password" forState:UIControlStateNormal];
        changePassword.backgroundColor = [UIColor redColor];
        changePassword.titleLabel.font = [UIFont systemFontOfSize:9];
        [self.view addSubview:changePassword];
        
        saveChanges = [[UIButton alloc]initWithFrame:CGRectMake(10, 250, 80, 40)];
        saveChanges.layer.cornerRadius = 6;
        [saveChanges setTitle:@"Save Changes" forState:UIControlStateNormal];
        saveChanges.backgroundColor = [UIColor redColor];
        saveChanges.titleLabel.font = [UIFont systemFontOfSize:10];
        [saveChanges addTarget:self action:@selector(saveNewInfo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveChanges];
        
        userAvatar = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 90, 90)];
        userAvatar.backgroundColor = [UIColor lightGrayColor];
        userAvatar.layer.cornerRadius = 18;
        userAvatar.image = [UIImage imageNamed:@"Calvin"];
        [self.view addSubview:userAvatar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)saveNewInfo
{
    PFUser * user = [PFUser user];
    NSLog(@"image saved");
    NSData * imageData = UIImagePNGRepresentation(userAvatar.image);
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData];
//    PFObject * newAvatar = [PFObject objectWithClassName:@"avatar"];
    user[@"avatar"]=imageFile;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
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
