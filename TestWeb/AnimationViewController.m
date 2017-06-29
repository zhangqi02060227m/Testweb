//
//  AnimationViewController.m
//  TestWeb
//
//  Created by huangbo on 17/5/19.
//  Copyright © 2017年 huangbo. All rights reserved.
//
#import "AnimationViewController.h"
#import "DrawView.h"
#import "MTDefine.h"
@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
//    [self startAnimation];


//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100 + 20, SCREENWIDTH - 20 * 2, SCREENHEIGHT - 250 - 20 * 2)];
//    imgView.userInteractionEnabled = YES;
//    imgView.image = [UIImage imageNamed:@"timg.jpeg"];
//    [self.view addSubview:imgView];
    
    DrawView *draw = [[DrawView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENHEIGHT - 250)];
    draw.backgroundColor = [UIColor clearColor];
    [self.view addSubview:draw];
    
    

    
    
    

}













- (void)startAnimation {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
//    layer.position = CGPointMake(0, 64);

    layer.frame = CGRectMake(0, 64, 200, 200);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *animation = [CABasicAnimation animation];
//        animation.keyPath = @"transform.scale"; // 缩放
        animation.keyPath = @"transform.rotation";  // 旋转
//        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
        animation.toValue = @M_PI_4;
        animation.duration = 10;
        animation.repeatCount = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [layer addAnimation:animation forKey:nil];

    });
    



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
