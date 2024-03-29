//
//  DailyCalendarTableViewController.m
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import "DailyCalendarTableViewController.h"
#import "DailyCalendarCell.h"
#import "AddCourseViewController.h"
#import "Course.h"
#import "DailyCalendarCourseView.h"

@interface DailyCalendarTableViewController ()

@end

@implementation DailyCalendarTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fetchedCourses = [NSMutableArray array];
    self.coursesViews = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCourse)];
    
    self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft)];
    [self.swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    self.swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight)];
    [self.swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.tableView addGestureRecognizer:self.swipeLeft];
    [self.tableView addGestureRecognizer:self.swipeRight];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSSecondCalendarUnit|NSMinuteCalendarUnit|NSHourCalendarUnit|NSWeekdayCalendarUnit) fromDate:now];
    CGFloat timeLinePercentage = ([components second] + 60 * [components minute] + 3600 * [components hour])/86400.0;

    if (!self.timeLineView)
    {
        self.timeLineView = [[UIView alloc] initWithFrame:CGRectMake(44, (self.tableView.contentSize.height - 44)*timeLinePercentage + 22, self.tableView.frame.size.width-44, 1)];
        [self.timeLineView setBackgroundColor:[UIColor redColor]];
        [self.tableView addSubview:self.timeLineView];
    }
    else
    {
        [self.timeLineView setFrame:CGRectMake(44, (self.tableView.contentSize.height - 44)*timeLinePercentage + 22, self.tableView.frame.size.width-44, 1)];
    }


    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[components hour] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

    [self.navigationItem setTitle:[self getWeekday:[components weekday]]];
    self.timeTableWeekday = [self getWeekday:[components weekday]];

    [self drawCourseSchedule];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getWeekday:(NSInteger)weekday
{
    NSLog(@"%i", weekday);
    switch (weekday) {
        case 1:
            return @"Sunday";
        case 2:
            return @"Monday";
        case 3:
            return @"Tuesday";
        case 4:
            return @"Wednesday";
        case 5:
            return @"Thursday";
        case 6:
            return @"Friday";
        case 7:
            return @"Saturday";
        default:
            return @"null";
    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DailyCalCell";
    DailyCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[DailyCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    if (indexPath.row < 12 || indexPath.row > 23)
    {
        [cell.timeLabel setText:[NSString stringWithFormat:@"%d AM", indexPath.row]];
        if (indexPath.row == 0 || indexPath.row == 24)
            [cell.timeLabel setText:[NSString stringWithFormat:@"12 AM"]];
    }
    else
    {
        [cell.timeLabel setText:[NSString stringWithFormat:@"%d PM", indexPath.row-12]];
        if (indexPath.row == 12)
            [cell.timeLabel setText:[NSString stringWithFormat:@"12 PM"]];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    // Configure the cell...

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Navigation Bar method

- (void)addCourse
{
    //    Course *course = (Course *)[NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    AddCourseViewController *addCourseView = [[AddCourseViewController alloc] init];
    addCourseView.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:addCourseView animated:YES];
}

#pragma mark - Course Method

- (void)drawCourseSchedule
{
    [self fetchCourseData];
    NSLog(@"%@", self.fetchedCourses);

    if (self.fetchedCourses.count == 0)
        return;


    for (Course *course in self.fetchedCourses)
    {
        NSDate *now = [NSDate date];
        
        // current date is earlier than course start date
        if ([now compare:course.courseStartDate] == NSOrderedAscending)
            continue;
        // current date is later than course start date
        if ([now compare:course.courseEndDate] == NSOrderedDescending)
            continue;
        
        // Get Course Frame
        NSCalendar *calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDateComponents *components = [calendar components:(NSSecondCalendarUnit|NSMinuteCalendarUnit|NSHourCalendarUnit|NSWeekdayCalendarUnit) fromDate:course.courseStartTime];
        CGFloat courseStartPercentage = ([components second] + 60 * [components minute] + 3600 * [components hour])/86400.0;
        CGFloat courseStartHeight = courseStartPercentage * (self.tableView.contentSize.height-80) + 40;
        CGFloat courseRectHeight = [course.courseLength integerValue]/1440.0 * (self.tableView.contentSize.height-80);
        
        CGRect courseFrame = CGRectMake(44, courseStartHeight, self.tableView.frame.size.width-44, courseRectHeight);

        DailyCalendarCourseView *test = [[DailyCalendarCourseView alloc] initWithFrame:courseFrame];
        [test.title setText:course.courseTitle];
        [test.type setText:[NSString stringWithFormat:@"Lec - %@", course.lectureNumber]];

        // Set course time string
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"hh:mm a"];
        [dateformatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSString *courseStartTimeString = [dateformatter stringFromDate:course.courseStartTime];
        NSTimeInterval secondsOfCourseLength = [course.courseLength doubleValue] * 60;
        NSString *courseEndTimeString = [dateformatter stringFromDate:[course.courseStartTime dateByAddingTimeInterval:secondsOfCourseLength]];
        NSString *courseTimeString = [NSString stringWithFormat:@"%@ - %@", courseStartTimeString, courseEndTimeString];
        [test.time setText:courseTimeString];

        [test.place setText:course.place];
        [test.instructor setText:course.instructor];
        [self.tableView addSubview:test];
        [self.coursesViews addObject:test];
    }

}

- (void)fetchCourseData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"courseStartTime" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];

    NSPredicate *predicate;
    if ([self.timeTableWeekday isEqualToString:@"Sunday"])
        predicate = [NSPredicate predicateWithFormat:@"isSunday == %@", @1];
    else if ([self.timeTableWeekday isEqualToString:@"Monday"])
        predicate = [NSPredicate predicateWithFormat:@"isMonday == %@", @1];
    else if ([self.timeTableWeekday isEqualToString:@"Tuesday"])
        predicate = [NSPredicate predicateWithFormat:@"isTuesday == %@", @1];
    else if ([self.timeTableWeekday isEqualToString:@"Wednesday"])
        predicate = [NSPredicate predicateWithFormat:@"isWednesday == %@", @1];
    else if ([self.timeTableWeekday isEqualToString:@"Thursday"])
        predicate = [NSPredicate predicateWithFormat:@"isThursday == %@", @1];
    else if ([self.timeTableWeekday isEqualToString:@"Friday"])
        predicate = [NSPredicate predicateWithFormat:@"isFriday == %@", @1];
    else
        predicate = [NSPredicate predicateWithFormat:@"isSaturday == %@", @1];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
        NSLog(@"CoreData fetch error");
    }

    self.fetchedCourses = mutableFetchResults;
}

