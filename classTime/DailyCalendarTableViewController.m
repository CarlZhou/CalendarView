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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCourse)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    [self drawCourseSchedule];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getWeekday:(NSInteger)weekday
{
    switch (weekday) {
        case 0:
            return @"Sunday";
        case 1:
            return @"Monday";
        case 2:
            return @"Tuesday";
        case 3:
            return @"Wednesday";
        case 4:
            return @"Thursday";
        case 5:
            return @"Friday";
        case 6:
            return @"Saturday";
        default:
            return @"null";
    }
}

#pragma mark - Table view data source

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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

    Course *course = [self.fetchedCourses objectAtIndex:0];
    NSLog(@"%@", course.courseStartTime);

    UIButton *test = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [test setTitle:course.courseTitle forState:UIControlStateNormal];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDateComponents *components = [calendar components:(NSSecondCalendarUnit|NSMinuteCalendarUnit|NSHourCalendarUnit|NSWeekdayCalendarUnit) fromDate:course.courseStartTime];
    CGFloat courseStartPercentage = ([components second] + 60 * [components minute] + 3600 * [components hour])/86400.0;
    CGFloat courseStartHeight = courseStartPercentage * (self.tableView.contentSize.height-44) + 22;
    NSLog(@"%i", [components hour]);

    CGFloat courseRectHeight = [course.courseLength integerValue]/1440.0 * (self.tableView.contentSize.height-44) + 22;
    NSLog(@"%f", courseRectHeight);
    [test setFrame:CGRectMake(44, courseStartHeight, self.tableView.frame.size.width-44, courseRectHeight)];
    [self.tableView addSubview:test];

}

- (void)fetchCourseData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"courseStartTime" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
        NSLog(@"CoreData fetch error");
    }

    self.fetchedCourses = mutableFetchResults;
}


@end