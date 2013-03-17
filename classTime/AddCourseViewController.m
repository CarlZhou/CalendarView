//
//  AddCourseViewController.m
//  classTime
//
//  Created by Carl on 2013-03-12.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import "AddCourseViewController.h"
#import "Course.h"
#import <QuartzCore/QuartzCore.h>

@interface AddCourseViewController ()

@end

@implementation AddCourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.scrollView setBackgroundColor:[UIColor lightGrayColor]];

        self.addCourseTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height-110+44+44)];
        
        NSLog(@"%f", self.view.frame.size.height);
        
        self.addCourseTableView.dataSource = self;
        self.addCourseTableView.delegate = self;
        self.addCourseTableView.layer.cornerRadius = 5;
        [self.addCourseTableView setScrollEnabled:NO];

        [self.scrollView addSubview:self.addCourseTableView];
        self.scrollView.delegate = self;
        [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 550)];

        self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.saveBtn setFrame:CGRectMake(10, self.view.frame.size.height-110+44+44+20, self.view.frame.size.width-20, 44)];
        [self.saveBtn setTitle:@"save" forState:UIControlStateNormal];
        [self.saveBtn addTarget:self action:@selector(saveCourse) forControlEvents:UIControlEventTouchUpInside];
        UIImage *saveBtnBgNormal = [[UIImage imageNamed:@"blackButton.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:18];
        UIImage *saveBtnBgHighlighted = [[UIImage imageNamed:@"blackButtonHighlight.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:18];
        [self.saveBtn setBackgroundImage:saveBtnBgNormal forState:UIControlStateNormal];
        [self.saveBtn setBackgroundImage:saveBtnBgHighlighted forState:UIControlStateHighlighted];
        [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        [self.scrollView addSubview:self.saveBtn];

        [self.view addSubview:self.scrollView];
        
        
        if (self.view.frame.size.height == 548)
        {
            [self.addCourseTableView setFrame:CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height-88-110+44+44)];
            [self.saveBtn setFrame:CGRectMake(10, self.view.frame.size.height-110-88+44+44+20, self.view.frame.size.width-20, 44)];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveCourse)];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.addCourseTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveCourse
{
    Course *course = (Course *)[NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    if (self.titleCell.textField.text)
    {
        [course setCourseTitle:self.titleCell.textField.text];
    }
    else
    {
        NSLog(@"No Title");
        return;
    }
    if (self.instructorCell.textField.text)
    {
        [course setInstructor:self.instructorCell.textField.text];
    }
    else
    {
        NSLog(@"No Instructor");
        return;
    }
    if (self.placeCell.textField.text)
    {
        [course setPlace:self.placeCell.textField.text];
    }
    else
    {
        NSLog(@"No Place");
        return;
    }
    if (self.lengthCell.textField.text)
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSRange range = [self.lengthCell.textField.text rangeOfString:@" "];
        NSNumber *mins;
        if (range.length != 0)
        {
            mins = [numberFormatter numberFromString:[self.lengthCell.textField.text substringToIndex:range.location]];
        }
        else
        {
            mins = [numberFormatter numberFromString:self.lengthCell.textField.text];
        }

        if (!mins)
        {
            NSLog(@"Invalid Length");
            return;
        }

        [course setCourseLength:mins];
    }
    else
    {
        NSLog(@"No Course Length");
        return;
    }
    if (self.repeatCell.textField.text)
    {
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending:YES];
        NSArray *sortArrary = [self.weekdaysSelectedView.selectedWeekdays sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
        for (NSIndexPath *index in sortArrary)
        {
            switch (index.row)
            {
                case Sunday:
                    course.isSunday = @1;
                    break;
                case Monday:
                    course.isMonday = @1;
                    break;
                case Tuesday:
                    course.isTuesday = @1;
                    break;
                case Wednesday:
                    course.isWednesday = @1;
                    break;
                case Thursday:
                    course.isThursday = @1;
                    break;
                case Friday:
                    course.isFriday = @1;
                    break;
                case Saturday:
                    course.isSaturday = @1;
                    break;
                default:
                    break;
            }
        }
    }
    else
    {
        NSLog(@"No Weekly Time");
        return;
    }
    if (self.startTimeCell.textField.text)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"hh:mm a"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate *startTime = [dateFormat dateFromString:self.startTimeCell.textField.text];
        [course setCourseStartTime:startTime];
    }
    else
    {
        NSLog(@"No Start Time");
        return;
    }
    if (self.startFromCell.textField.text)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM-dd-yyyy"];
        NSDate *startDate = [dateFormat dateFromString:self.startFromCell.textField.text];
        [course setCourseStartDate:startDate];
    }
    else
    {
        NSLog(@"No start date");
        return;
    }
    if (self.endAtCell.textField.text)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM-dd-yyyy"];
        NSDate *endDate = [dateFormat dateFromString:self.endAtCell.textField.text];
        [course setCourseEndDate:endDate];
    }
    else
    {
        NSLog(@"No end date");
        return;
    }
    if (self.lectureNoCell.textField.text)
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *lectureNo = [numberFormatter numberFromString:self.lectureNoCell.textField.text];

        if (!lectureNo)
        {
            NSLog(@"Invalid Lecture Number");
            return;
        }

        [course setLectureNumber:lectureNo];
    }
    if (self.enrollCapCell.textField.text)
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *enrollCap = [numberFormatter numberFromString:self.enrollCapCell.textField.text];

        if (!enrollCap)
        {
            NSLog(@"Invalid Lecture Number");
            return;
        }

        [course setLectureNumber:enrollCap];
    }

    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"CoreData Error");
    }

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddCourseCalCell";
    AddCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[AddCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textField.delegate = self;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7)
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    if (indexPath.row == 4)
    {
        [cell.textField setText:[self getCellTextField]];
        [cell.textField setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    }

    [cell configureCell:indexPath.row];

    switch (indexPath.row)
        {
            case courseTitle:
            {
                self.titleCell = cell;
                break;
            }
            case instructor:
            {
                self.instructorCell = cell;
                break;
            }
            case place:
            {
                self.placeCell = cell;
                break;
            }
            case length:
            {
                self.lengthCell = cell;
                break;
            }
            case weeklyTime:
            {
                self.repeatCell = cell;
                break;
            }
            case courseStartTime:
            {
                self.startTimeCell = cell;
                break;
            }
            case courseStartDate:
            {
                self.startFromCell = cell;
                break;
            }
            case courseEndDate:
            {
               self.endAtCell = cell;
               break;
            }
            case lectureNumber:
            {
                self.lectureNoCell = cell;
                break;
            }
            case enrollCapacity:
            {
                self.enrollCapCell = cell;
                break;
            }
            default:
                break;
        }

    return cell;
}

