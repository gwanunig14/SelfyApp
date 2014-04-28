//
//  SLFTableViewController.m
//  Selfy
//
//  Created by T.J. Mercer on 4/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFTableViewController.h"

#import "SLFTableViewCell.h"

#import "SLFPhoto.h"

#import <Parse/Parse.h>

@interface SLFTableViewController ()

@end

@implementation SLFTableViewController
{
    UIView * header;
    NSArray * allPictures;
    UIButton * settings;
    UIButton * newUser;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.tableView.rowHeight = self.tableView.frame.size.width + 100;
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//        self.tableView.tableHeaderView = header;
        [self.view addSubview:header];
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 5, SCREEN_WIDTH/3, 20)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"Selfy";
        [header addSubview:title];
        
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
}

-(void)openNewSelfy
{
    SLFPhoto * newSelfVC = [[SLFPhoto alloc]initWithNibName:nil bundle:nil];
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:newSelfVC];
    
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
    
    //after user connected to selfy: filter only your user's selfies
    
    //nothing happens til this is done which is handy if you need its result firs.
//    allPictures = [query findObjects];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        allPictures = objects;
        allPictures = [[allPictures reverseObjectEnumerator] allObjects];
        
        [self.tableView reloadData];
    }];

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
    
//    cell.imageView.image = pictures[@"photo"];
//    cell.detailTextLabel.text = pictures[@"caption"];
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
