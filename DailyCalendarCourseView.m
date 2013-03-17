//
//  DailyCalendarCourseView.m
//  classTime
//
//  Created by Zian Zhou on 2013-03-16.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import "DailyCalendarCourseView.h"

@implementation DailyCalendarCourseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Set background
        self.background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.background setImage:[[UIImage imageNamed:@"greenButton@2x.png"] stretchableImageWithLeftCapWidth:36 topCapHeight:36]];
        [self addSubview:self.background];
        
        // Set title lable
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 15)];
        [self.title setBackgroundColor:[UIColor clearColor]];
        [self.title setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.title];
        
        // Set type lable
        self.type = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, frame.size.width, 15)];
        [self.type setBackgroundColor:[UIColor clearColor]];
        [self.type setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.type];
        
        // Set time lable
        self.time = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 15)];
        [self.time setBackgroundColor:[UIColor clearColor]];
        [self.time setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.time];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setRamdomBackground
{
}

- (void)setFrame:(CGRect)frame
{
    [self.background setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [super setFrame:frame];
}

@end
