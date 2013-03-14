//
//  Course.h
//  classTime
//
//  Created by Carl on 2013-03-13.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * courseTitle;
@property (nonatomic, retain) NSNumber * courseLength;
@property (nonatomic, retain) NSString * instructor;
@property (nonatomic, retain) NSString * weeklyTime;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSNumber * enrollCapacity;
@property (nonatomic, retain) NSNumber * enrollTotal;
@property (nonatomic, retain) NSNumber * courseScore;
@property (nonatomic, retain) NSDate * courseStartDate;
@property (nonatomic, retain) NSDate * courseEndDate;
@property (nonatomic, retain) NSNumber * lectureNumber;
@property (nonatomic, retain) NSDate * courseStartTime;

@end
