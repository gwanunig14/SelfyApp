//
//  SLFSettingsMenu.m
//  Selfy
//
//  Created by T.J. Mercer on 4/30/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBSettingsMenu.h"

#import "SYBNewProjectView.h"

#import "SYBProjectList.h"

#import "SYBChangeName.h"

#import "SYBChapterList.h"

#import "SYBCharacterList.h"

#import "SYBViewAll.h"

#import "SYBData.h"

@interface SYBSettingsMenu ()

@end

@implementation SYBSettingsMenu
{
    SYBNewProjectView * newProjects;
    SYBProjectList * oldProjects;
    SYBChangeName * newName;
    SYBChapterList * chapters;
    int startPoint;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = TOP_COLOR;
        
        startPoint = SCREEN_HEIGHT/7 - 5;
        
        [self firstViews];
        
    }
    return self;
}

-(void)newProjectAction
{
    newProjects = [[SYBNewProjectView alloc]init];
    [self.delegate pushViewController:newProjects];
}

-(void)loadProjectAction
{
    oldProjects = [[SYBProjectList alloc]init];
    [self.delegate pushViewController:oldProjects];
}

-(void)changeTitleAction
{
    newName = [[SYBChangeName alloc]init];
    newName.function = 1;
    newName.oldTitle = [SYBData mainData].selectedProject;
    [self.delegate pushViewController:newName];
}

-(void)editCharacters
{
    SYBCharacterList * characters = [[SYBCharacterList alloc]init];
    characters.editOrNot = 1;
    [self.delegate pushViewController:characters];
}

-(void)editChapters
{
    chapters = [[SYBChapterList alloc]init];
    [self.delegate pushViewController:chapters];
}

-(void)firstViews
{
    [self clearButtons];
    
    UIButton * newProject = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint * 1, 200, 20)];
    [newProject setTitle:@"New Project" forState:UIControlStateNormal];
    [newProject addTarget:self action:@selector(newProjectAction) forControlEvents:UIControlEventTouchUpInside];
    newProject.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [newProject setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:newProject];
    
    UIButton * loadProject = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint*2, 200, 20)];
    [loadProject setTitle:@"Load Project" forState:UIControlStateNormal];
    [loadProject addTarget:self action:@selector(loadProjectAction) forControlEvents:UIControlEventTouchUpInside];
    loadProject.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [loadProject setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:loadProject];
    
    UIButton * changeTitle = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint*3, 200, 20)];
    [changeTitle setTitle:@"Edit Title" forState:UIControlStateNormal];
    [changeTitle addTarget:self action:@selector(changeTitleAction) forControlEvents:UIControlEventTouchUpInside];
    changeTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [changeTitle setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:changeTitle];
    
    UIButton * editCharacterName = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint * 4, 200, 20)];
    [editCharacterName setTitle:@"Edit Characters" forState:UIControlStateNormal];
    [editCharacterName addTarget:self action:@selector(editCharacters) forControlEvents:UIControlEventTouchUpInside];
    editCharacterName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [editCharacterName setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:editCharacterName];
    
    UIButton * editChapterTitle = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint *5, 200, 20)];
    [editChapterTitle addTarget:self action:@selector(editChapters) forControlEvents:UIControlEventTouchUpInside];
    [editChapterTitle setTitle:@"Chapter/Scene Titles" forState:UIControlStateNormal];
    editChapterTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [editChapterTitle setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:editChapterTitle];
    
    UIButton * viewAll = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint * 6, 200, 20)];
    [viewAll addTarget:self action:@selector(secondViews) forControlEvents:UIControlEventTouchUpInside];
    [viewAll setTitle:@"Full Outlines" forState:UIControlStateNormal];
    viewAll.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [viewAll setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:viewAll];
}

-(void)clearButtons
{
    NSArray *subviews = [self.view subviews];
    for (int i=0; i<[subviews count]; i++)
    {
        [[subviews objectAtIndex:i] removeFromSuperview];
    }
}

-(void)secondViews
{
    [self clearButtons];
    
    UIButton * viewAll = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint , 200, 20)];
    [viewAll setTitle:@"Complete Outline" forState:UIControlStateNormal];
    [viewAll setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [viewAll addTarget:self action:@selector(viewAll) forControlEvents:UIControlEventTouchUpInside];
    viewAll.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:viewAll];
    
    UIButton * characterView = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint * 2, 200, 20)];
    [characterView setTitle:@"Character Outline" forState:UIControlStateNormal];
    [characterView setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [characterView addTarget:self action:@selector(viewCharacters) forControlEvents:UIControlEventTouchUpInside];
    characterView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:characterView];
    
    UIButton * back = [[UIButton alloc]initWithFrame:CGRectMake(10, startPoint * 6, 200, 20)];
    [back addTarget:self action:@selector(firstViews) forControlEvents:UIControlEventTouchUpInside];
    [back setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:back];
}

-(void)viewCharacters
{
    SYBCharacterList * characters = [[SYBCharacterList alloc]init];
    characters.editOrNot = 2;
    [self.delegate pushViewController:characters];
    [self firstViews];
}

-(void)viewAll
{
    SYBViewAll * viewAll = [[SYBViewAll alloc]init];
    [self.delegate pushViewController:viewAll];
    [self firstViews];
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
