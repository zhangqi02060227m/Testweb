//
//  ScanView.m
//  TestWeb
//
//  Created by huangbo on 17/5/24.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "ScanView.h"
#import "MTDefine.h"
@interface ScanView ()
MTPropertyStrong UIImageView *imgViewScan;
@property (nonatomic, assign) CGFloat qrLineY;
@end
@implementation ScanView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scanArea = CGSizeMake(300, 300);
        self.lineWidth = 3;
        self.cornerColor = [UIColor greenColor];
        
        if (self.imgViewScan) {
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(show) userInfo:nil repeats:YES];
            [timer fire];
            
        }

    }
    return self;
}




- (void)show {
    
        CGRect rect = self.imgViewScan.frame;
        rect.origin.y = self.qrLineY;
        self.imgViewScan.frame = rect;
        
    
        CGFloat maxBorder = self.bounds.size.height / 2 + self.scanArea.height / 2 - 4;
        if (self.qrLineY > maxBorder) {
            
            self.qrLineY = self.bounds.size.height / 2 - self.scanArea.height /2;
        }
        self.qrLineY++;
}

- (UIImageView *)imgViewScan {
    if (!_imgViewScan) {
        self.imgViewScan = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - self.scanArea.width / 2, self.bounds.size.height / 2 - self.scanArea.height / 2, self.scanArea.width, 3)];
        self.imgViewScan.image = [UIImage imageNamed:@"qr_scan_line"];
//        self.imgViewScan.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imgViewScan];
        self.qrLineY = self.bounds.size.height / 2 - self.scanArea.height / 2;
        NSLog(@"%@", NSStringFromCGRect(self.bounds));
    }
    return _imgViewScan;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:context rect:self.bounds];
    
    
    
    CGRect scanRect = CGRectMake(self.bounds.size.width / 2 - self.scanArea.width / 2, self.bounds.size.height / 2 - self.scanArea.height / 2, self.scanArea.width, self.scanArea.height);
    
    [self addWhiteRect:context rect:scanRect];
    
    [self addCornerLineWithContext:context rect:scanRect];
}


- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextSetRGBFillColor(ctx, 40 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ctx, rect);
    
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer

    CGContextStrokeRect(ctx, rect);
    
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    
    //画四个边角
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextSetStrokeColorWithColor(ctx, self.cornerColor.CGColor);
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.7, rect.origin.y),
        CGPointMake(rect.origin.x+0.7 , rect.origin.y + 15)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.7),CGPointMake(rect.origin.x + 15, rect.origin.y+0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.7) ,CGPointMake(rect.origin.x+0.7 +15, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.7,rect.origin.y + 15 +0.7 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
}


- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}



@end
