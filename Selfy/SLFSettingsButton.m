//
//  SLFSettingsButton.m
//  Selfy
//
//  Created by T.J. Mercer on 4/29/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFSettingsButton.h"

#import "SLFNewNavController.h"

@implementation SLFSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNeedsDisplay];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    int w = (self.frame.size.width)-2;
    int h = (self.frame.size.height)-2;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    
    if ([self menuIsOpen])
    {
        CGContextMoveToPoint(context, 1, 1);
        CGContextAddLineToPoint(context, w, h);
        
        CGContextMoveToPoint(context, 1, h);
        CGContextAddLineToPoint(context, w, 1);
    }else{
        CGContextMoveToPoint(context, 1, 1);
        CGContextAddLineToPoint(context, w, 1);
        
        CGContextMoveToPoint(context, 1, h/2);
        CGContextAddLineToPoint(context, w, h/2);

        CGContextMoveToPoint(context, 1, h);
        CGContextAddLineToPoint(context, w, h);
    }
    CGContextStrokePath(context);
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
