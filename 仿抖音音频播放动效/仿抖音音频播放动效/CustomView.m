//
//  CustomView.m
//  仿抖音音频播放动效
//
//  Created by Gu,Jinyue on 2018/8/9.
//  Copyright © 2018年 baidu. All rights reserved.
//

#import "CustomView.h"

@interface CustomView()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *note1;
@property (nonatomic, strong) UIImageView *note11;
@property (nonatomic, strong) UIImageView *note2;

@end

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        [self imageView];
        [self note1];
        [self note11];
        [self note2];
        
//        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, -20)
//                                                                  radius:80
//                                                              startAngle:0.5 * M_PI
//                                                                endAngle:1.0 * M_PI
//                                                               clockwise:YES];
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//        shapeLayer.path = bezierPath.CGPath;
//        shapeLayer.strokeColor = [UIColor greenColor].CGColor;
//        shapeLayer.lineWidth = 1.0;
//        shapeLayer.fillColor = [UIColor clearColor].CGColor;
//        [self.layer addSublayer:shapeLayer];
        
    }
    return self;
}

#pragma mark - Private Methods

- (UIImage *)circleImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 1.0);
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [[UIBezierPath bezierPathWithOvalInRect:rect] addClip];
    [image drawInRect:rect];
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

- (CABasicAnimation *)zRotationAnimation {
    CABasicAnimation *zRotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    zRotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    zRotateAnimation.toValue   = [NSNumber numberWithFloat:2.0 * M_PI];
    zRotateAnimation.duration  = 8.0;
    zRotateAnimation.repeatCount = MAXFLOAT;
    zRotateAnimation.autoreverses = NO;
    return zRotateAnimation;
}

- (CAAnimationGroup *)groupAnimationWithBeginTime:(CFTimeInterval)beginTime clockwise:(BOOL)clockwise{
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = 5.0;
    moveAnimation.autoreverses = NO; // 不要逆方向做动画回去
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.calculationMode = kCAMediaTimingFunctionLinear;
//    moveAnimation.removedOnCompletion = NO; // 在动画结束时不移除动画
//    moveAnimation.fillMode = kCAFillModeForwards; // 始终保持最新的效果
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, -10)
                                                              radius:80
                                                          startAngle:0.5 * M_PI
                                                            endAngle:1.0 * M_PI
                                                           clockwise:YES];
    moveAnimation.path = bezierPath.CGPath;
    
    CABasicAnimation *zRotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    zRotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    if (clockwise) {
        zRotateAnimation.toValue   = [NSNumber numberWithFloat:M_PI / 5];
    } else {
        zRotateAnimation.toValue   = [NSNumber numberWithFloat:-1.0 * M_PI / 5];
    }
    zRotateAnimation.duration  = 5.0;
    zRotateAnimation.autoreverses = NO;
    zRotateAnimation.repeatCount = MAXFLOAT;
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values   = @[[NSNumber numberWithFloat:0.3],
                                  [NSNumber numberWithFloat:1.0],
                                  [NSNumber numberWithFloat:0.0]];
    
    opacityAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0],
                                  [NSNumber numberWithFloat:0.5],
                                  [NSNumber numberWithFloat:1.0]];
    
    opacityAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    opacityAnimation.duration  = 5.0;
    opacityAnimation.autoreverses = NO;
    opacityAnimation.repeatCount = MAXFLOAT;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values   = @[[NSNumber numberWithFloat:0.3],
                                [NSNumber numberWithFloat:1.1],
                                [NSNumber numberWithFloat:1.0]];
    
    scaleAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0],
                                [NSNumber numberWithFloat:0.5],
                                [NSNumber numberWithFloat:1.0]];
    
    scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    scaleAnimation.duration  = 5.0;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = NO;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:moveAnimation, opacityAnimation, zRotateAnimation, scaleAnimation, nil];
    animationGroup.duration = 5.0;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.beginTime = beginTime;
    
    return animationGroup;
}

#pragma mark - Getter

- (UIImageView *)imageView {
    if (!_imageView) {
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _imageView = [[UIImageView alloc] initWithFrame:rect];
        _imageView.image = [self circleImage:[UIImage imageNamed:@"1.jpg"]];
        [_imageView.layer addAnimation:[self zRotationAnimation] forKey:@"ZRotation_Animation"];
        _imageView.backgroundColor = [UIColor greenColor];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIImageView *)note1 {
    if (!_note1) {
        CGRect rect = CGRectMake(25, 60, 20, 20);
        _note1 = [[UIImageView alloc] initWithFrame:rect];
        _note1.image = [UIImage imageNamed:@"2.png"];
        [_note1.layer addAnimation:[self groupAnimationWithBeginTime:CACurrentMediaTime() clockwise:YES] forKey:@"Group_Animation1"];
        _note1.alpha = 0.0;
        [self addSubview:_note1];
    }
    return _note1;
}

- (UIImageView *)note11 {
    if (!_note11) {
        CGRect rect = CGRectMake(25, 60, 20, 20);
        _note11 = [[UIImageView alloc] initWithFrame:rect];
        _note11.image = [UIImage imageNamed:@"2.png"];
        [_note11.layer addAnimation:[self groupAnimationWithBeginTime:CACurrentMediaTime() + 1.6 clockwise:NO] forKey:@"Group_Animation2"];
        _note11.alpha = 0.0;
        [self addSubview:_note11];
    }
    return _note11;
}

- (UIImageView *)note2 {
    if (!_note2) {
        CGRect rect = CGRectMake(25, 60, 20, 20);
        _note2 = [[UIImageView alloc] initWithFrame:rect];
        _note2.image = [UIImage imageNamed:@"3.png"];
        [_note2.layer addAnimation:[self groupAnimationWithBeginTime:CACurrentMediaTime() + 3.2 clockwise:NO] forKey:@"Group_Animation3"];
        _note2.alpha = 0.0;
        [self addSubview:_note2];
    }
    return _note2;
}

@end
