//
//  DailyCalendarTableViewController.h
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyCalendarTableViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIView *timeLineView;

@property (strong, nonatomic) NSMutableArray *fetchedCourses;

@end