- (NSString *)getCellTextField
{
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending:YES];
    NSArray *sortArrary = [self.weekdaysSelectedView.selectedWeekdays sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
    NSMutableString *weekdaysText = [NSMutableString string];
    for (NSIndexPath *index in sortArrary)
    {
        switch (index.row)
        {
            case Sunday:
                [weekdaysText appendString:@"Sun "];
                break;
            case Monday:
                [weekdaysText appendString:@"Mon "];
                break;
            case Tuesday:
                [weekdaysText appendString:@"Tue "];
                break;
            case Wednesday:
                [weekdaysText appendString:@"Wed "];
                break;
            case Thursday:
                [weekdaysText appendString:@"Thu "];
                break;
            case Friday:
                [weekdaysText appendString:@"Fri "];
                break;
            case Saturday:
                [weekdaysText appendString:@"Sat "];
                break;
            default:
                break;
        }
    }

    if (sortArrary.count == 1)
    {
        NSIndexPath *onlyIndex = [sortArrary objectAtIndex:0];
        switch (onlyIndex.row)
        {
            case Sunday:
                return @"Every Sunday";
            case Monday:
                return @"Every Monday";
            case Tuesday:
                return @"Every Tuesday";
            case Wednesday:
                return @"Every Wednesday";
            case Thursday:
                return @"Every Thursday";
            case Friday:
                return @"Every Friday";
            case Saturday:
                return @"Every Saturday";
            default:
                break;
        }
    }
    else if ([weekdaysText isEqualToString:@"Sun Sat "])
    {
        return @"Weekends";
    }
    else if ([weekdaysText isEqualToString:@"Mon Tue Wed Thu Fri "])
    {
        return @"Weekdays";
    }
    else if (sortArrary.count == 7)
    {
        return @"Every day";
    }
    else if (sortArrary.count == 0)
    {
        return nil;
    }

    return weekdaysText;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7)
    {
        [self presentTimePicker];
        self.selectedIndexPath = indexPath;
    }
    else if (indexPath.row == 4)
    {
        if (!self.weekdaysSelectedView)
        {
            self.weekdaysSelectedView = [[AddCourseSelectWeekDaysViewController alloc] init];
        }

        [self.navigationController pushViewController:self.weekdaysSelectedView animated:YES];
        [self.addCourseTableView deselectRowAtIndexPath:indexPath animated:YES];
    }

}

