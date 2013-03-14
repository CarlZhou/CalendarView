//
//  DailyClassViewController.h
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyCalendarTableViewController.h"

@interface DailyClassViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) DailyCalendarTableViewController *backgroundCalView;

@end
