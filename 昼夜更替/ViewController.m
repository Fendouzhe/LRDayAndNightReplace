//
//  ViewController.m
//  昼夜更替
//
//  Created by Lurong Lei on 15/4/2.
//  Copyright (c)  All rights reserved.
//

#import "ViewController.h"
#import "LRDayNightView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet LRDayNightView *desView;
@property (nonatomic, assign) CGFloat xi;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //总体思路，颜色渐变，位子移动，夜晚白天替换
    /*
        颜色渐变：通过颜色数组根据RGB数字储存大量颜色相近的颜色，
                通过每次定时器移除第一个 然后添加到最后一个，使内部颜色数组整体往前移动一位
                根据数组颜色移动实现颜色渐变动画
        太阳位置移动：根据抛物线原理，通过改变X的位置，算出对应Y的位子，然后每次定时器循环
                    改变X的位置就可以改变太阳位置
        昼夜白天替换：根据循环改变背景颜色（黑色的透明度）实现夜晚和白天的渐变
        
        根据夜晚的透明度情况判断是白天还是黑夜，然后改变实际显示的太阳的内部的颜色是红色（太阳）还是白黄（月亮）
     */
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.desView.colors = [NSMutableArray array];
    self.desView.colorb = [NSMutableArray array];
    self.desView.colorm = [NSMutableArray array];
    // 背景alpha
    self.desView.ba = 1;
    self.xi = - 1 / self.view.frame.size.width;
    self.desView.rx = self.view.frame.size.width / 2;
    // RGB区间
    NSInteger indexRb = 100;
    NSInteger indexS = 0;
    // 太阳颜色
    // 红 - 黄
    for (NSInteger i = indexS; i < indexRb; i++) {
        UIColor *color = [UIColor colorWithRed:1 green:(i/255.0) blue:0 alpha:1];
        [self.desView.colors addObject:color];
    }
    // 黄 - 红
    for (NSInteger i = indexRb; i > indexS; i--) {
        UIColor *color = [UIColor colorWithRed:1 green:(i/255.0) blue:0 alpha:1];
        [self.desView.colors addObject:color];
    }
    indexS = 150;
    indexRb = 256;
    // 海水颜色
    // 蓝--青
    for (NSInteger i = indexS; i < indexRb; i++) {
        UIColor *color = [UIColor colorWithRed:0 green:(i/255.0) blue:1 alpha:0.5];
        [self.desView.colorb addObject:color];
    }
    // 青--蓝
    for (NSInteger i = indexRb; i > indexS; i--) {
        UIColor *color = [UIColor colorWithRed:0 green:(i/255.0) blue:1 alpha:0.5];
        [self.desView.colorb addObject:color];
    }
    
    
    indexS = 150;
    // 月亮颜色
    // 白 - 黄
    for (NSInteger i = indexS; i < indexRb; i++) {
        UIColor *color = [UIColor colorWithRed:1 green:1 blue:(i/255.0) alpha:1];
        [self.desView.colorm addObject:color];
    }
    // 黄 - 白
    for (NSInteger i = indexRb; i > indexS; i--) {
        UIColor *color = [UIColor colorWithRed:1 green:1 blue:(i/255.0) alpha:1];
        [self.desView.colorm addObject:color];
    }
    
    // 定时器
    CADisplayLink *dis = [CADisplayLink displayLinkWithTarget:self selector:@selector(change)];
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(change) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [dis addToRunLoop:runLoop forMode:NSRunLoopCommonModes];
}


-(void)change{
    // 太阳颜色
    UIColor *colors = [self.desView.colorsun firstObject];
    // 替换数组位置改变内部数组颜色往后移动
    [self.desView.colorsun removeObjectAtIndex:0];
    [self.desView.colorsun addObject:colors];
    // 海水颜色
    UIColor *colorb = [self.desView.colorb firstObject];
    // 替换数组位置改变内部数组颜色往后移动
    [self.desView.colorb removeObjectAtIndex:0];
    [self.desView.colorb addObject:colorb];
    // 根据背景颜色判断是白天还是黑夜
    if (self.desView.ba <= 0.5) {
        // 背景颜色偏白得时候开始升起太阳
        // 将太阳显示颜色改成红色数组
        self.desView.colorsun = self.desView.colors;
    } else {
        // 背景颜色偏白得时候开始升起太阳
        // 将太阳显示颜色改成白色数组
        self.desView.colorsun = self.desView.colorm;
    }
    
    // 太阳跑到最后面的时候跑回来
    if (self.desView.rx >= self.view.frame.size.width) {
        self.desView.rx = 0;
    }
    // x坐标往前移动
    self.desView.rx += 1;
    
    // 背景颜色的透明度改变
    if (self.desView.ba <= 0) {
        // 配合太阳的速度，故根据宽度平均改变透明度
        self.xi = 1 / self.view.frame.size.width;
    } else if (self.desView.ba >= 1){
        // 循环
        self.xi = - 1 / self.view.frame.size.width;
    }
    // 最终根据上面判断的正负赋值
    self.desView.ba += self.xi;
    // 刷新绘图
    [self.desView setNeedsDisplay];
}
@end

