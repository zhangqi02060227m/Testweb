//
//  LineView.m
//  TestWeb
//
//  Created by huangbo on 17/5/8.
//  Copyright © 2017年 huangbo. All rights reserved.
//


#import "LineView.h"

@interface LineView ()
{
    CGMutablePathRef path;
}

@property (nonatomic, assign) CGPoint sPoint;
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, strong) NSMutableArray *arrLine;
@property (nonatomic, strong) NSMutableArray *arrCopyLine;
@property (nonatomic, strong) NSMutableArray *arrL;
@property (nonatomic, assign) CGContextRef con;
@property (nonatomic, strong) UIView *toolView;

@end

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"123123");
        self.backgroundColor = [UIColor whiteColor];
        self.stockColor = [UIColor redColor];
        
        self.lineWidth = 4;
        self.arrLine = [NSMutableArray array];
        self.arrCopyLine = [NSMutableArray array];
        self.arrL = [NSMutableArray array];
        self.type = KDrawTypeLine;

        [self createView];
    }
    return self;
}

- (void)createView {
    self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
//    self.toolView.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.toolView];
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(0, 0, 40, 20);
    [Btn setTitle:@"undo" forState:UIControlStateNormal];
    Btn.backgroundColor = [UIColor cyanColor];
    [self.toolView addSubview:Btn];
    [Btn addTarget:self action:@selector(handleUndo) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnClear = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClear.frame = CGRectMake(40, 0, 40, 20);
    [btnClear setTitle:@"clear" forState:UIControlStateNormal];
    btnClear.backgroundColor = [UIColor redColor];
    [self.toolView addSubview:btnClear];
    [btnClear addTarget:self action:@selector(handleClear) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(80, 0, 40, 20);
    [btnBack setTitle:@"back" forState:UIControlStateNormal];
    btnBack.backgroundColor = [UIColor redColor];
    [self.toolView addSubview:btnBack];
    [btnBack addTarget:self action:@selector(handleBack) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnNormal = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNormal.frame = CGRectMake(120, 0, 80, 20);
    [btnNormal setTitle:@"line" forState:UIControlStateNormal];
    [btnNormal setTitle:@"任何线" forState:UIControlStateSelected];
    btnNormal.backgroundColor = [UIColor redColor];
    [self.toolView addSubview:btnNormal];
    [btnNormal addTarget:self action:@selector(handleSel:) forControlEvents:UIControlEventTouchUpInside];
    btnNormal.selected = NO;
    
    UIButton *btnRect = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRect.frame = CGRectMake(200, 0, 80, 20);
    
    [btnRect setTitle:@"rect" forState:UIControlStateNormal];
    [btnRect setTitle:@"圆" forState:UIControlStateSelected];
    btnRect.backgroundColor = [UIColor redColor];
    [self.toolView addSubview:btnRect];
    [btnRect addTarget:self action:@selector(handleRect:) forControlEvents:UIControlEventTouchUpInside];
    btnRect.selected = NO;

    
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.arrLine.count != 0) {
        for (int i = 0; i < self.arrLine.count; i++) {
//            [self.stockColor setStroke];
            [[UIColor redColor] setStroke];
            CGContextSetLineWidth(context, 2);

            CGMutablePathRef pa = (__bridge CGMutablePathRef)(self.arrLine[i]);
            CGContextAddPath(context, pa);
            CGContextDrawPath(context, kCGPathStroke);
        }

    }
    if (path != nil) {//绘制当前线条
        [[UIColor redColor] setStroke];
        CGContextSetLineWidth(context, 2);
        CGContextAddPath(context,  path);
        CGContextDrawPath(context, kCGPathStroke);
    }
    if (self.type == KDrawTypeLine) {
        if (!CGPointEqualToPoint(self.sPoint, self.endPoint) && !CGPointEqualToPoint(self.sPoint, CGPointZero)) {
            [[UIColor redColor] setStroke];
            CGContextSetLineWidth(context, 2);
            
            CGContextMoveToPoint(context, self.sPoint.x, self.sPoint.y);
            CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
            CGContextDrawPath(context, kCGPathStroke);
            
        }

    } else if (self.type == KDrawTypeRect) {
        if (!CGPointEqualToPoint(self.sPoint, self.endPoint) && !CGPointEqualToPoint(self.sPoint, CGPointZero)) {
            [[UIColor redColor] setStroke];
            CGContextSetLineWidth(context, 2);
//            CGContextMoveToPoint(context, self.sPoint.x, self.sPoint.y);
            CGPathAddRect(path, NULL, CGRectMake(self.sPoint.x, self.sPoint.y, self.endPoint.x - self.sPoint.x, self.endPoint.y - self.sPoint.y));
            CGContextDrawPath(context, kCGPathStroke);
        }

    }
    NSString *str = @"zhangqi";
    [str drawAtPoint:CGPointMake(100, 100) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor redColor]}];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint sPoint = [touch locationInView:self];
    path = CGPathCreateMutable();
    self.sPoint = sPoint;

    if (self.type == KDrawTypeLine) {
        CGPathMoveToPoint(path, NULL, sPoint.x, sPoint.y);
        
    } else if (self.type == KDrawTypeAny) {
        CGPathMoveToPoint(path, NULL, sPoint.x, sPoint.y);

    } else if (self.type == KDrawTypeRect) {
//        CGPathMoveToPoint(path, NULL, sPoint.x, sPoint.y);

    } else {
        CGPathMoveToPoint(path, NULL, sPoint.x, sPoint.y);

    }


}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint sPoint = [touch locationInView:self];
    self.endPoint = sPoint;

    if (self.type == KDrawTypeLine) {
//        CGPathAddLineToPoint(path, NULL, sPoint.x, sPoint.y);

    } else if (self.type == KDrawTypeAny)  {
        CGPathAddLineToPoint(path, NULL, self.endPoint.x, self.endPoint.y);

    } else if (self.type == KDrawTypeRect) {

    }
    [self setNeedsDisplay];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (self.type == KDrawTypeLine) {
        CGPathAddLineToPoint(path, NULL, self.endPoint.x, self.endPoint.y);

//        [self.arrL addObject:(__bridge id)(path)];
    } else if (self.type == KDrawTypeAny) {

    } else if (self.type == KDrawTypeRect) {
//        CGPathAddRect(path, NULL, CGRectMake(self.sPoint.x, self.sPoint.y, self.endPoint.x - self.sPoint.x, self.endPoint.y - self.sPoint.y));

    }
    if (![self.arrLine containsObject:(__bridge id)(path)]) {
        [self.arrLine addObject:(__bridge id)(path)];
        [self.arrCopyLine addObject:(__bridge id)(path)];
    }
    
    self.sPoint = CGPointZero;
    self.endPoint = CGPointZero;

    
    CGPathRelease(path);
    path = nil;
}

- (void)handleUndo {
    if (self.arrLine.count != 0) {
        [self.arrLine removeLastObject];
        [self setNeedsDisplay];

    }
}

- (void)handleBack {
    if (self.arrCopyLine.count && self.arrCopyLine.count > self.arrLine.count) {
        [self.arrLine addObject:[self.arrCopyLine objectAtIndex:self.arrLine.count]];

        [self setNeedsDisplay];
    }
}

- (void)handleClear {
    if (self.arrLine.count) {
        [self.arrLine removeAllObjects];
        [self setNeedsDisplay];
    }
}

- (void)handleSel:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.type = KDrawTypeAny;
    } else {
        self.type = KDrawTypeLine;
    }
}

- (void)handleRect:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.type = KDrawTypeEllipse;

    } else {
        self.type = KDrawTypeRect;

    }
}


@end
