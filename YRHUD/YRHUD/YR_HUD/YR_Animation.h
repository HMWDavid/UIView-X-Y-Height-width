//
//  YR_Animation.h
//  communicationHierarchy
//
//  Created by Luck on 17/4/4.
//  Copyright © 2017年 hongmw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface YR_Animation : NSObject

/**
 * 添加一个自旋转动画

 @param anumationLayer 添加的Layer
 @param duration 持续时间
 */
+ (void)addSelfRotationAnimation:(CALayer * )anumationLayer duration:(NSTimeInterval)duration;

@end
