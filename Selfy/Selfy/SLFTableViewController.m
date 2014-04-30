//
//  SLFTableViewController.m
//  Selfy
//
//  Created by T.J. Mercer on 4/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFTableViewController.h"

#import "SLFTableViewCell.h"

#import "SLFNewNavController.h"

#import "SLFPhoto.h"

#import "SLFSettingsButton.h"

#import "SLFSettingsMenu.h"

#import <Parse/Parse.h>

@interface SLFTableViewController ()

@end

@implementation SLFTableViewController
{
    SLFSettingsButton * settingsMenuButton;
    NSArray * allPictures;
    UIButton * settings;
    UIButton * newUser;
    UIViewController * settingsMenu;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    
    //make nav bar settings button
    
    self = [super initWithStyle:style];
    if (self)
    {
        self.tableView.rowHeight = self.tableView.frame.size.width + 100;
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 5, SCREEN_WIDTH/3, 20)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"Selfy";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem * addNewSelfyButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(openNewSelfy)];
    self.navigationItem.rightBarButtonItem = addNewSelfyButton;
    
    settingsMenuButton = [[SLFSettingsButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [settingsMenuButton addTarget:self action:@selector(openMenuBar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * menuButton = [[UIBarButtonItem alloc]initWithCustomView:settingsMenuButton];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    settingsMenu = [[SLFSettingsMenu alloc] init];
    settingsMenu.view.frame = CGRectMake(50-SCREEN_WIDTH, 0, SCREEN_WIDTH-50, SCREEN_HEIGHT);
    
    NSLog(@"%@",self.navigationController);
}

-(void)openNewSelfy
{
    SLFPhoto * newSelfVC = [[SLFPhoto alloc]initWithNibName:nil bundle:nil];
    SLFNewNavController * nc = [[SLFNewNavController alloc] initWithRootViewController:newSelfVC];
    
    nc.navigationBar.barTintColor = MAGENTA_COLOR;
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [allPictures count];
}

-(void)refreshSelfies
{
    PFQuery * query = [PFQuery queryWithClassName:@"UserSelfy"];
    
    [query orderByDescending:@"createdAt"];
    
    [query whereKey:@"parent" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        allPictures = objects;
        [self.tableView reloadData];
    }];

}

-(void)openMenuBar
{
    NSLog(@"%@",self.navigationController);
    [self.navigationController.view addSubview:settingsMenu.view];
    
    
    if (self.navigationController.view.frame.origin.x == 0)
    {
        [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = CGRectMake(SCREEN_WIDTH-50, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
       
        settingsMenuButton.menuOpen = TRUE;
        [settingsMenuButton setNeedsDisplay];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        settingsMenuButton.menuOpen = FALSE;
        [settingsMenuButton setNeedsDisplay];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary * pictures = pictureInfo[indexPath.row];
    
    SLFTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[SLFTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.pictureInfo = allPictures[indexPath.row];
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self refreshSelfies];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden { return YES; }


@end
