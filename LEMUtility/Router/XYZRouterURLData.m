//
//  XYZRouterURLData.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/8.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "XYZRouterURLData.h"
#import "XYZRouterURLConfig.h"

@interface XYZRouterURLData ()

/* 原始URL
 原始URL如: TestAll://open/login?name=test
 url scheme: TestAll,
 url host: open,
 url path: /login,
 url query: name=test
 */
@property (nonatomic, strong) NSURL *url;

@end

@implementation XYZRouterURLData

+ (instancetype)urlDataWithURL:(NSURL *)url {
    XYZRouterURLData *routerURLData = [[self alloc] init];
    routerURLData.url = url;
    return routerURLData;
}

#pragma mark -

- (XYZAppRouteType)routeType {
    if (self.url.host && [self.url.host isEqualToString:[XYZRouterURLConfig shareInstance].actionHost]) {
        return XYZAppRouteTypeAction;
    }
    return XYZAppRouteTypePage;
}

#pragma mark -

- (NSString *)controllerName {
    if (self.routeType == XYZAppRouteTypePage) {
        return self.url.path.length > 0 ? [self.url.path substringFromIndex:1] : @"";
    }
    return nil;
}

- (NSString *)actionName {
    if (self.routeType == XYZAppRouteTypeAction) {
        return self.url.path.length > 0 ? [self.url.path substringFromIndex:1] : @"";
    }
    return  nil;
}

- (NSDictionary *)data {
    NSString *queryString = self.url.query;
    if (!queryString || queryString.length == 0) { return nil; }
    NSArray *keyValues = [queryString componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [@{} mutableCopy];
    [keyValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value = [obj componentsSeparatedByString:@"="].lastObject;
        NSString *key = [obj componentsSeparatedByString:@"="].firstObject;
        [dict setObject:value forKey:key];
    }];
    return [dict copy];
}

@end
