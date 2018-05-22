//
//  WZZDrawView.m
//  WZZDrawDemo
//
//  Created by 王泽众 on 16/8/29.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import "WZZDrawView.h"
@import QuartzCore;
#define WZZDrawView_UseQuartz2d 0

@interface WZZDrawView ();

@end

@implementation WZZDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _modelsArr = [NSMutableArray array];
        _shapeLayerArr = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _modelsArr = [NSMutableArray array];
        _shapeLayerArr = [NSMutableArray array];
    }
    return self;
}

//刷新
- (void)reloadData {
    [self setNeedsDisplay];
}

//擦除
- (void)clear {
    [[self modelsArr] removeAllObjects];
    [self reloadData];
}

//画点
- (void)drawPoint:(CGPoint)point
            color:(UIColor *)color
           border:(CGFloat)border {
    WZZCircle * circle = [[WZZCircle alloc] init];
    circle.O = point;
    circle.r = border/2;
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Circle;
    model.full = YES;
    model.color = color;
    model.border = border;
    model.circle = circle;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画线
- (void)drawLineWithPoint1:(CGPoint)point1
                    point2:(CGPoint)point2
                     color:(UIColor *)color
                    border:(CGFloat)border {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Line;
    model.points = [NSMutableArray array];
    [model.points addObject:[NSValue valueWithCGPoint:point1]];
    [model.points addObject:[NSValue valueWithCGPoint:point2]];
    model.color = color;
    model.border = border;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画方形
- (void)drawARectWithFrame:(CGRect)frame
                     color:(UIColor *)color
                    border:(CGFloat)border
                      full:(BOOL)full {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Rect;
    model.frame = frame;
    model.full = full;
    model.color = color;
    model.border = border;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画图片
- (void)drawImage:(UIImage *)image
            frame:(CGRect)frame {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Image;
    model.frame = frame;
    model.image = image;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画圆
- (void)drawCircleWithPoint:(CGPoint)point
                          r:(CGFloat)r
                      color:(UIColor *)color
                     border:(CGFloat)border
                     isFull:(BOOL)full {
    WZZCircle * circle = [[WZZCircle alloc] init];
    circle.O = point;
    circle.r = r;
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Circle;
    model.full = full;
    model.color = color;
    model.border = border;
    model.circle = circle;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画扇形
- (void)drawSectorWithPoint:(CGPoint)point
                          r:(CGFloat)r
                 startAngle:(CGFloat)sAngle
                   endAngle:(CGFloat)eAngle
                      color:(UIColor *)color
                     border:(CGFloat)border
                isClockwise:(BOOL)isClock
                     isFull:(BOOL)full {
    WZZCircle * circle = [[WZZCircle alloc] init];
    circle.O = point;
    circle.r = r;
    circle.startAngle = sAngle;
    circle.endAngle = eAngle;
    circle.isClock = isClock;
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Sector;
    model.color = color;
    model.full = full;
    model.border = border;
    model.circle = circle;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画文字
- (void)drawText:(NSString *)text
           frame:(CGRect)frame
            font:(UIFont *)font
           color:(rgba)rgba {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Text;
    model.rgba = rgba;
    model.text = text;
    model.frame = frame;
    model.font = font;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画椭圆
- (void)drawNormalCircleWithFrame:(CGRect)frame
                            color:(UIColor *)color
                           border:(CGFloat)border
                           isFull:(BOOL)full {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_NormalCircle;
    model.frame = frame;
    model.full = full;
    model.border = border;
    model.color = color;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画二次贝塞尔曲线
- (void)drawBezier2WithPoint1:(CGPoint)point1
                       point2:(CGPoint)point2
                       point3:(CGPoint)point3
                        color:(UIColor *)color
                       border:(CGFloat)border {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Bezier2;
    model.border = border;
    model.color = color;
    model.points = [NSMutableArray array];
    [model.points addObject:[NSValue valueWithCGPoint:point1]];
    [model.points addObject:[NSValue valueWithCGPoint:point2]];
    [model.points addObject:[NSValue valueWithCGPoint:point3]];
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画三次贝塞尔曲线
- (void)drawBezier3WithPoint1:(CGPoint)point1
                       point2:(CGPoint)point2
                       point3:(CGPoint)point3
                       point4:(CGPoint)point4
                        color:(UIColor *)color
                       border:(CGFloat)border {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Bezier3;
    model.border = border;
    model.color = color;
    model.points = [NSMutableArray array];
    [model.points addObject:[NSValue valueWithCGPoint:point1]];
    [model.points addObject:[NSValue valueWithCGPoint:point2]];
    [model.points addObject:[NSValue valueWithCGPoint:point3]];
    [model.points addObject:[NSValue valueWithCGPoint:point4]];
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画多边形
- (void)drawPolygonWithPointArr:(NSArray <NSValue *>*)pointArr
                          color:(UIColor *)color
                         border:(CGFloat)border
                         isFull:(BOOL)isFull {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Polygon;
    model.full = isFull;
    model.border = border;
    model.color = color;
    model.points = [NSMutableArray arrayWithArray:pointArr];
    
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//绘画方法
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.modelsArr enumerateObjectsUsingBlock:^(WZZDrawModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBezierPath * currentPath = [UIBezierPath bezierPath];
        //框颜色和宽度
        if (model.color) {
            CGContextSetStrokeColorWithColor(context, model.color.CGColor);//线框颜色
            CGContextSetFillColorWithColor(context, model.color.CGColor);
        }
        if (model.border) {
            CGContextSetLineWidth(context, model.border);//线的宽度
        }
        switch (model.type) {
            case DRAWTYPE_Point:
            {
                //画点其实用的是画圆的方法，这个方法不会走
            }
                break;
            case DRAWTYPE_Line:
            {
                CGPoint point1 = [model.points[0] CGPointValue];
                CGPoint point2 = [model.points[1] CGPointValue];
                //画线
#if WZZDrawView_UseQuartz2d
                CGPoint a[2] = {point1, point2};
                CGContextAddLines(context, a, 2);//添加线
                CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
#else
                [currentPath moveToPoint:point1];
                [currentPath addLineToPoint:point2];
#endif
            }
                break;
            case DRAWTYPE_Rect:
            {
#if WZZDrawView_UseQuartz2d
                if (model.full) {
                    CGContextFillRect(context,model.frame);//填充框
                } else {
                    CGContextStrokeRect(context,model.frame);//画方框
                }
                //矩形
                if (model.color&&model.full) {
                    CGContextSetFillColorWithColor(context, model.color.CGColor);//填充颜色
                }
                CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
#else
                currentPath = [UIBezierPath bezierPathWithRect:model.frame];
#endif
            }
                break;
            case DRAWTYPE_Image:
            {
                
                /*图片*/
                [model.image drawInRect:model.frame];//在坐标中画出图片
//                CGContextDrawImage(context, model.frame, model.image.CGImage);//使用这个使图片上下颠倒了，参考http://blog.csdn.net/koupoo/article/details/8670024
//                 CGContextDrawTiledImage(context, CGRectMake(0, 0, 20, 20), model.image.CGImage);//平铺图
            }
                break;
            case DRAWTYPE_Circle:
            {
#if WZZDrawView_UseQuartz2d
                CGContextAddArc(context, model.circle.O.x, model.circle.O.y, model.circle.r,  0, 2*M_PI, 1);
                
                if (model.color&&model.full) {
                    CGContextSetFillColorWithColor(context, model.color.CGColor);//填充颜色
                    CGContextDrawPath(context, kCGPathFill); //填充路径
                } else if (model.color&&!model.full) {
                    CGContextDrawPath(context, kCGPathStroke); //绘制路径
                }
#else
                currentPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(model.circle.O.x-model.circle.r, model.circle.O.y-model.circle.r, model.circle.r*2, model.circle.r*2)];
#endif
            }
                break;
            case DRAWTYPE_Sector:
            {
#if WZZDrawView_UseQuartz2d
                if (model.full) {
                    CGContextMoveToPoint(context, model.circle.O.x, model.circle.O.y);
                }
                CGContextAddArc(context, model.circle.O.x, model.circle.O.y, model.circle.r,  model.circle.startAngle/180*M_PI, model.circle.endAngle/180*M_PI, model.circle.isClock);
                if (model.color&&model.full) {
                    CGContextSetFillColorWithColor(context, model.color.CGColor);//填充颜色
                    CGContextDrawPath(context, kCGPathFill); //填充路径
                } else if (model.color&&!model.full) {
                    CGContextDrawPath(context, kCGPathStroke); //绘制路径
                }
#else
                currentPath = [UIBezierPath bezierPathWithArcCenter:model.circle.O radius:model.circle.r startAngle:model.circle.startAngle endAngle:model.circle.endAngle clockwise:model.circle.isClock];
#endif
            }
                break;
            case DRAWTYPE_Text:
            {
                //                CGContextSetRGBFillColor(context, model.rgba.r, model.rgba.g, model.rgba.b, model.rgba.a);//设置填充颜色
                //                [model.text drawInRect:model.frame withFont:model.font];
                [model.text drawInRect:model.frame withAttributes:@{NSFontAttributeName:model.font, NSForegroundColorAttributeName:[UIColor colorWithRed:model.rgba.r green:model.rgba.g blue:model.rgba.b alpha:model.rgba.a]}];//直接使用attribute
            }
                break;
            case DRAWTYPE_Bezier2:
            {
                //二次曲线
                CGPoint point1 = [model.points[0] CGPointValue];
                CGPoint point2 = [model.points[1] CGPointValue];
                CGPoint point3 = [model.points[2] CGPointValue];
                
#if WZZDrawView_UseQuartz2d
                CGContextMoveToPoint(context, point1.x, point1.y);//设置Path的起点
                CGContextAddQuadCurveToPoint(context,point2.x, point2.y, point3.x, point3.y);//设置贝塞尔曲线的控制点坐标和终点坐标
                CGContextStrokePath(context);
#else
                [currentPath moveToPoint:point1];
                [currentPath addQuadCurveToPoint:point3 controlPoint:point2];
#endif
            }
                break;
            case DRAWTYPE_Bezier3:
            {
                //三次曲线函数
                CGPoint point1 = [model.points[0] CGPointValue];
                CGPoint point2 = [model.points[1] CGPointValue];
                CGPoint point3 = [model.points[2] CGPointValue];
                CGPoint point4 = [model.points[3] CGPointValue];
                
#if WZZDrawView_UseQuartz2d
                CGContextMoveToPoint(context, point1.x, point1.y);//设置Path的起点
                CGContextAddCurveToPoint(context, point2.x, point2.y, point3.x, point3.y, point4.x, point4.y);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
                CGContextStrokePath(context);
#else
                [currentPath moveToPoint:point1];
                [currentPath addCurveToPoint:point4 controlPoint1:point2 controlPoint2:point3];
#endif
            }
                break;
            case DRAWTYPE_NormalCircle:
            {
                //画椭圆
#if WZZDrawView_UseQuartz2d
                CGContextAddEllipseInRect(context, model.frame); //椭圆
                if (model.color&&model.full) {
                    CGContextSetFillColorWithColor(context, model.color.CGColor);//填充颜色
                    CGContextDrawPath(context, kCGPathFill); //填充路径
                } else if (model.color&&!model.full) {
                    CGContextDrawPath(context, kCGPathStroke); //绘制路径
                }
#else
                currentPath = [UIBezierPath bezierPathWithOvalInRect:model.frame];
#endif
            }
                break;
            case DRAWTYPE_Polygon:
            {
                //画多边形
                [model.points enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    CGPoint point = [obj CGPointValue];
                    if (idx == 0) {
                        [currentPath moveToPoint:point];
                    } else {
                        [currentPath addLineToPoint:point];
                    }
                }];
                [currentPath closePath];
            }
                break;
                
            default:
                break;
        }
        if (!model.border) {
            model.border = 1.0f;
        }
        currentPath.lineWidth = model.border;
        currentPath.lineCapStyle = kCGLineCapRound;//曲线重点样式
        currentPath.lineJoinStyle = kCGLineJoinMiter;//曲线连接点样式
        
        if (self.animation) {
            CAShapeLayer * shapeLayer = [CAShapeLayer layer];
            [self.layer addSublayer:shapeLayer];
            
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.strokeColor = [UIColor clearColor].CGColor;
            shapeLayer.lineWidth =  model.border;
            shapeLayer.lineCap = kCALineCapRound;
            shapeLayer.lineJoin = kCALineJoinRound;
            if (model.full) {
                shapeLayer.fillColor = model.color.CGColor;
            } else {
                shapeLayer.strokeColor = model.color.CGColor;
            }
            shapeLayer.path = currentPath.CGPath;
            
            
            // 创建Animation
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.fromValue = @(0.0);
            animation.toValue = @(1.0);
            shapeLayer.autoreverses = NO;
            animation.duration = 3.0;
            [shapeLayer addAnimation:animation forKey:nil];
        } else {
            //绘制
            if (model.full) {
                [currentPath fill];
            } else {
                [currentPath stroke];
            }
        }
    }];
}

@end

//快速创建RGBA
rgba WZZRGBAMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
    rgba rrr;
    rrr.r = r;
    rrr.g = g;
    rrr.b = b;
    rrr.a = a;
    return rrr;
}

@implementation WZZDrawModel
@end
@implementation WZZCircle
@end
