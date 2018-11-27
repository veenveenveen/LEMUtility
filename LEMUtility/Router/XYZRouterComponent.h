//
//  XYZRouterComponent.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/8.
//  Copyright © 2018 Himin. All rights reserved.
//

// 用于在+load方法中注册

#import <Foundation/Foundation.h>

@interface XYZRouterComponent : NSObject

// 特殊路由标示注册字典
@property (nonatomic, strong) NSMutableDictionary *registerDict;

// 单例
+ (instancetype)shareInstance;

- (void)registerClass:(NSString *)className forKey:(NSString *)key;

@end
