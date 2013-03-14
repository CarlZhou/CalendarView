//
//  DailyCalendarCell.m
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import "DailyCalendarCell.h"

@implementation DailyCalendarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 39, 44)];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
        [self.timeLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:self.timeLabel];
        
        self.centerLine = [[UIView alloc] initWithFrame:CGRectMake(44, 22, self.contentView.frame.size.width-44, 1)];
        [self.centerLine setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:self.centerLine];
        
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(44, 43, self.contentView.frame.size.width-44, 1)];
        [self.bottomLine setBackgroundColor:[UIColor darkGrayColor]];
        [self.contentView addSubview:self.bottomLine];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
