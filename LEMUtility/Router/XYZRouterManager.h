//
//  XYZRouterManager.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/8.
//  Copyright © 2018 Himin. All rights reserved.
//

// 此类包含内部路由和外部路由

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(NSString *actionName, NSDictionary *actionParam);

@interface XYZRouterManager : NSObject

// 单例访问
+ (instancetype)shareInstance;

// 当使用url时需要在AppDelegate先进行配置
+ (void)startWithURLSchemes:(NSArray<NSString *> *)schemes pageHost:(NSString *)pageHost actionHost:(NSString *)actionHost actionBlock:(ActionBlock)actionBlock;

// 处理app间的通信、跳转等事件(也可用于内部vc之间的跳转,推荐只用于外部路由)
- (BOOL)actionWithURL:(NSURL *)url;

// vc: app内路由(推荐用于内部路由)
- (BOOL)pushVCWithName:(NSString *)name from:(UIViewController *)fromVC withData:(NSDictionary *)data animated:(BOOL)animated;
- (BOOL)pushVC:(UIViewController *)vc from:(UIViewController *)fromVC withData:(NSDictionary *)data animated:(BOOL)animated;

- (BOOL)presentVCWithName:(NSString *)name from:(UIViewController *)fromVC withData:(NSDictionary *)data animated:(BOOL)animated completion:(void(^)(void))completion;
- (BOOL)presentVC:(UIViewController *)vc from:(UIViewController *)fromVC withData:(NSDictionary *)data animated:(BOOL)animated completion:(void(^)(void))completion;

@end
