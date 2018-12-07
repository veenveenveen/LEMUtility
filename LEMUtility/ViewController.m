//
//  ViewController.m
//  LEMUtility
//
//  Created by Himin on 2018/11/26.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "ViewController.h"
#import "LEMUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 140, 100, 40)];
        btn.layer.backgroundColor = UIColor.orangeColor.CGColor;
        [btn setTitle:@"sandClock" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick3) forControlEvents:UIControlEventTouchUpInside];
        //        [btn setEnlargeTouchAreaWithLeft:50 top:20 right:50 bottom:20];///
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(160, 140, 70, 40)];
        btn.layer.backgroundColor = UIColor.orangeColor.CGColor;
        [btn setTitle:@"orbit" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(orbitClick4) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(260, 140, 70, 40)];
        btn.layer.backgroundColor = UIColor.orangeColor.CGColor;
        [btn setTitle:@"system" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick5) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 200, 70, 40)];
        btn.layer.backgroundColor = UIColor.orangeColor.CGColor;
        [btn setTitle:@"文字" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick6) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(160, 200, 70, 40)];
        btn.layer.backgroundColor = UIColor.orangeColor.CGColor;
        [btn setTitle:@"图片" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick7) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(260, 200, 70, 40)];
        btn.layer.backgroundColor = UIColor.orangeColor.CGColor;
        [btn setTitle:@"文字和图片" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick8) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithFrame:CGRectMake(40, 260, 140, 180)
                                       image:kImageName(@"icon_delete")
                                        text:@"文字/图片"
                                    textFont:[UIFont systemFontOfSize:15]
                                   textColor:UIColor.lightGrayColor
                                       click:^(id sender) {
                                           DLog(@"%@",sender);
                                           
//                                           LEMToastConfig *config = [[LEMToastConfig alloc] init];
//                                           config.textFont = [UIFont systemFontOfSize:14];
//                                           config.textColor = UIColor.brownColor;
//                                           config.contentMode = UIViewContentModeScaleAspectFit;
//                                           config.imageHeight = 20;
//                                           [LEMToast showToastWithConfig:config text:@"示提示提示示" image:kImageName(@"icon_delete") time:2];
                                           
                                           [LEMToast showToastWithText:@"删除失败" image:kImageName(@"icon_delete") time:1];
                                       }];
        [btn setButtonImagePosition:LEMButtonImagePositionTop];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithFrame:CGRectMake(190, 260, 140, 180)
                                       image:kImageName(@"icon_delete")
                                        text:@"文字/文字"
                                    textFont:[UIFont systemFontOfSize:15]
                                   textColor:UIColor.lightGrayColor
                                       click:^(id sender) {
                                           
                                           NSString *str = @"2018 11 28";
                                           
                                           NSTimeInterval interval = [NSDate getTimestampWithDateString:str];
                                           DLog(@"%@",@[@(interval)]);
                                           
                                           NSString *year = [NSDate getYearWithDateString:str];
                                           NSString *month = [NSDate getMonthWithDateString:str];
                                           NSString *day = [NSDate getDayWithDateString:str];
                                           NSString *week = [NSDate getWeekWithDateString:str];
                                           DLog(@"%@",@[year,month,day,week]);
                                           
                                       }];
        [btn setButtonImagePosition:LEMButtonImagePositionTop];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton textButtonWithFrame:CGRectMake(40, 420, 140, 60) text:@"viewController" textFont:[UIFont systemFontOfSize:15] textColor:UIColor.lightGrayColor click:^(id sender) {
                                           
                                           NSLog(@"self = %@",self);
                                           NSLog(@"self controller = %@",[(UIButton *)sender lem_viewController]);
                                           
        }];
        
        [self.view addSubview:btn];
    }
    {
        UIButton *btn = [UIButton textButtonWithFrame:CGRectMake(230, 420, 140, 60) text:@"tttt" textFont:[UIFont systemFontOfSize:15] textColor:UIColor.lightGrayColor click:^(id sender) {
            UIImage *image = [UIImage imageNamed:@"icon_delete"];
            NSData *data = UIImagePNGRepresentation(image);
            NSData *data2 = UIImageJPEGRepresentation(image, 0.9);
//            NSLog(@"png image data = %@",data);
//            NSLog(@"jpeg image data = %@",data2);
            
//            NSLog(@"png image data = %zd",[UIImage imageTypeWithData:data]);
//            NSLog(@"jpeg image data = %zd",[UIImage imageTypeWithData:data2]);
            NSLog(@"png image data = %zd",[UIImage YYImageDetectType:CFBridgingRetain(data)]);
            NSLog(@"jpeg image data = %zd",[UIImage YYImageDetectType:CFBridgingRetain(data2)]);
        }];
        
        [self.view addSubview:btn];
    }
    {
        UIButton *btn = [UIButton textButtonWithFrame:CGRectMake(30, 500, 140, 60) text:@"custom" textFont:[UIFont systemFontOfSize:15] textColor:UIColor.lightGrayColor click:^(id sender) {
            UIImage *image = [UIImage imageNamed:@"icon_delete"];
            UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
            imgV.contentMode = UIViewContentModeCenter;
            imgV.backgroundColor = UIColor.orangeColor;
            imgV.layer.cornerRadius = 5;
            imgV.frame = CGRectMake(20, 60, 35, 35);
            
            [LEMToast showToastWithCustomView:imgV time:2];
            
//            NSArray *array = @[@"test1", @"test2"];
//
//            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:nil];
//
//            [self presentViewController:activityVC animated:YES completion:^{
//                                 NSLog(@"Air");
//            }];
            
            UIImage *img = [UIImage fullScreenImage];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 80, 255, 500)];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.layer.borderColor = UIColor.lightGrayColor.CGColor;
            imgView.layer.borderWidth = 0.5;
            imgView.image = img;
            [self.view addSubview:imgView];
        }];
        
        [self.view addSubview:btn];
        
        
        
