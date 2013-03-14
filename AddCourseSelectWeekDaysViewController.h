//
//  AddCourseSelectWeekDaysViewController.h
//  classTime
//
//  Created by Carl on 2013-03-13.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum WeekdaysFields
{
    Sunday,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday
} WeekdaysField;

@interface AddCourseSelectWeekDaysViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *selectedWeekdays;
@property (nonatomic, strong) UITableView *tableView;

@end
