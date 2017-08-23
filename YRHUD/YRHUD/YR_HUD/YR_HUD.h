//
//  YR_HUD.h
//  communicationHierarchy
//
//  Created by Luck on 17/3/27.
//  Copyright © 2017年 hongmw. All rights reserved.
//

#import <UIKit/UIKit.h>

//角度转弧度
#define YR_RADIANS_TO_DEGREES(radians)    ((radians) * (180.0 / M_PI))

//弧度转角度
#define YR_DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

/**
 * 样式

 - YR_HUD_loaddingStyle: 加载中样式
 - YR_HUD_tipsInfoStyle: 提示信息样式
 - YR_HUD_tipsErrorStyle: 错误提示信息样式
 - YR_HUD_successStyle: 成功样式
 - YR_HUD_laodTipsStyle: 加载中带提示信息样式
 */
typedef NS_ENUM(NSInteger,YR_HUDStyle) {
    YR_HUD_loaddingStyle            = 0,
    YR_HUD_tipsInfoStyle            = 1,
    YR_HUD_tipsErrorStyle           = 2,
    YR_HUD_successStyle             = 3,
    YR_HUD_laodTipsStyle            = 4,
};

@interface YR_HUD : UIView


/**
 * 边缘颜色 默认 [UIColor whiteColor]
 */
@property (nonatomic,strong)UIColor * strokeColors;

/**
 * 圆形半径(默认 25.0)
 */
@property (nonatomic,assign)CGFloat radius;

/**
 * 开始的弧度 默认：((-90.0f / 180.0 * M_PI))
 */
@property (nonatomic,assign)CGFloat startRadian;

/**
 * 结束的弧度 ((240.0f / 180.0 * M_PI))
 */
@property (nonatomic,assign)CGFloat endRadian;

/**
 * 方向(默认顺时针)
 */
@property (nonatomic,assign)BOOL counterclockwise;

/**
 * 圆形宽度 默认：2.0
 */
@property (nonatomic,assign)CGFloat lineWidth;

/**
 * 动画时间 默认：1.0秒
 */
@property (nonatomic,assign)double rotationAnimationDuration;

+ (instancetype)shareInstancetype;

/**
 * 设置HUD样式

 @param style 样式
 @param tips 提示信息 可空
 */
+ (void)setHUDStyle:(YR_HUDStyle)style tips:(NSString * )tips;

/**
 * 需要调用此函数才能显示
 */
+ (void)showHUD;

/**
 * 隐藏HUD
 */
+ (void)dismissHUD;

/**
 在...秒之后隐藏HUD

 @param time 时间
 */
+ (void)dismissHUDafter:(CGFloat)time;

/**
 是否允许用户交互

 @param Interactions  默认 NO
 */
+ (void)isAllowInteractions:(BOOL)Interactions;

/**
 * 边缘颜色 默认 [[UIColor darkGrayColor]colorWithAlphaComponent:0.3f]

 @param color 自定义颜色 
 */
+ (void)setStrokeColor:(UIColor *)color;

/**
 * 设置圆形半径(默认 25.0)

 @param radius 半径长度
 */
+ (void)setRadius:(CGFloat)radius;

/**
 * 设置动画时间 默认：1.0秒

 @param rotationAnimationDuration 动画持续时间
 */
+ (void)setRotationAnimationDuration:(double)rotationAnimationDuration;

/**
 * 设置开始的弧度 默认：((-90.0f / 180.0 * M_PI))

 @param startRadian 开始弧度
 */
+ (void)setStartRadian:(CGFloat)startRadian;

/**
 * 设置结束的弧度 ((240.0f / 180.0 * M_PI))

 @param endRadian 结束弧度
 */
+ (void)setEndRadian:(CGFloat)endRadian;

/**
 * 设置动画旋转方向(默认：NO 顺时针)

 @param counterclockwise YES 逆时针
 */
+ (void)setCounterclockwise:(BOOL)counterclockwise;

/**
 * 设置圆形宽度 默认：2.0

 @param lineWidth 圆形宽度
 */
- (void)setLineWidth:(CGFloat)lineWidth;


@end









