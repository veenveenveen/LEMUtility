//
//  NSDate+LEMTime.h
//  LEMUtility
//
//  Created by Himin on 2018/11/28.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LEMTime)

// 获取当前时间 @"yyyy/MM/dd HH:mm:ss"
+ (NSString *)nowTimeWithFormatString:(NSString *)formatString;
+ (NSString *)today;

// 获取年、月、日、星期 string格式只包含年月日，不能包含时分秒
+ (NSString *)getYearWithDateString:(NSString *)string;
+ (NSString *)getMonthWithDateString:(NSString *)string;
+ (NSString *)getDayWithDateString:(NSString *)string;

+ (NSString *)getWeekWithDateString:(NSString *)string;

// 获取日期时间戳 String格式: @"yyyy/MM/dd"
+ (NSTimeInterval)getTimestampWithDateString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
