//
//  XYZRouterManager.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/8.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "XYZRouterManager.h"
#import "XYZRouterComponent.h"
#import "XYZRouterURLData.h"
#import "XYZRouterURLConfig.h"

#define LogError(str) [NSString stringWithFormat:@"XYZRouteError: %@",str]
#define routerURLConfig [XYZRouterURLConfig shareInstance]

static XYZRouterManager *_instance;

@interface XYZRouterManager () <NSCopying>

@property (nonatomic, copy) ActionBlock actionBlock;

@end

@implementation XYZRouterManager

#pragma mark - 实现单例

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark - app: page/action

// 当使用url时需要在AppDelegate先进行配置
+ (void)startWithURLSchemes:(NSArray<NSString *> *)schemes pageHost:(NSString *)pageHost actionHost:(NSString *)actionHost actionBlock:(ActionBlock)actionBlock {
    routerURLConfig.schemes = schemes;
    routerURLConfig.pageHost = pageHost;
    routerURLConfig.actionHost = actionHost;
    
    [XYZRouterManager shareInstance].actionBlock = actionBlock;
}

// 处理app间的通信、跳转等事件
- (BOOL)actionWithURL:(NSURL *)url  {
    if (![routerURLConfig.schemes containsObject:url.scheme]) { return NO; }
    XYZRouterURLData *urlData = [XYZRouterURLData urlDataWithURL:url];
    if (urlData.routeType == XYZAppRouteTypePage) {
        // 页面跳转
#pragma - todo
        [self pushVCWithName:urlData.controllerName from:nil withData:urlData.data animated:YES];
//        [self presentVCWithName:urlData.controllerName from:nil withData:urlData.data animated:YES completion:nil];
    } else {
        NSString *actionName = urlData.actionName;
        NSDictionary *actionParam = urlData.data;
        // 执行方法
        if (self.actionBlock) {
            self.actionBlock(actionName, actionParam);
        }
    }
    return YES;
}

#pragma mark - vc: push/present

// push
- (BOOL)pushVCWithName:(NSString *)name from:(UIViewController *)fromVC withData:(NSDictionary *)data animated:(BOOL)animated {
    UIViewController *vc = [self controllerFromString:name];
    return [self pushVC:vc from:fromVC withData:data animated:animated];
}

- (BOOL)pushVC:(UIViewController *)vc from:(UIViewController *)fromVC withData:(NSDictionary *)data animated:(BOOL)animated {
    if (!vc) { return NO; }
    UIViewController *v = fromVC ? fromVC : [self currentViewController];
    if (data && data.count > 0) {
        [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [vc setValue:obj forKey:key];
        }];
    }
    [v.navigationController pushViewController:vc animated:animated];
    return YES;
}

// present
- (BOOL)presentVCWithName:(NSString *)name from:(UIViewController *)fromVC withData:(NSDictionary *)data animated:(BOOL)animated completion:(void(^)(void))completion {
    UIViewController *vc = [self controllerFromString:name];
    return [self presentVC:vc from:fromVC withData:data animated:animated completion:completion];
}

- (BOOL)presentVC:(UIViewController *)vc from:(UIViewController *)fromVC withData:(NSDictionary *)data animated:(BOOL)animated completion:(void(^)(void))completion {
    if (!vc) { return NO; }
    UIViewController *v = fromVC ? fromVC : [self currentViewController];
    if (data.count > 0) {
        [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [vc setValue:obj forKey:key];
        }];
    }
    [v presentViewController:vc animated:animated completion:completion];
    return YES;
}

#pragma mark -

// 动态获取vc, 根据字符串获取对应的vc
- (UIViewController *)controllerFromString:(NSString *)name {
    if (!name || name.length == 0) {
        LogError(@"请传入class名");
        return nil;
    }
    //如果此路由标示有对应的类名 注册,如: [self xyz_registerClassForKey:@"refresh2"];
    if ([[XYZRouterComponent shareInstance].registerDict objectForKey:name]) {
        //取出真实的类名
        name = [[XYZRouterComponent shareInstance].registerDict objectForKey:name];
    }
    
    id vc = [[NSClassFromString(name) alloc] init];
    if (vc) {
        if ([vc isKindOfClass:[UIViewController class]]) {
            return vc;
        }
        NSString *error = [NSString stringWithFormat:@"Class %@不是controller",name];
        LogError(error);
        return nil;
    } else {
        NSString *error = [NSString stringWithFormat:@"Class %@不存在",name];
        LogError(error);
        return nil;
    }
}

// 获取到当前的VC
- (UIViewController *)currentViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *w in windows) {
            if (w.windowLevel == UIWindowLevelNormal) {
                window = w;
                break;
            }
        }
    }
    
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

@end
