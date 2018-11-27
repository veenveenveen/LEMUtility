//
//  XYZRouterURLData.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/8.
//  Copyright © 2018 Himin. All rights reserved.
//

// 用于接受处理URL

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XYZAppRouteType) {
    XYZAppRouteTypePage = 0,    // 打开页面 host = "open"
    XYZAppRouteTypeAction = 1   // 调用方法 host = "action"
};

@interface XYZRouterURLData : NSObject

+ (instancetype)urlDataWithURL:(NSURL *)url;

// 路由类型
@property (nonatomic, readonly, assign) XYZAppRouteType routeType;

// 页面名
@property (nonatomic, readonly, copy) NSString *controllerName;
// 方法名
@property (nonatomic, readonly, copy) NSString *actionName;

// url 传递的参数(解析为字典)
@property (nonatomic, readonly, copy) NSDictionary *data;

@end

NS_ASSUME_NONNULL_END
