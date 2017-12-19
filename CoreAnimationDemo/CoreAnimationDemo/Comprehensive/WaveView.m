//
//  WaveView.m
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/15.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "WaveView.h"

@implementation WaveView
{
    CADisplayLink *_link;
    CGFloat _offset;
    CAShapeLayer *_layer;
    CAShapeLayer *_layer2;
    CGFloat _waveWidth;
    CGFloat _h;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initLayerAndProperty];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initLayerAndProperty];
    }
    return self;
}
- (void)initLayerAndProperty
{
    _waveWidth = self.frame.size.width;
    _h = 30;
    _layer = [CAShapeLayer layer];
    //透明度
    _layer.opacity = 0.5;
    _layer.frame = self.bounds;
    
    _layer2 = [CAShapeLayer layer];
    _layer2.frame = self.bounds;
    _layer2.opacity = 0.5;
    
    [self.layer addSublayer:_layer];
    [self.layer addSublayer:_layer2];
}
- (void)wave
{
    //开始
    //CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAni)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)stop
{
    //结束
    [_link invalidate];
    _link = nil;
}
- (void)doAni
{
    /*正弦型函数解析式：y=Asin（ωx+φ）+h
     各常数值对函数图像的影响：
     φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减）
     ω：决定周期（最小正周期T=2π/|ω|）
     A：决定峰值（即纵向拉伸压缩的倍数）
     h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）*/
    
    /*
     1、我们的容器高度是100，我希望波的整体高度，固定在容器的一个相对的位置。
     这里设置h ＝ 30；也就是说，当Asin（ωx+φ）计算为0的时候，这个时候y的位置是30；
     2、决定波起伏的高度，我们设置波峰是5，波峰越大，曲线越陡峭；
     3、决定波的宽度和周期，比如，我们可以看到上面的例子中是一个周期的波曲线，
     一个波峰、一个波谷，如果我们想在0到2π这个距离显示2个完整的波曲线，那么周期就是π。
     我们这里设置波的宽度是容器的宽度_waveWidth，希望能展示2.5个波曲线，周期就是_waveWidth／2.5。
     那么ω常量就可以这样计算：2.5*M_PI/_waveWidth。
     4、一共有两个波曲线，形成一个落差，也就是设置不同的φ（初相位），我们这里设置落差是M_PI/4。
     5、时间和初相位的函数关系：我们在计时器的函数中一直调用_offset += _speed;
     可以看到，如果我们设置波的速度speed越大，波的震动将会越快。
     
     最后我们的公式如下：
     CGFloat y = _waveHeight*sinf(2.5*M_PI*i/_waveWidth + 3*_offset*M_PI/_waveWidth + M_PI/4) + _h;
     这些参数都可以自己调整，得到一个符合要求的效果。
     */
    
    _offset += _speed;
    
    //申请路径
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGFloat startY = _waveHeight*sinf(_offset*M_PI/_waveWidth);
    
    //设置起点坐标
    CGPathMoveToPoint(pathRef, NULL, 0, startY);
    
    for (CGFloat i = 0.0; i < _waveWidth; i ++) {
        CGFloat y = 1.1*_waveHeight*sinf(2.5*M_PI*i/_waveWidth + _offset*M_PI/_waveWidth) + _h;
        //设置线路径
        CGPathAddLineToPoint(pathRef, NULL, i, y);
    }
    //设置线路径
    CGPathAddLineToPoint(pathRef, NULL, _waveWidth, 40);
    //设置线路径
    CGPathAddLineToPoint(pathRef, NULL, 0, 40);
    //闭合当前点 和 起点
    CGPathCloseSubpath(pathRef);
    
    _layer.path = pathRef;
    _layer.fillColor = [UIColor purpleColor].CGColor;
    CGPathRelease(pathRef);
    
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    CGFloat startY2 = _waveHeight*sinf(_offset*M_PI/_waveWidth + M_PI/4);
    CGPathMoveToPoint(pathRef2, NULL, 0, startY2);
    for (CGFloat i = 0.0; i < _waveWidth; i ++) {
        CGFloat y = _waveHeight*sinf(2.5*M_PI*i/_waveWidth + 3*_offset*M_PI/_waveWidth + M_PI/4) + _h;
        CGPathAddLineToPoint(pathRef2, NULL, i, y);
    }
    CGPathAddLineToPoint(pathRef2, NULL, _waveWidth, 40);
    CGPathAddLineToPoint(pathRef2, NULL, 0, 40);
    CGPathCloseSubpath(pathRef2);
    
    _layer2.path = pathRef2;
    _layer2.fillColor = [UIColor purpleColor].CGColor;
    CGPathRelease(pathRef2);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
