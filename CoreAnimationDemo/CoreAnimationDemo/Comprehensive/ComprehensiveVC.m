//
//  ComprehensiveVC.m
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/14.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "ComprehensiveVC.h"
#import "DCPathButton.h"
#import "DWBubbleMenuButton.h"
#import "MCFireworksButton.h"
#import "WaveAnimationVC.h"
#import "CustomTransitionVC.h"

@interface ComprehensiveVC ()<DCPathButtonDelegate>

@property (nonatomic , strong) NSArray *operateTitleArray;

@property (nonatomic , strong) DCPathButton *pathAnimationView;

@property (nonatomic , strong) DWBubbleMenuButton *dingdingAnimationMenu;

@property (nonatomic , strong) MCFireworksButton *goodBtn;

@property (nonatomic , assign) BOOL selected;
@end

@implementation ComprehensiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"综合案例";
    [self initView];
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
            [self pathAnimation];
            break;
        case 1:
            [self dingdingAnimation];
            break;
        case 2:
            [self clickGoodAnimation];
            break;
        case 3:{
            WaveAnimationVC *waveAnimationVC = [[WaveAnimationVC alloc] init];
            [self.navigationController pushViewController:waveAnimationVC animated:YES];
        }
            break;
        case 4:{
            CustomTransitionVC *customTransitionVC = [[CustomTransitionVC alloc] init];
            [self.navigationController pushViewController:customTransitionVC animated:YES];
        }
            break;
        default:
            break;
    }
}
/**
 *  仿Path 菜单动画
 */
-(void)pathAnimation{
    if (_dingdingAnimationMenu) {
        _dingdingAnimationMenu.hidden = YES;
    }
    if (_goodBtn) {
        _goodBtn.hidden = YES;
    }
    if (!_pathAnimationView) {
        [self ConfigureDCPathButton];
    }else{
        _pathAnimationView.hidden = NO;
    }
}
- (void)ConfigureDCPathButton
{
    // Configure center button
    //
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                           hilightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    _pathAnimationView = dcPathButton;
    
    dcPathButton.delegate = self;
    
    // Configure item buttons
    //
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_5 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    //
    [dcPathButton addPathItems:@[itemButton_1, itemButton_2, itemButton_3, itemButton_4, itemButton_5]];
    
    [self.view addSubview:dcPathButton];
    
}
#pragma mark - DCPathButton Delegate

- (void)itemButtonTappedAtIndex:(NSUInteger)index
{
    NSLog(@"You tap at index : %ld", index);
}
/**
 *  仿造钉钉菜单动画
 */
-(void)dingdingAnimation{
    if (_pathAnimationView) {
        _pathAnimationView.hidden = YES;
    }
    if (_goodBtn) {
        _goodBtn.hidden = YES;
    }
    if (!_dingdingAnimationMenu) {
        UILabel *homeLabel = [self createHomeButtonView];
        
        DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width - 20.f,self.view.frame.size.height - homeLabel.frame.size.height - 20.f-150,homeLabel.frame.size.width,homeLabel.frame.size.height)expansionDirection:DirectionUp];
        upMenuView.homeButtonView = homeLabel;
        [upMenuView addButtons:[self createDemoButtonArray]];
        
        _dingdingAnimationMenu = upMenuView;
        
        [self.view addSubview:upMenuView];
    }else{
        _dingdingAnimationMenu.hidden = NO;
    }
}

- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    
    label.text = @"Tap";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = YES;
    
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *title in @[@"A", @"B", @"C", @"D", @"E", @"F"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(dwBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

- (void)dwBtnClick:(UIButton *)sender {
    NSLog(@"DWButton tapped, tag: %ld", (long)sender.tag);
}
/**
 *  仿造facebook，点赞动画
 */
-(void)clickGoodAnimation{
    if (_pathAnimationView) {
        _pathAnimationView.hidden = YES;
    }
    if (_dingdingAnimationMenu) {
        _dingdingAnimationMenu.hidden = YES;
    }
    if (!_goodBtn) {
        _goodBtn = [[MCFireworksButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-25, 50, 50)];
        _goodBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
        _goodBtn.particleScale = 0.05;
        _goodBtn.particleScaleRange = 0.02;
        [_goodBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
        
        [_goodBtn addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_goodBtn];
    }else{
        _goodBtn.hidden = NO;
    }
}

- (void)handleButtonPress:(id)sender {
    _selected = !_selected;
    if(_selected) {
        [_goodBtn popOutsideWithDuration:0.5];
        [_goodBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        [_goodBtn animate];
    }else {
        [_goodBtn popInsideWithDuration:0.4];
        [_goodBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
}
- (NSArray *)operateTitleArray{
    if (_operateTitleArray==nil) {
        _operateTitleArray = [NSArray arrayWithObjects:@"Path",@"钉钉",@"点赞",@"波浪",@"转场", nil];
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
