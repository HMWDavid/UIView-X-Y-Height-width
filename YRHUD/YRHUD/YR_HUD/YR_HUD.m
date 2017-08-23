//
//  YR_HUD.m
//  communicationHierarchy
//
//  Created by Luck on 17/3/27.
//  Copyright © 2017年 hongmw. All rights reserved.
//

#import "YR_HUD.h"
#import "UIView+YRLayoutConstraint.h"
#import "YR_Animation.h"

static CGFloat selfHeight  = 100.0f;
static CGFloat selfWisth   = 120.0f;
static CGFloat imageW      = 35.0f;

static NSString * tipsLeftLayoutIdentifier      = @"tipsLabLeftConstraintIdentifier";
static NSString * tipsRightLayoutIdentifier     = @"tipsRightConstraintIdentifier";
static NSString * tipsBottomLayoutIdentifier    = @"tipsBottomConstraintIdentifier";
static NSString * tipsTopLayoutIdentifier       = @"tipsTopConstraintIdentifier";

static NSString * imageVTopLayoutIdentifier     = @"imageVTopConstraintIdentifier";
static NSString * imageVWidthLayoutIdentifier   = @"imageVWidthConstraintIdentifier";
static NSString * imageVHeightLayoutIdentifier  = @"imageVHeightConstraintIdentifier";
static NSString * imageVCenterXLayoutIdentifier = @"imageVCenterXConstraintIdentifier";

static NSString * statusViewTopLayoutIdentifier     = @"statusViewTopConstraintIdentifier";
static NSString * statusViewWidthLayoutIdentifier   = @"statusViewVWidthConstraintIdentifier";
static NSString * statusViewHeightLayoutIdentifier  = @"statusViewHeightConstraintIdentifier";
static NSString * statusViewCenterXLayoutIdentifier = @"statusViewCenterXConstraintIdentifier";


@interface YR_HUD(){
    CAShapeLayer * _circleLayer;
    BOOL _isAnimation;
}

/**
 *  提示信息
 */
@property (nonatomic, strong) UILabel *tipsInfo;

/**
 *
 */
@property (nonatomic, strong) UIImageView *imageV;

/**
 *
 */
@property (nonatomic, strong) UIView *statusView;

/**
 *
 */
@property (nonatomic, strong) UIView *showView;

@end

@implementation YR_HUD

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setDefultValues];
    }
    
    return self;
}

+ (instancetype)shareInstancetype{
    static YR_HUD * once = nil;
    static dispatch_once_t queue ;
    dispatch_once(&queue, ^{
        once = [[self alloc]initWithFrame:[[[UIApplication sharedApplication] delegate]window].bounds];
    });
    return once;
}

- (void)updateConstraints
{
    [self addImageVConstraint];
    [self addTipsConstraint];
    [self addStatusViewConstraint];
    [super updateConstraints];
}

- (UIView *)windows{
    return [[[UIApplication sharedApplication] delegate]window];
}

- (void)setDefultValues{
    _isAnimation = NO;
    self.alpha = 0.0f;
    self.rotationAnimationDuration = self.rotationAnimationDuration>0?self.rotationAnimationDuration:1.0;
    self.lineWidth   = self.lineWidth>0?self.lineWidth:2.0;
    self.radius      = self.radius>0?self.radius:20.0;
    self.strokeColors = self.strokeColors!=nil?self.strokeColors:[UIColor whiteColor];
    self.startRadian = self.startRadian>0?self.startRadian:YR_DEGREES_TO_RADIANS(-90.0f);
    self.endRadian   = self.endRadian>0?self.endRadian:YR_DEGREES_TO_RADIANS(240.0f);
}

