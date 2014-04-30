//
//  SLFSettingsButton.h
//  Selfy
//
//  Created by T.J. Mercer on 4/30/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLFSettingsButton : UIButton

@property (nonatomic, getter = isToggled) BOOL toggled;

@property (nonatomic) UIColor * toggledTintColor;

-(void)toggle;

@end
