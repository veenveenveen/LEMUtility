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
}

- (void)btnClick3 {
    [HMLoading showLoading:HMLoadingStyleSandClock];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HMLoading hideLoading];
    });
}

- (void)orbitClick4 {
    [HMLoading showLoading:HMLoadingStyleOrbitView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HMLoading hideLoading];
    });
}

- (void)btnClick5 {
    [HMLoading showLoading:HMLoadingStyleSystem];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HMLoading hideLoading];
    });
}

- (void)btnClick6 {
    [HMLoading showToastWithText:@"提示提示提示提示提示提示" time:1.5];
}

- (void)btnClick7 {
    [HMLoading showToastWithImage:[UIImage imageNamed:@"com"]];
}

- (void)btnClick8 {
    [HMLoading showToastWithText:@"提示提示提示提示提示提示提示" image:[UIImage imageNamed:@"com"] time:2];
}


@end
