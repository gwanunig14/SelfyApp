//
//  SLFSettingsButton.m
//  Selfy
//
//  Created by T.J. Mercer on 4/30/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBSettingsButton.h"

@implementation SYBSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    }
    return self;
}

-(void)toggle
{
    self.toggled = !self.toggled;
}

-(void)setToggled:(BOOL)toggled
{
    _toggled = toggled;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
