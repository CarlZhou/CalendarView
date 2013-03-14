//
//  DailyClassViewController.m
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import "DailyClassViewController.h"
#import "AddCourseViewController.h"
#import "Course.h"

@interface DailyClassViewController ()

@end

@implementation DailyClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.backgroundCalView = [[DailyCalendarTableViewController alloc] init];
        [self.view addSubview:self.backgroundCalView.view];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addCourse
{
//    Course *course = (Course *)[NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    AddCourseViewController *addCourseView = [[AddCourseViewController alloc] init];
    addCourseView.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:addCourseView animated:YES];
}

@end
