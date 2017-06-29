//
//  DrawView.m
//  TestWeb
//
//  Created by Zhangqi on 2017/6/28.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "DrawView.h"
#import "MTDefine.h"
#define ABS_FLOAT_0 0.0001

@interface DrawView ()
{
    CGFloat r;
    UIColor *normalLineColor; // 正常时间线的颜色
    UIColor *noClipLineColor; // 不能裁剪时间显得颜色
    BOOL isClip;  //
    UIColor *roundColor;
    NSInteger num; // 记录选中的索引
    CGFloat maxAngle; //
    CGFloat space; // 图片距离上下左右的边距
}

/**
 圆的中心店
 */
@property (nonatomic, assign) CGPoint p1;
@property (nonatomic, assign) CGPoint p2;
@property (nonatomic, assign) CGPoint p3;
@property (nonatomic, assign) CGPoint p4;
@property (nonatomic, assign) UIImageView *imgView;


@end

@implementation DrawView

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        r = 20;
        num = -1;
        maxAngle = 140;
        isClip = YES;
        space = 20;
        normalLineColor = [UIColor greenColor];
        noClipLineColor = [UIColor redColor];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x + space, self.frame.origin.y + space, self.frame.size.width - space * 2, self.frame.size.height - space * 2)];
        imgView.userInteractionEnabled = YES;
        imgView.image = [UIImage imageNamed:@"timg.jpeg"];
        [[self topViewController].view addSubview:imgView];
        self.imgView = imgView;
        
        _p1 = CGPointMake(space, space);
        _p2 = CGPointMake(self.imgView.frame.size.width + space, space);
        _p3 = CGPointMake(self.imgView.frame.size.width + space, self.imgView.frame.size.height + space);
        _p4 = CGPointMake(space, self.imgView.frame.size.height + space);
        
    }
    return self;
}






- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    [self addScreenFillRect:context rect:self.bounds];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, space, space);
    CGPathAddLineToPoint(path, nil, _p1.x, _p1.y);
    CGPathAddLineToPoint(path, nil, _p4.x, _p4.y);
    CGPathAddLineToPoint(path, nil,  space, self.imgView.frame.size.height + space);
    CGPathAddLineToPoint(path, nil, space, space);
    
    CGPathMoveToPoint(path, nil, space, space);
    CGPathAddLineToPoint(path, nil, _p1.x, _p1.y);
    CGPathAddLineToPoint(path, nil, _p2.x, _p2.y);
    CGPathAddLineToPoint(path, nil,  self.imgView.frame.size.width + space, space);
    CGPathAddLineToPoint(path, nil, space, space);
    
    CGPathMoveToPoint(path, nil, self.imgView.frame.size.width + space, space);
    CGPathAddLineToPoint(path, nil, _p2.x, _p2.y);
    CGPathAddLineToPoint(path, nil, _p3.x, _p3.y);
    CGPathAddLineToPoint(path, nil,  self.imgView.frame.size.width + space, self.imgView.frame.size.height + space);
    CGPathAddLineToPoint(path, nil, self.imgView.frame.size.width + space, space);
    
    CGPathMoveToPoint(path, nil, space, self.imgView.frame.size.height + space);
    CGPathAddLineToPoint(path, nil, _p4.x, _p4.y);
    CGPathAddLineToPoint(path, nil, _p3.x, _p3.y);
    CGPathAddLineToPoint(path, nil,  self.imgView.frame.size.width + space, self.imgView.frame.size.height + space);
    CGPathAddLineToPoint(path, nil, space, self.imgView.frame.size.height + space);
    
    
    
    //    CGPathMoveToPoint(path, nil, _p1.x, _p1.y);
    //    CGPathAddLineToPoint(path, nil, _p2.x, _p2.y);
    //    CGPathAddLineToPoint(path, nil, _p3.x, _p3.y);
    //    CGPathAddLineToPoint(path, nil, _p4.x, _p4.y);
    //    CGPathAddLineToPoint(path, nil, _p1.x, _p1.y);
    
    [self addWhiteRect:context path:path];
    [self drawLine:context];
    [self drawround:context];
    
    
}


- (void)drawLine:(CGContextRef)context {
    
    CGContextMoveToPoint(context, _p1.x, _p1.y);
    CGContextAddLineToPoint(context, _p2.x, _p2.y);
    CGContextAddLineToPoint(context, _p3.x, _p3.y);
    CGContextAddLineToPoint(context, _p4.x, _p4.y);
    CGContextAddLineToPoint(context, _p1.x, _p1.y);
    
    CGContextSetLineWidth(context, 2);
    if (isClip) {
        CGContextSetStrokeColorWithColor(context, normalLineColor.CGColor);
    } else {
        CGContextSetStrokeColorWithColor(context, noClipLineColor.CGColor);
        
    }
    CGContextStrokePath(context);
    
}


