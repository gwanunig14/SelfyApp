//
//  PhotoEditor.m
//  Selfy
//
//  Created by T.J. Mercer on 5/3/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "PhotoEditor.h"

#import "PPAFilterController.h"

#import "Parse/parse.h"

@interface PhotoEditor () <PPAFilterControllerDelegate>

@end

@implementation PhotoEditor
{
    PPAFilterController * filters;
    UIImageView * pictureToEdit;
    UIButton * cancel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    
    int h = self.view.frame.size.height;
    int w = self.view.frame.size.width;
    
    self.view.backgroundColor = [UIColor whiteColor];
    pictureToEdit = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, w - 40, h - 200)];
//    pictureToEdit.backgroundColor = [UIColor blackColor];
    [pictureToEdit setContentMode:UIViewContentModeScaleAspectFit];
    pictureToEdit.image = self.imageViewPicture;
    [self.view addSubview:pictureToEdit];
    
    filters = [[PPAFilterController alloc]initWithNibName:nil bundle:nil];
    filters.delegate = self;
    filters.view.frame = CGRectMake(0, h-100, w, 100);
    [self.view addSubview:filters.view];
    
    UIBarButtonItem * cancelNewSelfyButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelNewSelfy)];
    cancelNewSelfyButton.tintColor = PURPLE_COLOR;
    self.navigationItem.rightBarButtonItem = cancelNewSelfyButton;
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem * updateSelfy = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(changeSelfy)];
    updateSelfy.tintColor = PURPLE_COLOR;
    self.navigationItem.leftBarButtonItem = updateSelfy;
    [self setNeedsStatusBarAppearanceUpdate];
    
    filters.imageToFilter = pictureToEdit.image;
}

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image
{
    pictureToEdit.image = image;
    
}

-(void)changeSelfy
{
    NSData * imageData = UIImagePNGRepresentation(pictureToEdit.image);
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    newSelfy[@"image"]=imageFile;
    newSelfy[@"parent"]=[PFUser currentUser];
    [newSelfy saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self cancelNewSelfy];
        NSLog(@"saved");
    }];
}

-(void)cancelNewSelfy
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
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