- (void)addBezierLayer:(CALayer *)superLayer{
    
    //贝塞尔曲线（UIBezierPath）属性、方法汇总  写的很好！
    //http://www.cnblogs.com/zhangying-domy/archive/2016/07/04/5640745.html
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _isAnimation = YES;
        
        UIBezierPath * circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(superLayer.frame.size.width/2.0, superLayer.frame.size.height/2.0) radius:(self.radius - self.lineWidth) startAngle:self.startRadian endAngle:self.endRadian clockwise:!self.counterclockwise];
        
        _circleLayer = [CAShapeLayer layer];
        
        _circleLayer.path    =   circlePath.CGPath;
        
        _circleLayer.fillMode    = kCAFillModeForwards;
        
        _circleLayer.strokeColor = self.strokeColors.CGColor;
        
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        
        [superLayer addSublayer:_circleLayer];
        
        [YR_Animation addSelfRotationAnimation:superLayer duration:self.rotationAnimationDuration];
    });
}

#pragma mark - set Style
+ (void)setHUDStyle:(YR_HUDStyle)style{
    [[self shareInstancetype]setHUDStyle:style tips:nil];
}

+ (void)setHUDStyle:(YR_HUDStyle)style tips:(NSString * )tips{
    [[self shareInstancetype]setHUDStyle:style tips:tips];
}

- (void)setHUDStyle:(YR_HUDStyle)style tips:(NSString * )tips{
    
    [[self windows]addSubview:self];
    
    [[self windows]bringSubviewToFront:self];
    
    //计算出文本大小
    CGRect rect = [self SetTextSizeWithText:tips font:15.0];
    
    CGRect selfRect = self.showView.frame;
    
    if (rect.size.width<selfWisth) {
        selfRect.size.width = selfWisth;
    }else{
        selfRect.size.width = rect.size.width + 20.0f;
    }
    
    if (rect.size.height<selfHeight) {
        selfRect.size.height = selfHeight;
    }else{
        selfRect.size.height = rect.size.height + 50.0f;
    }
    
    self.showView.frame = selfRect;
    self.showView.center = [self windows].center;

    //更新约束
    [self updateConstraintsIfNeeded];
    
    switch (style) {
        case YR_HUD_tipsInfoStyle:
        {
            [self setTipsInfoStyle:tips];
        }
            break;
        case YR_HUD_tipsErrorStyle:{
            [self setTipsErrorStyle:tips];
        }
            break;
        case YR_HUD_loaddingStyle:{
            [self setLoaddingStyle:tips];
        }
            break;
        case YR_HUD_laodTipsStyle:
        {
            [self setLaodTipsStyle:tips];
        }
            break;
        case YR_HUD_successStyle:{
            [self setSuccessStyle:tips];
        }
            break;
        default:
            break;
    }
}

- (void)setTipsInfoStyle:(NSString * )info{
    [self subViewsishidden:NO];
    self.tipsInfo.text = info;
    self.imageV.image = [UIImage imageNamed:@"info"];
}

- (void)setTipsErrorStyle:(NSString * )info{
    [self subViewsishidden:NO];
    self.tipsInfo.text = info;
    self.imageV.image = [UIImage imageNamed:@"error"];
}

- (void)setSuccessStyle:(NSString *)info{
    [self subViewsishidden:NO];
    self.tipsInfo.text = info;
    self.imageV.image = [UIImage imageNamed:@"success"];
}

- (void)setLoaddingStyle:(NSString * )info{
    [self subViewsishidden:YES];
    if (!_isAnimation) [self addBezierLayer:self.statusView.layer];
}

- (void)setLaodTipsStyle:(NSString * )info{
    [self subViewsishidden:YES];
    if (!_isAnimation) [self addBezierLayer:self.statusView.layer];
    self.tipsInfo.hidden = NO;
    self.tipsInfo.text = info;
}

+ (void)showHUD{
    [[self shareInstancetype]setAlpha:1.0f];
}

+ (void)dismissHUD{
    [[self shareInstancetype] setAlpha:0.0f];
    [[self shareInstancetype]removeCircleLayer];
}

+ (void)dismissHUDafter:(CGFloat)time{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissHUD];
    });
}

+ (void)isAllowInteractions:(BOOL)Interactions{
    if (Interactions) {
        [[self shareInstancetype] setFrame:CGRectMake(0, 0, 0, 0)];
        [[self shareInstancetype] updateConstraintsIfNeeded];
    }
}

