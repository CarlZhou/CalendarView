//
//  Course.h
//  classTime
//
//  Created by Zian Zhou on 2013-03-16.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSDate * courseEndDate;
@property (nonatomic, retain) NSNumber * courseLength;
@property (nonatomic, retain) NSNumber * courseScore;
@property (nonatomic, retain) NSDate * courseStartDate;
@property (nonatomic, retain) NSDate * courseStartTime;
@property (nonatomic, retain) NSString * courseTitle;
@property (nonatomic, retain) NSNumber * enrollCapacity;
@property (nonatomic, retain) NSNumber * enrollTotal;
@property (nonatomic, retain) NSString * instructor;
@property (nonatomic, retain) NSNumber * lectureNumber;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSNumber * isMonday;
@property (nonatomic, retain) NSNumber * isWednesday;
@property (nonatomic, retain) NSNumber * isTuesday;
@property (nonatomic, retain) NSNumber * isThursday;
@property (nonatomic, retain) NSNumber * isFriday;
@property (nonatomic, retain) NSNumber * isSaturday;
@property (nonatomic, retain) NSNumber * isSunday;

@end
