//
//  UIViewController+XYZRouter.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/8.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "UIViewController+XYZRouter.h"
#import "XYZRouterManager.h"
#import "XYZRouterComponent.h"

#define routerManager [XYZRouterManager shareInstance]

@implementation UIViewController (XYZRouter)

+ (void)xyz_registerClassForKey:(NSString *)key {
    [[XYZRouterComponent shareInstance] registerClass:NSStringFromClass(self) forKey:key];
}

- (BOOL)xyz_pushVCWithName:(NSString *)name {
    return [routerManager pushVCWithName:name from:self withData:nil animated:YES];
}
- (BOOL)xyz_presentVCWithName:(NSString *)name {
    return [routerManager presentVCWithName:name from:self withData:nil animated:YES completion:nil];
}

- (BOOL)xyz_pushVCWithName:(NSString *)name with:(NSDictionary *)data {
    return [routerManager pushVCWithName:name from:self withData:data animated:YES];
}
- (BOOL)xyz_presentVCWithName:(NSString *)name with:(NSDictionary *)data {
    return [routerManager presentVCWithName:name from:self withData:data animated:YES completion:nil];
}

- (BOOL)xyz_push:(UIViewController *)vc {
    return [routerManager pushVC:vc from:self withData:nil animated:YES];
}
- (BOOL)xyz_present:(UIViewController *)vc {
    return [routerManager presentVC:vc from:self withData:nil animated:YES completion:nil];
}

- (BOOL)xyz_push:(UIViewController *)vc with:(NSDictionary *)data {
    return [routerManager pushVC:vc from:self withData:data animated:YES];
}

- (BOOL)xyz_present:(UIViewController *)vc with:(NSDictionary *)data {
    return [routerManager presentVC:vc from:self withData:data animated:YES completion:nil];
}

@end
