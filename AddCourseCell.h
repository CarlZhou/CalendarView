//
//  AddCourseCell.h
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum AddCourseFields
{
    courseTitle,
    instructor,
    place,
    length,
    weeklyTime,
    courseStartTime,
    courseStartDate,
    courseEndDate,
    lectureNumber,
    enrollCapacity
} AddCourseField;

@interface AddCourseCell : UITableViewCell

- (void)configureCell:(int)cellType;

@property (nonatomic, strong) UITextField *textField;

@end
