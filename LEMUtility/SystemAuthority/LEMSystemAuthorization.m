//
//  LEMSystemAuthorization.m
//  LEMUtility
//
//  Created by Himin on 2018/12/7.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "LEMSystemAuthorization.h"

#import <AVFoundation/AVFoundation.h>

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import <UserNotifications/UserNotifications.h>
//@import CoreTelephony;

#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

#import <CoreLocation/CoreLocation.h>

#import <EventKit/EventKit.h>

//手机系统版本号
#define pSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation LEMSystemAuthorization

// 相机权限
+ (BOOL)hasCameraAuthorization {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

// 相册权限
+ (BOOL)hasPhotoLibraryAuthorization {
//    if (pSystemVersion > 8.0) {
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
            return NO;
        }
//    } else {
//        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
//        if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
//            return NO;
//        }
//        return YES;
//    }
    return YES;
}

// 通知权限
+ (BOOL)hasNotificationAuthorization {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone == setting.types) {
        return NO;
    }
    return YES;
}

// 网络权限
+ (BOOL)hasNetWorkAuthorization {
//    CTCellularData *cellularData = [[CTCellularData alloc]init];
//    CTCellularDataRestrictedState state = cellularData.restrictedState;
//
//    NSLog(@"network status == %zu", state);
//
//    if (state == kCTCellularDataRestricted) {
//        return NO;
//    }
//    return YES;
    return NO;
}

// 麦克风权限
+ (BOOL)hasMicrophoneAuthorization {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

// 定位权限
+ (BOOL)hasLocationAuthorization {
    BOOL isLocationEnabled = [CLLocationManager locationServicesEnabled];
    if (!isLocationEnabled) {
        CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
        if (authStatus == kCLAuthorizationStatusDenied || authStatus == kCLAuthorizationStatusRestricted) {
            return NO;
        }
    }
    return YES;
}

// 通讯录权限
+ (BOOL)hasAddressBookAuthorization {
    if (pSystemVersion >= 9.0) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted) {
            return NO;
        }
    } else {
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        if (authStatus == kABAuthorizationStatusDenied || authStatus == kABAuthorizationStatusRestricted) {
            return NO;
        }
    }
    return YES;
}

// 日历权限
+ (BOOL)hasCalendarAuthorization {
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (authStatus == EKAuthorizationStatusDenied || authStatus == EKAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

// 备忘录权限
+ (BOOL)hasMemorandumAuthorization {
    return NO;
}

// 提醒事项权限
+ (BOOL)hasReminderAuthorization {
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if (authStatus == EKAuthorizationStatusDenied || authStatus == EKAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

@end
