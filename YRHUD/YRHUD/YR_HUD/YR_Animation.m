//
//  YR_Animation.m
//  communicationHierarchy
//
//  Created by Luck on 17/4/4.
//  Copyright © 2017年 hongmw. All rights reserved.
//

#import "YR_Animation.h"

@implementation YR_Animation

/**
 * 添加一个自旋转动画
 */
+ (void)addSelfRotationAnimation:(CALayer * )anumationLayer duration:(NSTimeInterval)duration{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [anumationLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

/**
 *  SVPHUD 的动画
 */
- (void)addAnimationsSVP:(UIView * )view{
    NSTimeInterval animationDuration = 1;
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = (id) 0;
    animation.toValue = @(M_PI*2);
    animation.duration = animationDuration;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = INFINITY;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [view.layer.mask addAnimation:animation forKey:@"rotate"];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = animationDuration;
    animationGroup.repeatCount = INFINITY;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = linearCurve;
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @0.015;
    strokeStartAnimation.toValue = @0.515;
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0.485;
    strokeEndAnimation.toValue = @0.985;
    
    animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    [view.layer addAnimation:animationGroup forKey:@"progress"];
}


@end
