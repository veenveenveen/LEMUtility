//
//  XYZRouterURLConfig.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/9.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYZRouterURLConfig : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, copy) NSString *pageHost;
@property (nonatomic, copy) NSString *actionHost;

@property (nonatomic, copy) NSArray<NSString *> *schemes;

@end

NS_ASSUME_NONNULL_END
