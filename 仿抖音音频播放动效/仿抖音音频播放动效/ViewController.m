//
//  ViewController.m
//  仿抖音音频播放动效
//
//  Created by Gu,Jinyue on 2018/8/9.
//  Copyright © 2018年 baidu. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

#define IPHONE_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define IPHONE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    CustomView *customView = [[CustomView alloc] initWithFrame:CGRectMake(IPHONE_SCREEN_WIDTH - 100, IPHONE_SCREEN_HEIGHT - 160, 60, 60)];
    [self.view addSubview:customView];
}

@end
