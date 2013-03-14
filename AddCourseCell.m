//
//  AddCourseCell.m
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import "AddCourseCell.h"

@implementation AddCourseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 12, self.contentView.frame.size.width-120, self.contentView.frame.size.height-12)];
        self.textField.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(int)cellType
{
    switch (cellType)
    {
        case courseTitle:
        {
            self.textLabel.text = NSLocalizedString(@"Title", @"");
            self.textField.placeholder = NSLocalizedString(@"CS 350", @"");
//            self.textField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
        }
        case instructor:
        {
            self.textLabel.text = NSLocalizedString(@"Instructor", @"");
            self.textField.placeholder = NSLocalizedString(@"David Smallberg", @"");
//            self.textField.secureTextEntry = YES;
            break;
        }
        case place:
        {
            self.textLabel.text = NSLocalizedString(@"Place", @"");
            self.textField.placeholder = NSLocalizedString(@"MC 2048", @"");
            break;
        }
        case length:
        {
            self.textLabel.text = NSLocalizedString(@"Length", @"");
            self.textField.placeholder = NSLocalizedString(@"50 mins", @"");
            break;
        }
        case weeklyTime:
        {
            self.textLabel.text = NSLocalizedString(@"Repeat", @"");
            [self.textField setEnabled:NO];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case courseStartTime:
        {
            self.textLabel.text = NSLocalizedString(@"Time", @"");
            [self.textField setEnabled:NO];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case courseStartDate:
        {
            self.textLabel.text = NSLocalizedString(@"Start From", @"");
            [self.textField setEnabled:NO];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case courseEndDate:
        {
            self.textLabel.text = NSLocalizedString(@"End At", @"");
            [self.textField setEnabled:NO];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case lectureNumber:
        {
            self.textLabel.text = NSLocalizedString(@"LectureNo.", @"");
            self.textField.placeholder = NSLocalizedString(@"001(optional)", @"");
            break;
        }
        case enrollCapacity:
        {
            self.textLabel.text = NSLocalizedString(@"enrollCap.", @"");
            self.textField.placeholder = NSLocalizedString(@"200(optional)", @"");
            break;
        }
        default:
            break;
    }

    self.textLabel.backgroundColor = [UIColor clearColor];
}

@end