- (void)presentTimePicker
{
    CGFloat beforeHeight = self.scrollView.contentOffset.y;
    [self.scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    self.courseTimePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.scrollView.contentOffset.y+self.view.frame.size.height-beforeHeight, self.view.frame.size.width, 200)];
    [self setDimOverlay];
    [self.scrollView setScrollEnabled:NO];
    [self.courseTimePicker setDatePickerMode:UIDatePickerModeDate];
    [self.courseTimePicker setDate:[NSDate date] animated:YES];
    if ([self.startTimeCell isSelected])
    {
        [self.courseTimePicker setDatePickerMode:UIDatePickerModeTime];
        NSDate * now = [[NSDate alloc] init];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents * comps = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
        [comps setHour:0];
        [comps setMinute:0];
        [comps setSecond:0];
        NSDate * date = [cal dateFromComponents:comps];
        [self.courseTimePicker setDate:date animated:TRUE];
    }
    [self.courseTimePicker setMinuteInterval:5];

    self.timePickerAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.courseTimePicker.frame.origin.y-44, self.view.frame.size.width, 44)];
    [self.timePickerAccessoryView setTintColor:[UIColor blackColor]];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(accessoryViewDonePressed)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(accessoryViewCancelPressed)];
    [self.timePickerAccessoryView setItems:@[cancelBtn, flexibleSpace, doneBtn]];

    [self.scrollView addSubview:self.timePickerAccessoryView];

    [self.scrollView addSubview:self.courseTimePicker];
}

- (void)accessoryViewDonePressed
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];

    if ([self.startTimeCell isSelected])
    {
        [dateformatter setDateFormat:@"hh:mm a"];
        NSString *timePickerString = [dateformatter stringFromDate:[self.courseTimePicker date]];
        AddCourseCell *cell = (AddCourseCell *)[self.addCourseTableView cellForRowAtIndexPath:self.selectedIndexPath];
        [cell.textField setText:timePickerString];
    }
    else
    {
        [dateformatter setDateFormat:@"MM-dd-yyyy"];
        NSString *timePickerString = [dateformatter stringFromDate:[self.courseTimePicker date]];
        AddCourseCell *cell = (AddCourseCell *)[self.addCourseTableView cellForRowAtIndexPath:self.selectedIndexPath];
        [cell.textField setText:timePickerString];
    }

    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.timePickerAccessoryView removeFromSuperview];
    [self.courseTimePicker removeFromSuperview];
    [self removeDimOverlay];
    [self.scrollView setScrollEnabled:YES];
    self.timePickerAccessoryView = nil;
    self.courseTimePicker = nil;
    if (self.selectedIndexPath.row == courseStartTime)
    {
        [self.addCourseTableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
        self.selectedIndexPath = nil;
        [self.addCourseTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:courseStartDate inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.addCourseTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:courseStartDate inSection:0]];
    }
    else if (self.selectedIndexPath.row == courseStartDate)
    {
        [self.addCourseTableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
        self.selectedIndexPath = nil;
        [self.addCourseTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:courseEndDate inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.addCourseTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:courseEndDate inSection:0]];
    }
    else
    {
        [self.addCourseTableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
        self.selectedIndexPath = nil;
        [self.lectureNoCell.textField becomeFirstResponder];
    }
}

