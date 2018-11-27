//
//  XYZRouterURLConfig.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/9.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "XYZRouterURLConfig.h"

static XYZRouterURLConfig *_instance;

@interface XYZRouterURLConfig () <NSCopying>

@end

@implementation XYZRouterURLConfig

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

- (NSString *)pageHost {
    if (!_pageHost) {
        _pageHost = @"open";
    }
    return _pageHost;
}

- (NSString *)actionHost {
    if (!_actionHost) {
        _actionHost = @"action";
    }
    return _actionHost;
}

@end
