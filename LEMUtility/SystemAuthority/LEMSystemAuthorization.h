//
//  LEMSystemAuthorization.h
//  LEMUtility
//
//  Created by Himin on 2018/12/7.
//  Copyright © 2018 Himin. All rights reserved.
//

// 系统各种权限的判断

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LEMSystemAuthorizationType) {
    LEMSystemAuthorizationTypeCamera,
    LEMSystemAuthorizationTypePhotoLibrary,
    LEMSystemAuthorizationTypeNotification,
    LEMSystemAuthorizationTypeNetwork,
    LEMSystemAuthorizationTypeMicrophone,
    LEMSystemAuthorizationTypeLocation,
    LEMSystemAuthorizationTypeAddressBook,
    LEMSystemAuthorizationTypeCalendar,
    LEMSystemAuthorizationTypeMemorandum,
};

@interface LEMSystemAuthorization : NSObject

// 相机权限
+ (BOOL)hasCameraAuthorization;
// 相册权限
+ (BOOL)hasPhotoLibraryAuthorization;
// 通知权限
+ (BOOL)hasNotificationAuthorization;
// 网络权限
+ (BOOL)hasNetWorkAuthorization;
// 麦克风权限
+ (BOOL)hasMicrophoneAuthorization;
// 定位权限
+ (BOOL)hasLocationAuthorization;
// 通讯录权限
+ (BOOL)hasAddressBookAuthorization;
// 日历权限
+ (BOOL)hasCalendarAuthorization;
// 备忘录权限
+ (BOOL)hasMemorandumAuthorization;
// 提醒事项权限
+ (BOOL)hasReminderAuthorization;

// 后台应用刷新权限 运动与健身权限 语音识别

@end

NS_ASSUME_NONNULL_END
