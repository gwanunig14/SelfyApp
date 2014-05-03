//
//  PhotoEditor.m
//  Selfy
//
//  Created by T.J. Mercer on 5/3/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "PhotoEditor.h"

#import "PPAFilterController.h"


@interface PhotoEditor ()

@end

@implementation PhotoEditor
{
    PPAFilterController * filters;
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
    self.pictureToEdit = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 200)];
    self.pictureToEdit.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.pictureToEdit];
    
    filters = [[PPAFilterController alloc]initWithNibName:nil bundle:nil];
    filters.view.frame = CGRectMake(0, SCREEN_HEIGHT-170, SCREEN_WIDTH, 100);
    [self.view addSubview:filters.view];
    
    
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
