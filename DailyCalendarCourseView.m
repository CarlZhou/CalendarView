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
//        [self.background setImage:[[UIImage imageNamed:@"greenButton@2x.png"] stretchableImageWithLeftCapWidth:36 topCapHeight:36]];
        [self.background setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:self.background];

        CGFloat centerLine = frame.size.height/2 - 7.5;

        // Set title lable
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, centerLine - 30, frame.size.width, 15)];
        [self.title setBackgroundColor:[UIColor clearColor]];
        [self.title setTextAlignment:NSTextAlignmentCenter];
        [self.title setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
//        [self.title setTextColor:[UIColor blueColor]];
        [self addSubview:self.title];

        // Set type lable
        self.type = [[UILabel alloc] initWithFrame:CGRectMake(0, centerLine - 15, frame.size.width, 15)];
        [self.type setBackgroundColor:[UIColor clearColor]];
        [self.type setTextAlignment:NSTextAlignmentCenter];
        [self.type setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
//        [self.type setTextColor:[UIColor blueColor]];
        [self addSubview:self.type];

        // Set time lable
        self.time = [[UILabel alloc] initWithFrame:CGRectMake(0, centerLine, frame.size.width, 15)];
        [self.time setBackgroundColor:[UIColor clearColor]];
        [self.time setTextAlignment:NSTextAlignmentCenter];
        [self.time setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
//        [self.time setTextColor:[UIColor blueColor]];
        [self addSubview:self.time];

        // Set place lable
        self.place = [[UILabel alloc] initWithFrame:CGRectMake(0, centerLine + 15, frame.size.width, 15)];
        [self.place setBackgroundColor:[UIColor clearColor]];
        [self.place setTextAlignment:NSTextAlignmentCenter];
        [self.place setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
//        [self.place setTextColor:[UIColor blueColor]];
        [self addSubview:self.place];

        // Set instructor lable
        self.instructor = [[UILabel alloc] initWithFrame:CGRectMake(0, centerLine + 30, frame.size.width, 15)];
        [self.instructor setBackgroundColor:[UIColor clearColor]];
        [self.instructor setTextAlignment:NSTextAlignmentCenter];
        [self.instructor setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
//        [self.instructor setTextColor:[UIColor blueColor]];
        [self addSubview:self.instructor];

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
