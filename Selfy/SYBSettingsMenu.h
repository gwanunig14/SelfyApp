//
//  SLFSettingsMenu.h
//  Selfy
//
//  Created by T.J. Mercer on 4/30/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYBSettingsDelegate;

@interface SYBSettingsMenu : UIViewController

@property (nonatomic, assign)id<SYBSettingsDelegate> delegate;

@end

@protocol SYBSettingsDelegate <NSObject>

-(void)pushViewController:(UIViewController *)view;

@end