- (void)subViewsishidden:(BOOL)ishidden{
    self.tipsInfo.hidden    = ishidden;
    self.imageV.hidden      = ishidden;
    self.statusView.hidden  = !ishidden;
}

- (void)removeCircleLayer{
    if (_isAnimation) {
        _isAnimation = NO;
        [self.statusView.layer removeAllAnimations];
    }
}


#pragma mark - '+'setters
+ (void)setStrokeColor:(UIColor *)color{
    [[self shareInstancetype] setStrokeColors:color];
}

+ (void)setRadius:(CGFloat)radius{
    [[self shareInstancetype] setRadius:radius];
}

+ (void)setRotationAnimationDuration:(double)rotationAnimationDuration
{
    [[self shareInstancetype]setRotationAnimationDuration:rotationAnimationDuration];
}

+ (void)setStartRadian:(CGFloat)startRadian
{
    [[self shareInstancetype]setStartRadian:startRadian];
}

+ (void)setEndRadian:(CGFloat)endRadian
{
    [[self shareInstancetype]setEndRadian:endRadian];
}

+ (void)setCounterclockwise:(BOOL)counterclockwise
{
    [[self shareInstancetype]setCounterclockwise:counterclockwise];
}

+ (void)setLineWidth:(CGFloat)lineWidth
{
    [[self shareInstancetype]setLineWidth:lineWidth];
}

#pragma mark -  '-' setters
- (void)setStrokeColors:(UIColor *)strokeColors{
    if (_strokeColors!=strokeColors) {
        _strokeColors = strokeColors;
    }
}

- (void)setRadius:(CGFloat)radius
{
    if (_radius!=radius) {
        _radius = radius;
    }
}

- (void)setRotationAnimationDuration:(double)rotationAnimationDuration
{
    if (_rotationAnimationDuration != rotationAnimationDuration) {
        _rotationAnimationDuration = rotationAnimationDuration;
    }
}

- (void)setStartRadian:(CGFloat)startRadian
{
    if (_startRadian != startRadian) {
        _startRadian = startRadian;
    }
}

- (void)setEndRadian:(CGFloat)endRadian
{
    if (_endRadian != endRadian) {
        _endRadian = endRadian;
    }
}

- (void)setCounterclockwise:(BOOL)counterclockwise
{
    if (_counterclockwise != counterclockwise) {
        _counterclockwise = counterclockwise;
    }
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    if (_lineWidth!= lineWidth) {
        _lineWidth = lineWidth;
    }
}

#pragma mark -  addConstraint
- (void)addTipsConstraint{
    NSLayoutConstraint * tipsLeftConstraint     = [self.tipsInfo addLeftConstraintToViewLeft:self.showView Offset:0 identifier:tipsLeftLayoutIdentifier];
    
    NSLayoutConstraint * tipsRightConstraint    = [self.tipsInfo addRightConstraintToViewRight:self.showView Offset:0 identifier:tipsRightLayoutIdentifier];
    
    NSLayoutConstraint * tipsBottomConstraint   = [self.tipsInfo addBottomConstraintToViewBottom:self.showView Offset:0 identifier:tipsBottomLayoutIdentifier];
    
    NSLayoutConstraint * tipsTopConstraint      = [self.tipsInfo addTopConstraintToViewBottom:self.imageV Offset:5.0f identifier:tipsTopLayoutIdentifier];
    
    [self.showView addConstraints:@[tipsLeftConstraint,tipsRightConstraint,tipsBottomConstraint,tipsTopConstraint]];
}

- (void)addImageVConstraint{
    
    NSLayoutConstraint * imageVTopConstraint      = [self.imageV addTopConstraintToViewTop:self.showView Offset:15.0 identifier:imageVTopLayoutIdentifier];
    NSLayoutConstraint * imageVCenterXConsraint   = [self.imageV addCenterXConstraintToViewCenterX:self.showView Offset:0 identifier:imageVCenterXLayoutIdentifier];
    
    NSLayoutConstraint * widthLayout    = [self.imageV addWidthConstraintValue:imageW identifier:imageVWidthLayoutIdentifier];
    NSLayoutConstraint * heightLayout   = [self.imageV addHeightConstraintValue:imageW identifier:imageVHeightLayoutIdentifier];
    
    [self.showView addConstraints:@[widthLayout,heightLayout,imageVCenterXConsraint,imageVTopConstraint]];
}

