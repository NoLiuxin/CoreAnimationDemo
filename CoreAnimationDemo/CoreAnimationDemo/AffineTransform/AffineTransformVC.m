//
//  AffineTransformVC.m
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/14.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "AffineTransformVC.h"

@interface AffineTransformVC ()

@property (nonatomic, strong) UIView *demoView;
@property (nonatomic, strong) NSArray *operateTitleArray;
@end

@implementation AffineTransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"仿射变换";
    [self initView];
    [self.view addSubview:self.demoView];
}
//UI开发技巧，重写setter方法和Code Block Evaluation C Extension语法
- (UIView *)demoView{
    if (!_demoView) {
        _demoView = ({
            UIView *demoView = [[UIView alloc] initWithFrame:({
                CGRect rect = CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100,100 ,100 );
                rect;
            })];
            demoView.backgroundColor = [UIColor redColor];
            UILabel *testLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            testLab.backgroundColor = [UIColor blackColor];
            testLab.text = @"LL";
            testLab.textColor = [UIColor whiteColor];
            [demoView addSubview:testLab];
            demoView;
        });
    }
    return _demoView;
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
            [self scaleAnimation];
            break;
        case 2:
            [self rotateAnimation];
            break;
        case 3:
            [self combinationAnimation];
            break;
        case 4:
            [self invertAnimation];
            break;
        default:
            break;
    }
}
-(void)positionAnimation{
    //CGAffineTransformIdentity是系统提供的一个常量，/* The identity transform: [ 1 0 0 1 0 0 ]. */（和原图一样的transform）;特殊地,transform属性默认值为CGAffineTransformIdentity,可以在形变之后设置该值以还原到最初状态
    
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        //CGAffineTransformMakeTranslation实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位
        // 格式 CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
        //注: 当tx为正值时,会向x轴正方向平移,反之,则向x轴负方向平移;当ty为正值时,会向y轴正方向平移,反之,则向y轴负方向平移
        _demoView.transform = CGAffineTransformMakeTranslation(100, 100);
    }];
}

-(void)scaleAnimation{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        //CGAffineTransformMakeScale实现以初始位置为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍
        //// 格式CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
        //注: 当sx为正值时,会在x轴方向上缩放x倍,反之,则在缩放的基础上沿着竖直线翻转;当sy为正值时,会在y轴方向上缩放y倍,反之,则在缩放的基础上沿着水平线翻转
        _demoView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

-(void)rotateAnimation{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        //CGAffineTransformMakeRotation实现以初始位置为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)
        // 格式 CGAffineTransformMakeRotation(CGFloat angle)
        //当angle为正值时,逆时针旋转坐标系统,反之顺时针旋转坐标系统
        //逆时针旋转坐标系统的表现形式为对控件进行顺时针旋转
        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

-(void)combinationAnimation{
    //仿射变换的组合使用
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        
        //CGAffineTransformScale实现以一个已经存在的形变为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        
        //CGAffineTransformTranslate实现以一个已经存在的形变为基准,在x轴方向上平移x单位,在y轴方向上平移y单位
        CGAffineTransform transform3 = CGAffineTransformTranslate(transform2, 100, 100);
        //CGAffineTransformRotate实现以一个已经存在的形变为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)
        _demoView.transform = CGAffineTransformRotate(transform3, M_PI*0.25);
    }];
}

-(void)invertAnimation{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        //矩阵反转
        _demoView.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(-2, -2));
    }];
}

- (NSArray *)operateTitleArray{
    if (_operateTitleArray==nil) {
        _operateTitleArray = [NSArray arrayWithObjects:@"位移",@"缩放",@"旋转",@"组合",@"反转",nil];
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
