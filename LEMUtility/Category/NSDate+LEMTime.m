//
//  NSDate+LEMTime.m
//  LEMUtility
//
//  Created by Himin on 2018/11/28.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "NSDate+LEMTime.h"

@implementation NSDate (LEMTime)

// 获取当前时间
+ (NSString *)nowTimeWithFormatString:(NSString *)formatString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatString;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)today {
    return [self nowTimeWithFormatString:@"yyyy/MM/dd"];
}

// 获取年、月、日、星期

+ (NSString *)getYearWithDateString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    NSDate *date = [formatter dateFromString:string];
    
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    newFormatter.dateFormat = @"yyyy";
    NSString *year = [newFormatter stringFromDate:date];
    return year;
}

+ (NSString *)getMonthWithDateString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    NSDate *date = [formatter dateFromString:string];
    
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    newFormatter.dateFormat = @"MM";
    NSString *month = [newFormatter stringFromDate:date];
    return month;
}

+ (NSString *)getDayWithDateString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    NSDate *date = [formatter dateFromString:string];
    
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    newFormatter.dateFormat = @"dd";
    NSString *day = [newFormatter stringFromDate:date];
    return day;
}

+ (NSString *)getWeekWithDateString:(NSString *)string {
    NSTimeInterval timeInterval = [self getTimestampWithDateString:string];
    NSInteger day = (NSInteger)(timeInterval/86400);
    NSArray *weeks = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    NSInteger index = (day - 3) % 7;
    return weeks[index];
}

// 获取日期时间戳 String格式: @"yyyy/MM/dd"
+ (NSTimeInterval)getTimestampWithDateString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSDate *date = [formatter dateFromString:string];
    NSTimeInterval interval = date.timeIntervalSince1970;
    return interval;
}

@end