//        [[[UIView alloc] init] drawViewHierarchyInRect:[UIScreen mainScreen].bounds afterScreenUpdates:NO];
    }
    self.view.backgroundColor = UIColor.lightGrayColor;
}

- (void)btnClick3 {
    [LEMToast showLoading:LEMLoadingStyleSandClock];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LEMToast hideLoading];
    });
}

- (void)orbitClick4 {
    [LEMToast showLoading:LEMLoadingStyleOrbitView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LEMToast hideLoading];
    });
}

- (void)btnClick5 {
    [LEMToast showLoading:LEMLoadingStyleSystem];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LEMToast hideLoading];
    });
}

- (void)btnClick6 {
//    LEMToastConfig *config = [[LEMToastConfig alloc] init];
//    config.backgroundColor = UIColor.orangeColor;
//    config.textFont = [UIFont systemFontOfSize:15];
//    config.textColor = UIColor.brownColor;
    
//    [LEMToast showToastWithConfig:config text:@"提示" time:2];
    [LEMToast showToastWithText:@"提示提示提"];
}

- (void)btnClick7 {
//    LEMToastConfig *config = [[LEMToastConfig alloc] init];
//    config.backgroundColor = UIColor.orangeColor;
//    config.textFont = [UIFont systemFontOfSize:12];
//    config.textColor = UIColor.brownColor;
//    config.toastWidth = 60;
//
//    config.contentMode = UIViewContentModeScaleAspectFit;
//    config.imageHeight = 30;
    
//    [LEMToast showToastWithConfig:config text:nil image:kImageName(@"icon_delete") time:2];
    [LEMToast showToastWithImage:[UIImage imageNamed:@"icon_detail"]];
    
}

- (void)btnClick8 {
    LEMToastConfig *config = [[LEMToastConfig alloc] init];
    
//    config.contentMode = UIViewContentModeScaleAspectFit;
//    config.toastWidth = 200;
//    config.imageHeight = 30;
    
    [LEMToast showToastWithConfig:config text:nil image:kImageName(@"com") time:2];
}


@end
