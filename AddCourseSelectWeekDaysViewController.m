//
//  AddCourseSelectWeekDaysViewController.m
//  classTime
//
//  Created by Carl on 2013-03-13.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AddCourseSelectWeekDaysViewController.h"

@interface AddCourseSelectWeekDaysViewController ()

@end

@implementation AddCourseSelectWeekDaysViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
        self.selectedWeekdays = [NSMutableArray array];

        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height-154)];
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.layer.cornerRadius = 5;
        [self.tableView setScrollEnabled:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddCourseSelectWeekdaysCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    switch (indexPath.row)
    {
        case Sunday:
            [cell.textLabel setText:@"Every Sunday"];
            break;
        case Monday:
            [cell.textLabel setText:@"Every Monday"];
            break;
        case Tuesday:
            [cell.textLabel setText:@"Every Tuesday"];
            break;
        case Wednesday:
            [cell.textLabel setText:@"Every Wednesday"];
            break;
        case Thursday:
            [cell.textLabel setText:@"Every Thursday"];
            break;
        case Friday:
            [cell.textLabel setText:@"Every Friday"];
            break;
        case Saturday:
            [cell.textLabel setText:@"Every Saturday"];
            break;
        default:
            break;
    }
    if ([self.selectedWeekdays indexOfObject:indexPath] != NSNotFound)
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.selectedWeekdays indexOfObject:indexPath] != NSNotFound)
    {
        [self.selectedWeekdays removeObject:indexPath];
    }
    else
    {
        [self.selectedWeekdays addObject:indexPath];
    }
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.4];
}

@end
