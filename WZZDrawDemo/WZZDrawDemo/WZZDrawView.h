//
//  WZZDrawView.h
//  WZZDrawDemo
//
//  Created by 王泽众 on 16/8/29.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZZDrawModel;
@class WZZCircle;

typedef enum {
    DRAWTYPE_Point,//点
    DRAWTYPE_Line,//线
    DRAWTYPE_Rect,//矩形
    DRAWTYPE_Image,//图片
    DRAWTYPE_Circle,//原型
    DRAWTYPE_Sector,//扇形
    DRAWTYPE_Text,//文字
    DRAWTYPE_Bezier2,//2次被塞尔
    DRAWTYPE_Bezier3,//3次被塞尔
    DRAWTYPE_NormalCircle,//椭圆
    DRAWTYPE_Polygon//多边形
}DRAWTYPE;//画类型

typedef struct rgba {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
}rgba;//rgba结构体

/**
 快速创建rgba结构体
 */
rgba WZZRGBAMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a);

@interface WZZDrawView : UIView

/**
 使用动画，未优化，有问题
 */
@property (nonatomic, assign) BOOL animation;

/**
 形状图层
 */
@property (nonatomic, strong) NSMutableArray <CAShapeLayer *>* shapeLayerArr;

/**
 自动刷新
 */
@property (assign, nonatomic) BOOL autoReload;

/**
 存放画线数据的数组
 */
@property (strong, nonatomic, readonly) NSMutableArray <WZZDrawModel *>* modelsArr;

/**
 刷新view
 */
- (void)reloadData;

/**
 擦除
 */
- (void)clear;

/**
 画点

 @param point 点坐标
 @param color 颜色
 @param border 直径
 */
- (void)drawPoint:(CGPoint)point
            color:(UIColor *)color
           border:(CGFloat)border;

/**
 画线

 @param point1 点1
 @param point2 点2
 @param color 颜色
 @param border 粗细
 */
- (void)drawLineWithPoint1:(CGPoint)point1 point2:(CGPoint)point2 color:(UIColor *)color border:(CGFloat)border;

/**
 画矩形

 @param frame 坐标
 @param color 颜色
 @param border 边粗细
 @param full 是否填充
 */
- (void)drawARectWithFrame:(CGRect)frame
                     color:(UIColor *)color
                    border:(CGFloat)border
                      full:(BOOL)full;

/**
 画原型

 @param point 原点
 @param r 半径
 @param color 颜色
 @param border 边粗细
 @param full 是否填充
 */
- (void)drawCircleWithPoint:(CGPoint)point
                          r:(CGFloat)r
                      color:(UIColor *)color
                     border:(CGFloat)border
                     isFull:(BOOL)full;

/**
 画扇形

 @param point 点
 @param r 半径
 @param sAngle 开始角度(角度不是弧度)
 @param eAngle 结束角度
 @param color 颜色
 @param border 边粗细
 @param isClock 是否顺时针
 @param full 是否填充
 */
- (void)drawSectorWithPoint:(CGPoint)point
                          r:(CGFloat)r
                 startAngle:(CGFloat)sAngle
                   endAngle:(CGFloat)eAngle
                      color:(UIColor *)color
                     border:(CGFloat)border
                isClockwise:(BOOL)isClock
                     isFull:(BOOL)full;

/**
 画椭圆

 @param frame 坐标
 @param color 颜色
 @param border 边粗细
 @param full 是否填充
 */
- (void)drawNormalCircleWithFrame:(CGRect)frame
                            color:(UIColor *)color
                           border:(CGFloat)border
                           isFull:(BOOL)full;

/**
 画图片

 @param image 图片
 @param frame 坐标
 */
- (void)drawImage:(UIImage *)image
            frame:(CGRect)frame;

/**
 画文字

 @param text 文字
 @param frame 坐标
 @param font 字体
 @param rgba 颜色
 */
- (void)drawText:(NSString *)text
           frame:(CGRect)frame
            font:(UIFont *)font
           color:(rgba)rgba;

/**
 画二次被塞尔曲线

 @param point1 点1
 @param point2 控制点
 @param point3 点2
 */
- (void)drawBezier2WithPoint1:(CGPoint)point1
                       point2:(CGPoint)point2
                       point3:(CGPoint)point3
                        color:(UIColor *)color
                       border:(CGFloat)border;

/**
 画三次贝塞尔曲线

 @param point1 点1
 @param point2 控制点1
 @param point3 控制点2
 @param point4 点2
 */
- (void)drawBezier3WithPoint1:(CGPoint)point1
                       point2:(CGPoint)point2
                       point3:(CGPoint)point3
                       point4:(CGPoint)point4
                        color:(UIColor *)color
                       border:(CGFloat)border;

/**
 画多边形

 @param pointArr 点数组
 @param color 颜色
 @param border 边宽
 @param isFull 是否填充
 */
- (void)drawPolygonWithPointArr:(NSArray <NSValue *>*)pointArr
                          color:(UIColor *)color
                         border:(CGFloat)border
                         isFull:(BOOL)isFull;

@end


//画模型
@interface WZZDrawModel : NSObject

@property (nonatomic, strong, readonly) UIBezierPath * bezierPath;
@property (assign, nonatomic) DRAWTYPE type;
@property (nonatomic, strong) NSMutableArray <NSValue *>* points;
@property (assign, nonatomic) CGRect frame;
@property (assign, nonatomic) BOOL full;
@property (strong, nonatomic) UIColor * color;
@property (assign, nonatomic) CGFloat border;
@property (strong, nonatomic) UIImage * image;
@property (strong, nonatomic) WZZCircle * circle;
@property (strong, nonatomic) NSString * text;
/**
 只能设置文字颜色
 */
@property (assign, nonatomic) rgba rgba;
@property (strong, nonatomic) UIFont * font;

/**
 设置path
 */
- (void)_setBezierPath:(UIBezierPath *)path;

@end


//圆
@interface WZZCircle : NSObject

@property (assign, nonatomic) CGPoint O;
@property (assign, nonatomic) CGFloat r;
@property (assign, nonatomic) CGFloat startAngle;
@property (assign, nonatomic) CGFloat endAngle;
@property (assign, nonatomic) BOOL isClock;

@end
