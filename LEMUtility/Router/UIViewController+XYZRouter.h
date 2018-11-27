//
//  UIViewController+XYZRouter.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/8.
//  Copyright © 2018 Himin. All rights reserved.
//

// 此分类仅限于内部路由使用

#import <UIKit/UIKit.h>

@interface UIViewController (XYZRouter)

+ (void)xyz_registerClassForKey:(NSString *)key;

- (BOOL)xyz_pushVCWithName:(NSString *)name;
- (BOOL)xyz_presentVCWithName:(NSString *)name;

- (BOOL)xyz_pushVCWithName:(NSString *)name with:(NSDictionary *)data;
- (BOOL)xyz_presentVCWithName:(NSString *)name with:(NSDictionary *)data;

- (BOOL)xyz_push:(UIViewController *)vc;
- (BOOL)xyz_present:(UIViewController *)vc;

- (BOOL)xyz_push:(UIViewController *)vc with:(NSDictionary *)data;
- (BOOL)xyz_present:(UIViewController *)vc with:(NSDictionary *)data;

@end

