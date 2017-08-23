//
//  ViewController.m
//  UIView-X-Y-Height-width
//
//  Created by 洪绵卫 on 2017/8/23.
//  Copyright © 2017年 洪绵卫. All rights reserved.
//

#import "ViewController.h"
#import "UIView+YRExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"\n X = %f",self.view.x);
    NSLog(@"\n Y = %f",self.view.y);
    NSLog(@"\n Width = %f",self.view.Width);
    NSLog(@"\n Height = %f",self.view.Height);
    NSLog(@"\n origin = %@",NSStringFromCGPoint(self.view.origin));
    NSLog(@"\n size = %@",NSStringFromCGSize(self.view.size));
    NSLog(@"\n centerX = %f",self.view.centerX);
    NSLog(@"\n centerY = %f",self.view.centerY);
    NSLog(@"\n Y+Height = %f",self.view.bootom);
    NSLog(@"\n X+width = %f",self.view.right);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
