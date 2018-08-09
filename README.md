# JYVideoPlayerAnimation
仿照抖音视频主页面右下角音频播放动效。主要是CoreAnimation和UIBezierPath的使用。
1. CoreAnimation主要涉及CABasicAnimation、CAKeyframeAnimation、CAAnimationGroup。其中涉及到的属性有position、transform.scale、transform.rotation.z、opacity。
2. 自定义UIBezierPath, 作为position属性的移动路径。
3. 动画举例:
   ~~~
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
   ~~~

 <div align=center><img width="375" height="667" src="https://github.com/gujinyue1010/JYVideoPlayerAnimation/blob/master/运行效果/321.png"/></div>
 
 <div align=center><img width="375" height="667" src="https://github.com/gujinyue1010/JYVideoPlayerAnimation/blob/master/运行效果/123.png"/></div>
