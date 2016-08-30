//
//  ViewController.m
//  WZZDrawDemo
//
//  Created by 王泽众 on 16/8/29.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import "ViewController.h"
#import "WZZDrawView.h"

@interface ViewController ()
{
    NSTimer * timer;
    int width;
}
@property (weak, nonatomic) IBOutlet WZZDrawView *vvv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //屏幕宽
    width = (int)[UIScreen mainScreen].bounds.size.width;
    width = _vvv.frame.size.width;
    
    //自动刷新，画后自动刷新
//    _vvv.autoReload = YES;
}

//画线
- (void)ccc {
    //随机生成颜色
    CGFloat red = arc4random()%256/255.0f;
    CGFloat green = arc4random()%256/255.0f;
    CGFloat blue = arc4random()%256/255.0f;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    //画
    [_vvv drawLineWithPoint1:CGPointMake(arc4random()%width, arc4random()%width) point2:CGPointMake(arc4random()%width, arc4random()%width) color:color border:1];
    
    //刷新
    [_vvv reloadData];
}

//画矩形
- (IBAction)rect:(id)sender {
    //随机生成颜色
    CGFloat red = arc4random()%256/255.0f;
    CGFloat green = arc4random()%256/255.0f;
    CGFloat blue = arc4random()%256/255.0f;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    //画
    [_vvv drawARectWithFrame:CGRectMake(arc4random()%width, arc4random()%width, arc4random()%width, arc4random()%width) full:YES color:color border:1.0f];
    
    //刷新
    [_vvv reloadData];
}

//画圆
- (IBAction)circle:(id)sender {
    //随机生成颜色
    CGFloat red = arc4random()%256/255.0f;
    CGFloat green = arc4random()%256/255.0f;
    CGFloat blue = arc4random()%256/255.0f;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    //画
    [_vvv drawCircleWithPoint:CGPointMake(arc4random()%width, arc4random()%width) r:arc4random()%width/2 color:color border:5.0f isFull:NO];
    
    //刷新
    [_vvv reloadData];
}

//画扇形
- (IBAction)sector:(id)sender {
    //随机生成颜色
    CGFloat red = arc4random()%256/255.0f;
    CGFloat green = arc4random()%256/255.0f;
    CGFloat blue = arc4random()%256/255.0f;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    //画
    [_vvv drawSectorWithPoint:CGPointMake(arc4random()%width, arc4random()%width) r:arc4random()%width/4 startAngle:arc4random()%360 endAngle:arc4random()%360 isClockwise:YES color:color border:10.0f isFull:NO];
    
    //刷新
    [_vvv reloadData];
}

//椭圆
- (IBAction)normalCircle:(id)sender {
    //随机生成颜色
    CGFloat red = arc4random()%256/255.0f;
    CGFloat green = arc4random()%256/255.0f;
    CGFloat blue = arc4random()%256/255.0f;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    [_vvv drawNormalCircleWithFrame:CGRectMake(arc4random()%width, arc4random()%width, arc4random()%width, arc4random()%width) color:color border:1.0f isFull:YES];
    [_vvv reloadData];
}

//平方
- (IBAction)pow2:(id)sender {
    double y = 0;
    for (double x = -1000; x < 1000; x+=0.01) {
        y = pow(x, 2)/20;
        [_vvv drawPoint:CGPointMake(x+_vvv.frame.size.width/2, _vvv.frame.size.height - y) color:[UIColor blackColor] border:2.0f];
        [_vvv reloadData];
    }
    
}

//三次贝塞尔
- (IBAction)bezier3:(id)sender {
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(ppp) userInfo:nil repeats:YES];
}

//三次
- (void)ppp {
    [_vvv drawBezier2WithPoint1:CGPointMake(width/3, width/2) point2:CGPointMake(arc4random()%width, arc4random()%width) point3:CGPointMake(arc4random()%width, arc4random()%width) point4:CGPointMake(width/3*2, width/2)];
    [_vvv reloadData];
}

//二次贝塞尔
- (IBAction)bezier:(id)sender {
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(fff) userInfo:nil repeats:YES];
}

//二次
- (void)fff {
    [_vvv drawBezier2WithPoint1:CGPointMake(width/3, width/2) point2:CGPointMake(arc4random()%width, arc4random()%width) point3:CGPointMake(width/3*2, width/2)];
    [_vvv reloadData];
}

//画文字
- (IBAction)texttt:(id)sender {
    //随机生成颜色
    CGFloat red = arc4random()%256/255.0f;
    CGFloat green = arc4random()%256/255.0f;
    CGFloat blue = arc4random()%256/255.0f;
    
    //画
    [_vvv drawText:@"画蚊子即佛佛说地方" frame:CGRectMake(arc4random()%width, arc4random()%width, arc4random()%width, arc4random()%width) font:[UIFont systemFontOfSize:15] color:WZZRGBAMake(red, green, blue, 1.0f)];
    
    //刷新
    [_vvv reloadData];
}

- (IBAction)bbb:(id)sender {
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(ccc) userInfo:nil repeats:YES];
}

//画图片
- (IBAction)image:(id)sender {
    
    //画
    [_vvv drawImage:[UIImage imageNamed:@"ff"] frame:_vvv.bounds];
    
    //刷新
    [_vvv reloadData];
}

//清空
- (IBAction)clearrrr:(id)sender {
    
    //清空
    [_vvv clear];
    
    //刷新
    [_vvv reloadData];
    
    [timer invalidate];
}

@end