- (void)accessoryViewCancelPressed
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.timePickerAccessoryView removeFromSuperview];
    [self.courseTimePicker removeFromSuperview];
    [self removeDimOverlay];
    [self.scrollView setScrollEnabled:YES];
    self.timePickerAccessoryView = nil;
    self.courseTimePicker = nil;
    [self.addCourseTableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
    self.selectedIndexPath = nil;
}

- (void)didTapOnDimView
{
    if ([self.titleCell.textField isFirstResponder])
    {
        [self.titleCell.textField resignFirstResponder];
    }
    else if ([self.instructorCell.textField isFirstResponder])
    {
        [self.instructorCell.textField resignFirstResponder];
    }
    else if ([self.placeCell.textField isFirstResponder])
    {
        [self.placeCell.textField resignFirstResponder];
    }
    else if ([self.lengthCell.textField isFirstResponder])
    {
        [self.lengthCell.textField resignFirstResponder];
    }
    else if ([self.lectureNoCell.textField isFirstResponder])
    {
        [self.lectureNoCell.textField resignFirstResponder];
    }
    else if ([self.enrollCapCell.textField isFirstResponder])
    {
        [self.enrollCapCell.textField resignFirstResponder];
    }
    else
    {
        [self accessoryViewCancelPressed];
    }
}

- (void)setDimOverlay
{
    self.dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+800)];
    UITapGestureRecognizer *tapOnDimView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnDimView)];
    [self.dimView addGestureRecognizer:tapOnDimView];
    [self.scrollView addSubview:self.dimView];
}

- (void)removeDimOverlay
{
    [self.dimView removeFromSuperview];
    self.dimView = nil;
}

#pragma mark - TextField delegate
- (BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.titleCell.textField)
        [self.instructorCell.textField becomeFirstResponder];
    else if (textField == self.instructorCell.textField)
        [self.placeCell.textField becomeFirstResponder];
    else if (textField == self.placeCell.textField)
        [self.lengthCell.textField becomeFirstResponder];
    else if (textField == self.lectureNoCell.textField)
        [self.enrollCapCell.textField becomeFirstResponder];
    else
        [textField resignFirstResponder];

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setDimOverlay];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self removeDimOverlay];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if ([self.titleCell.textField isFirstResponder])
    {
        [self.scrollView setContentOffset:CGPointMake(0, 10) animated:YES];
    }
    else if ([self.instructorCell.textField isFirstResponder])
    {
        [self.scrollView setContentOffset:CGPointMake(0, 54) animated:YES];
    }
    else if ([self.placeCell.textField isFirstResponder])
    {
        [self.scrollView setContentOffset:CGPointMake(0, 98) animated:YES];
    }
    else if ([self.lengthCell.textField isFirstResponder])
    {
        [self.scrollView setContentOffset:CGPointMake(0, 98+44) animated:YES];
    }
    else if ([self.lectureNoCell.textField isFirstResponder])
    {
        [self.scrollView setContentOffset:CGPointMake(0, 274) animated:YES];
    }
    else if ([self.enrollCapCell.textField isFirstResponder])
    {
        [self.scrollView setContentOffset:CGPointMake(0, 318) animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if ([self.enrollCapCell.textField isFirstResponder])
        [self.scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    else
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

@end
