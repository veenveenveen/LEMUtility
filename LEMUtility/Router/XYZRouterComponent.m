//
//  XYZRouterComponent.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/8.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "XYZRouterComponent.h"

static XYZRouterComponent *_instance;

@interface XYZRouterComponent () <NSCopying>

@end

@implementation XYZRouterComponent

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

#pragma mark -

- (void)registerClass:(NSString *)className forKey:(NSString *)key {
    if (!className || className.length == 0) { return; }
    if (!key || key.length == 0) { return; }
    [self.registerDict setObject:className forKey:key];
}

#pragma mark -

- (NSDictionary *)registerDict {
    if (!_registerDict) {
        _registerDict = [@{} mutableCopy];
    }
    return _registerDict;
}


@end
