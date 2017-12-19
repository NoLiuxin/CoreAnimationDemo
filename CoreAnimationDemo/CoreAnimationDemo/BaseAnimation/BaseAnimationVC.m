//
//  BaseAnimationVC.m
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/14.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "BaseAnimationVC.h"

@interface BaseAnimationVC ()

@property (nonatomic, strong) NSArray *operateTitleArray;
@property (nonatomic, strong) UIView *testView;
@end

@implementation BaseAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"基础动画";
    [self initView];
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT/2-100,100 ,100 )];
    _testView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_testView];
}

-(void)initView{
    
    NSUInteger row = self.operateTitleArray.count%4==0 ? self.operateTitleArray.count/4 : self.operateTitleArray.count/4+1;
    UIView *operateView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(row*50+20)-34, SCREEN_WIDTH, row*50+20)];
    [self.view addSubview:operateView];
    for (int i=0; i<self.operateTitleArray.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:[self rectForBtnAtIndex:i totalNum:self.operateTitleArray.count]];
        btn.backgroundColor = [UIColor darkGrayColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:self.operateTitleArray[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [operateView addSubview:btn];
    }
}
- (void)clickBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self opacityAniamtion];
            break;
        case 2:
            [self scaleAnimation];
            break;
        case 3:
            [self rotateAnimation];
            break;
        case 4:
            [self backgroundAnimation];
            break;
            
        default:
            break;
    }
}
/**
 *  位移动画
 */
- (void)positionAnimation{
    //使用CABasicAnimation创建基础动画
    //图层的position属性是一个CGPoint的值，它指定图层相当于它父图层的位置，该值基于父图层的坐标系。
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //fromValue ： keyPath对应的初始值
    basicAnimation.fromValue = [NSValue valueWithCGPoint:_testView.center];
    
    //toValue ： keyPath对应的结束值
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, _testView.center.y)];
    
    //duration : 动画的持续时间
    basicAnimation.duration = 1.0f;
    
    //如果fillMode=kCAFillModeForwards并且removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    //    basicAnimation.fillMode = kCAFillModeForwards;
    //    basicAnimation.removedOnCompletion = NO;
    
    /*timingFunction : 控制动画的显示节奏系统提供五种值选择，分别是：
     *kCAMediaTimingFunctionLinear 线性动画
     *kCAMediaTimingFunctionEaseIn 先慢后快
     *kCAMediaTimingFunctionEaseOut 先快后慢
     *kCAMediaTimingFunctionEaseInEaseOut 先慢后快再慢
     *kCAMediaTimingFunctionDefault 默认，也属于中间比较快
     */
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_testView.layer addAnimation:basicAnimation forKey:@"positionAnimation"];
    
}
/**
 *  透明度动画
 */
- (void)opacityAniamtion{
    //CALayer中opacity是一个浮点值，取值范围0~1.0,表示从完全透明到完全不透明。
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    basicAnimation.toValue = [NSNumber numberWithFloat:0.2f];
    basicAnimation.duration = 1.0f;
    [_testView.layer addAnimation:basicAnimation forKey:@"opacityAniamtion"];
}
/**
 *  缩放动画
 */
- (void)scaleAnimation{
    
    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"bounds"];
    //    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    //    anima.duration = 1.0f;
    //    [_testView.layer addAnimation:anima forKey:@"scaleAnimation"];
    
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
    basicAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    basicAnimation.duration = 1.0f;
    [_testView.layer addAnimation:basicAnimation forKey:@"scaleAnimation"];
    
    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    //    anima.toValue = [NSNumber numberWithFloat:0.2f];
    //    anima.duration = 1.0f;
    //    [_testView.layer addAnimation:anima forKey:@"scaleAnimation"];
}
/**
 *  旋转动画
 */
-(void)rotateAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima.toValue = [NSNumber numberWithFloat:M_PI];
    anima.duration = 1.0f;
    [_testView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    //    //valueWithCATransform3D作用与layer
//    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
//    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];//绕着矢量（x,y,z）旋转
//    anima.duration = 1.0f;
//    //anima.repeatCount = MAXFLOAT;
//    [_testView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    //    //CGAffineTransform作用与View
    //    _testView.transform = CGAffineTransformMakeRotation(0);
    //    [UIView animateWithDuration:1.0f animations:^{
    //        _testView.transform = CGAffineTransformMakeRotation(M_PI);
    //    } completion:^(BOOL finished) {
    //
    //    }];
}
- (void)backgroundAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue =(id) [UIColor greenColor].CGColor;
    anima.duration = 1.0f;
    [_testView.layer addAnimation:anima forKey:@"backgroundAnimation"];
}
- (NSArray *)operateTitleArray{
    if (_operateTitleArray==nil) {
        _operateTitleArray = [NSArray arrayWithObjects:@"位移",@"透明度",@"缩放",@"旋转",@"背景色", nil];
    }
    return _operateTitleArray;
}
/**
 *  获得每个操作按钮的frame
 *
 *  @param index    当前按钮的位置,从0开始
 *  @param totleNum 所有按钮的总数
 *
 *  @return 按钮的frame
 */
-(CGRect)rectForBtnAtIndex : (NSUInteger)index totalNum : (NSUInteger)totleNum{
    //每一行最多显示4个
    NSUInteger maxColumnNum = 4;
    //每个按钮的列间距
    CGFloat columnMargin = 20;
    //每个按钮的行间距
    CGFloat rowMargin = 20;
    //行数
    // NSUInteger row = totleNum/maxColumnNum;
    //每个按钮的宽度
    CGFloat width = (SCREEN_WIDTH - columnMargin*5)/4;
    //每个按钮的高度
    CGFloat height = 30;
    
    //每个按钮的偏移
    CGFloat offsetX = columnMargin+(index%maxColumnNum)*(width+columnMargin);
    CGFloat offsetY = rowMargin+(index/maxColumnNum)*(height+rowMargin);
    
    return CGRectMake(offsetX, offsetY, width, height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

