//
//  LEMRouter.h
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#ifndef LEMRouter_h
#define LEMRouter_h

#import "XYZRouterManager.h"
#import "UIViewController+XYZRouter.h"
#import "XYZRouterComponent.h"

/* url(外部路由) 使用
 // 1. 当使用url时需要在AppDelegate先进行配置
 + (void)startWithURLSchemes:(NSArray<NSString *> *)schemes pageHost:(NSString *)pageHost actionHost:(NSString *)actionHost;
 // 2. 代理方法中加入 [[XYZRouterManager shareInstance] actionWithURL:url];
 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
 [[XYZRouterManager shareInstance] actionWithURL:url];
 return YES;
 // 3. 外部App调用open方法
 let officialURLStr = "TestAll://action/logPrint?name=test"
 if #available(iOS 10.0, *) {
 UIApplication.shared.open(URL(string: officialURLStr)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
 } else {
 UIApplication.shared.openURL(URL(string: officialURLStr)!)
 }
 或:
 let officialURLStr = "TestAll://open/refresh2"
 if #available(iOS 10.0, *) {
 UIApplication.shared.open(URL(string: officialURLStr)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
 } else {
 UIApplication.shared.openURL(URL(string: officialURLStr)!)
 }
 
 内部路由推荐使用
 [[XYZRouterManager shareInstance] push...]; 或者 [[XYZRouterManager shareInstance] present...];
 */

#endif /* LEMRouter_h */
