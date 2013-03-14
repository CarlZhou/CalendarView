//
//  AddCourseViewController.h
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCourseSelectWeekDaysViewController.h"
#import "AddCourseCell.h"

@interface AddCourseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate, UIScrollViewAccessibilityDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UITableView *addCourseTableView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIDatePicker *courseTimePicker;
@property (strong, nonatomic) UIToolbar *timePickerAccessoryView;
@property (strong, nonatomic) UIView *dimView;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) UIButton *saveBtn;
@property (strong, nonatomic) AddCourseSelectWeekDaysViewController *weekdaysSelectedView;


@property (strong, nonatomic) AddCourseCell *titleCell;
@property (strong, nonatomic) AddCourseCell *instructorCell;
@property (strong, nonatomic) AddCourseCell *placeCell;
@property (strong, nonatomic) AddCourseCell *lengthCell;
@property (strong, nonatomic) AddCourseCell *repeatCell;
@property (strong, nonatomic) AddCourseCell *startTimeCell;
@property (strong, nonatomic) AddCourseCell *startFromCell;
@property (strong, nonatomic) AddCourseCell *endAtCell;
@property (strong, nonatomic) AddCourseCell *lectureNoCell;
@property (strong, nonatomic) AddCourseCell *enrollCapCell;

@end