- (void)addStatusViewConstraint{
    NSLayoutConstraint * statusViewTopConstraint      = [self.statusView addTopConstraintToViewTop:self.showView Offset:15.0 identifier:statusViewTopLayoutIdentifier];
    NSLayoutConstraint * statusViewCenterXConsraint   = [self.statusView addCenterXConstraintToViewCenterX:self.showView Offset:0 identifier:statusViewCenterXLayoutIdentifier];
    
    NSLayoutConstraint * statusViewWidthLayout    = [self.statusView addWidthConstraintValue:imageW identifier:statusViewWidthLayoutIdentifier];
    NSLayoutConstraint * statusViewheightLayout   = [self.statusView addHeightConstraintValue:imageW identifier:statusViewHeightLayoutIdentifier];
    
    [self.showView addConstraints:@[statusViewWidthLayout,statusViewheightLayout,statusViewTopConstraint,statusViewCenterXConsraint]];
}

- (void)removeAllSubViewConstraint{
    [self.showView removeConstraintYR:tipsLeftLayoutIdentifier];
    [self.showView removeConstraintYR:tipsRightLayoutIdentifier];
    [self.showView removeConstraintYR:tipsBottomLayoutIdentifier];
    [self.showView removeConstraintYR:tipsTopLayoutIdentifier];
    
    [self.showView removeConstraintYR:imageVCenterXLayoutIdentifier];
    [self.showView removeConstraintYR:imageVTopLayoutIdentifier];
    [self.showView removeConstraintYR:imageVWidthLayoutIdentifier];
    [self.showView removeConstraintYR:imageVHeightLayoutIdentifier];
    
    [self.showView removeConstraintYR:statusViewTopLayoutIdentifier];
    [self.showView removeConstraintYR:statusViewCenterXLayoutIdentifier];
    [self.showView removeConstraintYR:statusViewWidthLayoutIdentifier];
    [self.showView removeConstraintYR:statusViewHeightLayoutIdentifier];
}

/**
 * 根据文字计算出文本的rect
 
 @param text 待计算的文本
 @param font 字体大小
 @return CGRect
 */
- (CGRect)SetTextSizeWithText:(NSString * )text font:(CGFloat)font{
    // 设置字体 HelveticaNeue  Courier
//    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:font];
    
    // 根据字体得到NSString的尺寸
    CGRect rect = [text boundingRectWithSize:CGSizeMake(YR_SCREEN_WIDTH - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:[NSDictionary dictionaryWithObjectsAndKeys:YR_CUSTOM_FONT(font),NSFontAttributeName, nil] context:nil];
    
    return rect;
}

#pragma makr- 懒加载
- (UILabel * )tipsInfo
{
    if (!_tipsInfo) {
        _tipsInfo = [[UILabel alloc]init];
        _tipsInfo.backgroundColor = self.backgroundColor;
        _tipsInfo.numberOfLines   = 0;
        _tipsInfo.textColor = [UIColor whiteColor];
        _tipsInfo.font = [UIFont systemFontOfSize:15.0];
        _tipsInfo.textAlignment = NSTextAlignmentCenter;
        [self.showView addSubview:_tipsInfo];
    }
    
    return _tipsInfo;
}

- (UIView * )statusView{
    if (!_statusView) {
        _statusView = [[UIView alloc]init];
        [self.showView addSubview:_statusView];
    }
    return _statusView;
}

- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        [self.showView addSubview:_imageV];
    }
    return _imageV;
}

- (UIView * )showView{
    if (!_showView) {
        _showView = [[UIView alloc]init];
        _showView.backgroundColor = [UIColor blackColor];
        _showView.layer.cornerRadius  = 4.0;
        _showView.layer.masksToBounds = YES;
        [self addSubview:_showView];
    }
    return _showView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
