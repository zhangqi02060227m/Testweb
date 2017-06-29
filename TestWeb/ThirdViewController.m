//
//  ThirdViewController.m
//  TestWeb
//
//  Created by huangbo on 17/5/25.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "ThirdViewController.h"
#import "MTDefine.h"
#import "SDCycleScrollView.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoViewController.h"
#import "PlayerMaskView.h"
#import "PickerViewController.h"
#import "TextFieldViewController.h"
@interface ThirdViewController ()<PlayerMaskViewDelegate>
@property PlayerMaskView *playerMaskView;
@property AVPlayerLayer *layer1;

@property (nonatomic, strong) UIView *viewVidoe;
@property (nonatomic, strong) UIButton *btnBack;

@end

@implementation ThirdViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    SDCycleScrollView *sdc = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 200)];
//    sdc.localizationImageNamesGroup = @[[UIImage imageNamed:@"ban1"], [UIImage imageNamed:@"ban2"]];
//    sdc.pageControlDotSize = CGSizeMake(50, 10);
//    sdc.currentPageDotImage = [UIImage imageNamed:@"2"];
//    sdc.pageDotImage = [UIImage imageNamed:@"1"];
//    [self.view addSubview:sdc];
    
    
    
//    self.navigationController.navigationBarHidden = YES;
//    
//    NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
//    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
//    
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
//    
//    
//    
//    AVPlayerLayer *layer = [AVPlayerLayer layer];
//    layer.player = player;
//    layer.frame = CGRectMake(0, 64, SCREENWIDTH, 300);
//    [self.view.layer addSublayer:layer];
//    self.layer1 = layer;
//    
//    PlayerMaskView *playerMaskView = [[PlayerMaskView alloc] initWithFrame:layer.frame];
//
//    [self.view addSubview:playerMaskView];
//    self.playerMaskView = playerMaskView;
//    
//    self.playerMaskView.backgroundColor = [UIColor blackColor];
//    self.playerMaskView.alpha = 0.5;
//    
//    [player play];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitle:@"跳转界面" forState:UIControlStateNormal];
    [self.view addSubview:btn];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    [btn addTarget:self action:@selector(handleBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"UIPickerView" style:UIBarButtonItemStylePlain target:self action:@selector(handleNaviLeft)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"UIITextField" style:UIBarButtonItemStylePlain target:self action:@selector(handleNaviRight)];

    
    self.viewVidoe = [[UIView alloc] init];
    self.viewVidoe.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.viewVidoe];
    [self.viewVidoe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.height.mas_equalTo(300);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREENWIDTH);
    }];
    self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnBack setTitle:@"播放" forState:UIControlStateNormal];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewVidoe addSubview:self.btnBack];
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(20);
    }];

    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];

}


- (void)handleNaviLeft {
    PickerViewController *picker = [[PickerViewController alloc] init];
    [self.navigationController pushViewController:picker animated:YES];
}

- (void)handleNaviRight {
    TextFieldViewController *field = [[TextFieldViewController alloc] init];
    [self.navigationController pushViewController:field animated:YES];
    
}

- (void)changeVideoLayout {
//    self.navigationController.navigationBarHidden = YES;

    [self.viewVidoe mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(SCREENWIDTH);
        make.width.mas_equalTo(SCREENHEIGHT);
    }];
    NSLog(@"%lf", SCREENWIDTH);
}


- (void)onDeviceOrientationChange {
//    NSLog(@"屏幕方向改变了");
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    if (orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown || orientation == UIDeviceOrientationUnknown ) { return; }
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"反方向");

        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"原始方向");
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"home 在左边");
            [self changeVideoLayout];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"home 在右边");
            [self changeVideoLayout];
        }
            break;
        default:
            break;
    }
}



- (void)play {
    self.playerMaskView.hidden = !self.playerMaskView.hidden;

    
}

- (void)handleBtn {
    VideoViewController *video = [[VideoViewController alloc] init];
    [self.navigationController pushViewController:video animated:YES];
    
    video.name = @"url";
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