- (void)didSwipeLeft
{
    NSLog(@"swipe left");
    if ([self.timeTableWeekday isEqualToString:@"Sunday"])
    {
        self.timeTableWeekday = @"Monday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Monday"])
    {
        self.timeTableWeekday = @"Tuesday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Tuesday"])
    {
        self.timeTableWeekday = @"Wednesday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Wednesday"])
    {
        self.timeTableWeekday = @"Thursday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Thursday"])
    {
        self.timeTableWeekday = @"Friday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Friday"])
    {
        self.timeTableWeekday = @"Saturday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else
    {
        return;
    }
}

- (void)didSwipeRight
{
    NSLog(@"swipe right");
    if ([self.timeTableWeekday isEqualToString:@"Sunday"])
    {
        return ;
    }
    else if ([self.timeTableWeekday isEqualToString:@"Monday"])
    {
        self.timeTableWeekday = @"Sunday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Tuesday"])
    {
        self.timeTableWeekday = @"Monday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Wednesday"])
    {
        self.timeTableWeekday = @"Tuesday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Thursday"])
    {
        self.timeTableWeekday = @"Wednesday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else if ([self.timeTableWeekday isEqualToString:@"Friday"])
    {
        self.timeTableWeekday = @"Thursday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
    else
    {
        self.timeTableWeekday = @"Friday";
        [self.navigationItem setTitle:self.timeTableWeekday];
        [self clearCourseViews];
        [self drawCourseSchedule];
    }
}

- (void)clearCourseViews
{
    for (DailyCalendarCourseView *courseView in self.coursesViews)
    {
        [courseView removeFromSuperview];
    }
    [self.coursesViews removeAllObjects];
}

@end