- (void)drawround:(CGContextRef)context {
    CGContextAddEllipseInRect(context, CGRectMake(_p1.x - r, _p1.y - r, r * 2, r * 2));
    CGContextAddEllipseInRect(context, CGRectMake(_p2.x - r, _p2.y - r, r * 2, r * 2));
    CGContextAddEllipseInRect(context, CGRectMake(_p3.x - r, _p3.y - r, r * 2, r * 2));
    CGContextAddEllipseInRect(context, CGRectMake(_p4.x - r, _p4.y - r, r * 2, r * 2));
    CGContextSetLineWidth(context, 1);
    //    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    //    CGContextStrokePath(context);
    CGContextFillPath(context);
    
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextFillRect(ctx, rect);
    
}



- (void)addWhiteRect:(CGContextRef)ctx path:(CGMutablePathRef)path {
    CGContextSetFillColorWithColor(ctx, MTRGBAColor(255, 255, 255, 0.2).CGColor);
    CGContextAddPath(ctx, path);
    
    CGContextFillPath(ctx);
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *tou = touches.anyObject;
    CGPoint point =  [tou locationInView:self];
    if ((point.x >= 0 && point.x <= self.frame.size.width) && (point.y >= 0 && point.y <= self.frame.size.height)) {
        
        if (CGRectContainsPoint(CGRectMake(_p1.x - r, _p1.y - r, r * 2, r * 2), point)) {
//            _p1 = point;
            num = 1;
            //            [self setNeedsDisplay];
        } else if (CGRectContainsPoint(CGRectMake(_p2.x - r, _p2.y - r, r * 2, r * 2), point)) {
//            _p2 = point;
            num = 2;
            
            //            [self setNeedsDisplay];
            
        } else if (CGRectContainsPoint(CGRectMake(_p3.x - r, _p3.y - r, r * 2, r * 2), point)) {
//            _p3 = point;
            num = 3;
            //            [self setNeedsDisplay];
            
        } else if (CGRectContainsPoint(CGRectMake(_p4.x - r, _p4.y - r, r * 2, r * 2), point)) {
//            _p4 = point;
            num = 4;
            //            [self setNeedsDisplay];
            
        }
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *tou = touches.anyObject;
    CGPoint point =  [tou locationInView:self];
    // 边缘检测，是否超出边界
    if (point.x < space) {
        point.x = space;
    } else if (point.x > self.imgView.frame.size.width + space) {
        point.x = self.imgView.frame.size.width + space;
    }
    if (point.y < space) {
        point.y = space;
        
    } else if (point.y > self.imgView.frame.size.height + space) {
        point.y = self.imgView.frame.size.height + space;
        
    }
    if (num == 1) {
        _p1 = point;
        [self setNeedsDisplay];
        
    } else if (num == 2) {
        _p2 = point;
        [self setNeedsDisplay];
        
    } else if (num == 3) {
        _p3 = point;
        [self setNeedsDisplay];
        
    } else if (num == 4) {
        _p4 = point;
        [self setNeedsDisplay];
        
    }
    
    
    //    if (CGRectContainsPoint(CGRectMake(_p1.x - r, _p1.y - r, r * 2, r * 2), point)) {
    //
    //
    //        _p1 = point;
    //        [self setNeedsDisplay];
    //    } else if (CGRectContainsPoint(CGRectMake(_p2.x - r, _p2.y - r, r * 2, r * 2), point)) {
    //        _p2 = point;
    //        [self setNeedsDisplay];
    //
    //    } else if (CGRectContainsPoint(CGRectMake(_p3.x - r, _p3.y - r, r * 2, r * 2), point)) {
    //        _p3 = point;
    //        [self setNeedsDisplay];
    //
    //    } else if (CGRectContainsPoint(CGRectMake(_p4.x - r, _p4.y - r, r * 2, r * 2), point)) {
    //        _p4 = point;
    //        [self setNeedsDisplay];
    //
    //    }
    
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    intersect(_p1, _p2, _p3, _p4);
    //    intersect(_p2, _p3, _p1, _p4);
    //    intersect(_p2, _p3, _p1, _p4);
    //
    //    if (num == 1) {
    //        if (intersect(_p1, _p2, _p3, _p4)) {
    //            CGPoint temp = _p1;
    //            _p1 = _p4;
    //            _p4 = temp;
    //        } else if (intersect(_p2, _p3, _p1, _p4)) {
    //            CGPoint temp = _p1;
    //            _p1 = _p2;
    //            _p2 = temp;
    //
    //        }
    //    } else if (num == 2) {
    //        if (intersect(_p2, _p3, _p1, _p4)) {
    //            CGPoint temp = _p3;
    //            _p3 = _p2;
    //            _p2 = temp;
    //
    //        }
    //
    //    }
    if (intersect(_p1, _p2, _p3, _p4)) {
        CGPoint temp = _p1;
        _p1 = _p4;
        _p4 = temp;
        [self setNeedsDisplay];
    }
    if (intersect(_p2, _p3, _p1, _p4)) {
        CGPoint temp = _p1;
        _p1 = _p2;
        _p2 = temp;
        [self setNeedsDisplay];
        
    }
    if (intersect(_p2, _p3, _p1, _p4)) {
        CGPoint temp = _p3;
        _p3 = _p2;
        _p2 = temp;
        [self setNeedsDisplay];
        
    }
    
    if (getAngle(_p1, _p2, _p4) > maxAngle || getAngle(_p2, _p1, _p3) > maxAngle || getAngle(_p3, _p2, _p4) > maxAngle || getAngle(_p4, _p1, _p3) > maxAngle) {
        isClip = NO;
        [self setNeedsDisplay];
    } else {
        isClip = YES;
        [self setNeedsDisplay];
        
    }
    
    
    if (IsInTriangle(_p2, _p3, _p4, _p1) || IsInTriangle(_p1, _p3, _p4, _p2) || IsInTriangle(_p1, _p2, _p4, _p3) || IsInTriangle(_p1, _p2, _p3, _p4)) {
        isClip = NO;
        [self setNeedsDisplay];
        
    }
    num = -1;
    
    
    
    
}



- (void)sortPoint {
    
}



/**
 * @brief 计算三角形面积
 */
float GetTriangleSquar(CGPoint pt0, const CGPoint pt1, const CGPoint pt2)
{
    CGPoint AB,   BC;
    AB.x = pt1.x - pt0.x;
    AB.y = pt1.y - pt0.y;
    BC.x = pt2.x - pt1.x;
    BC.y = pt2.y - pt1.y;
    return fabs((AB.x * BC.y - AB.y * BC.x)) / 2.0f;
}

/**
 * @brief 判断给定一点是否在三角形内或边上
 */
bool IsInTriangle(const CGPoint A, const CGPoint B, const CGPoint C, const CGPoint D)
{
    float SABC, SADB, SBDC, SADC;
    SABC = GetTriangleSquar(A, B, C);
    SADB = GetTriangleSquar(A, D, B);
    SBDC = GetTriangleSquar(B, D, C);
    SADC = GetTriangleSquar(A, D, C);
    
    float SumSuqar = SADB + SBDC + SADC;
    
    if ((-ABS_FLOAT_0 < (SABC - SumSuqar)) && ((SABC - SumSuqar) < ABS_FLOAT_0))
    {
        return true;
    }
    else
    {
        return false;
    }
}


double getAngle(CGPoint pSrc, CGPoint p1, CGPoint p2)
{
    double angle = 0.0f; // 夹角
    
    // 向量Vector a的(x, y)坐标
    double va_x = p1.x - pSrc.x;
    double va_y = p1.y - pSrc.y;
    
    // 向量b的(x, y)坐标
    double vb_x = p2.x - pSrc.x;
    double vb_y = p2.y - pSrc.y;
    
    double productValue = (va_x * vb_x) + (va_y * vb_y);  // 向量的乘积
    double va_val = sqrt(va_x * va_x + va_y * va_y);  // 向量a的模
    double vb_val = sqrt(vb_x * vb_x + vb_y * vb_y);  // 向量b的模
    double cosValue = productValue / (va_val * vb_val);      // 余弦公式
    
    // acos的输入参数范围必须在[-1, 1]之间，否则会"domain error"
    // 对输入参数作校验和处理
    if(cosValue < -1 && cosValue > -2)
        cosValue = -1;
    else if(cosValue > 1 && cosValue < 2)
        cosValue = 1;
    
    // acos返回的是弧度值，转换为角度值
    angle = acos(cosValue) * 180 / M_PI;
    
    return angle;
}




//叉积
double mult(CGPoint a, CGPoint b, CGPoint c)
{
    return (a.x-c.x)*(b.y-c.y)-(b.x-c.x)*(a.y-c.y);
}

//aa, bb为一条线段两端点 cc, dd为另一条线段的两端点 相交返回true, 不相交返回false
bool intersect(CGPoint aa, CGPoint bb, CGPoint cc, CGPoint dd)
{
    
    if ( MAX(aa.x, bb.x)<MIN(cc.x, dd.x) )
    {
        return false;
    }
    if ( MAX(aa.y, bb.y)<MIN(cc.y, dd.y) )
    {
        return false;
    }
    if ( MAX(cc.x, dd.x)<MIN(aa.x, bb.x) )
    {
        return false;
    }
    if ( MAX(cc.y, dd.y)<MIN(aa.y, bb.y) )
    {
        return false;
    }
    if ( mult(cc, bb, aa)*mult(bb, dd, aa)<0 )
    {
        return false;
    }
    if ( mult(aa, dd, cc)*mult(dd, bb, cc)<0 )
    {
        return false;
    }
    return true;
}


@end
