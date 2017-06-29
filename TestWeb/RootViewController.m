//
//  RootViewController.m
//  TestWeb
//
//  Created by huangbo on 17/5/5.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "RootViewController.h"
#import "IBWebView.h"
#import "UserModel.h"
#import "AFNetworking.h"
#import "Banner.h"
#import "LineView.h"
#import "Person.h"
#import "NSString+Check.h"
#import "Masonry.h"
#import "MTMessageView.h"
#import "MTDefine.h"
#import "CocoaSecurity.h"
#import "TestViewController.h"
#import "AnimationViewController.h"
#import "ImageTitleView.h"
#import "ScanView.h"
#import "LBXScanNative.h"
#import <AVFoundation/AVFoundation.h>
@interface RootViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;


@property (nonatomic, strong) NSMutableArray *arrBanner;
@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) IBWebView *web;
@property (nonatomic, assign) CGFloat webH;
@property (nonatomic, strong) UIView *bottomView;
MTPropertyStrong ScanView *scan;
@end


@implementation RootViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"1");
//    });
//    dispatch_group_enter(group);
//    NSLog(@"3");
//    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"2");
//    });
//    dispatch_group_leave(group);
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"4");
//    });
//    NSLog(@"5");
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftBarButtonItem)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"动画" style:UIBarButtonItemStylePlain target:self action:@selector(handleRightBarButtonItem)];


//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 100, 40);
//    btn.center = self.view.center;
//    btn.backgroundColor = [UIColor redColor];
//    [btn setTitle:@"web View" forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(handleClick) forControlEvents:UIControlEventTouchUpInside];
//    self.arrBanner = [NSMutableArray array];
//    [self requestUserInfo];
//    
//    LineView *line = [[LineView alloc] initWithFrame:CGRectMake(0, 64, 300, 300)];
//    [self.view addSubview:line];
//    
//    // 编码
////    Person *per = [[Person alloc] init];
////    per.name = @"zhangqi";
////    per.age = 23;
////    per.image = [UIImage imageNamed:@"aa"];
////    NSMutableData *data = [NSMutableData data];
////    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
////    [archiver encodeObject:per forKey:@"per"];
////    [archiver finishEncoding];
////    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"data1"];
////    NSLog(@"%@", path);
////    [data writeToFile:path atomically:YES];
////    
////    
////    // 解码
////    NSData *dataRead = [NSData dataWithContentsOfFile:path];
////    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dataRead];
////    Person *perRead = [unArchiver decodeObjectForKey:@"per"];
//    
//    Person *per = [[Person alloc] init];
//    Person *per1 = [[Person alloc] init];
//    Person *per2 = [[Person alloc] init];
////
//    per.name = @"zhangqi";
//    per.age = 23;
//    per1 = per;
//    per2 = [per copy]; // 深copy

//    NSLog(@"--- %ld", [[per valueForKey:@"retainCount"] integerValue]);
//    NSLog(@"%p -- %p -- %p", per, per1, per2);
//    NSArray *arr = [NSArray array];
//    NSArray *arr1 = arr;
//    NSArray *arrCopy = [arr copy];
//    NSArray *arrMuCopy = [arr mutableCopy];
//    
//    NSLog(@"-- %p -- %p -- %p -- %p", arr, arr1, arrCopy, arrMuCopy);
    
//    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"-----");
//    });
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"~~~~~~~~~");
//    });
    
#if 0
    dispatch_group_t group = dispatch_group_create();
    self.group = group;
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
    dispatch_group_async(group, queue, ^{
        [self requestBanner1];
    });
    

    dispatch_group_async(group, queue, ^{
        [self requestBanner2];
        
    });

    dispatch_group_async(group, queue, ^{
        [self requestBanner3];
    });


    dispatch_group_async(group, queue, ^{
        [self requestBanner4];
           NSLog(@"结束了");
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"结束了1");
    });
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"start...");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"刷新UI...");
//        });
//    });
    
#endif
//    LineView *line = [[LineView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
//    [self.view addSubview:line];

//    [self requestNewsDetail];
//    
//    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
//    [self.view addSubview:self.scrollView];
//    
//    
//    self.web = [[IBWebView alloc] init];
//    [self.scrollView addSubview:self.web.view];
//    
//    
//    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 400)];
//    self.bottomView.backgroundColor = [UIColor redColor];
//    [self.scrollView addSubview:self.bottomView];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor cyanColor];
//    [btn setTitle:@"点击" forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    btn.frame = CGRectMake(100, 100, 100, 40);
//    [btn addTarget:self action:@selector(handleBtn) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, SCREENWIDTH, 100)];
//    scr.contentSize = CGSizeMake(SCREENWIDTH, 400);
//    scr.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:scr];
//    UILabel *lab = [[UILabel alloc] initWithFrame:scr.frame];
//    lab.text = @"fasdfnafbdangv.fdjb、个卡率负s/vksafv阿福。 的，办法daf/bvadfv.dsmv/dvba/vs/\n你发发给你方便kdar/gnRGVCMB DFJ E/FV  VADLVF DF.B FDMV A/V .V .2.根据上面要进行动画的视图 在另一个方法中去实现它，在这个方法中，注意下图attention_2 调用了setNeedsUpdateConstraints这个方法，这是为了提前告诉superView需要更新约束了但是没告诉他约束是什么（体育课的热身活动🤔）。再来就是attention_3位置，其实这个方法不用调用貌似也行，但masonry官方建议加上🤔。然后呢，再下面添加需要更新的约束。这里有点要注意的地方：请调用mas_updateConstraints方法进行约束的更新。最后呢你添加好了约束了就是刷新你的view让动画展示出来，在动画实现的闭包里再次调用layoutIfNeeded。这样一个基本的动画就可以实现了。";
//    lab.numberOfLines = 0;
//    [scr addSubview:lab];
//    
//    
//
////    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.right.mas_equalTo(0);
////        make.top.mas_equalTo(64);
////        make.height.mas_equalTo(200);
////    }];
//    
//    NSString *str = @"zhangqi";
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    
//    
//    
//
//    
//    NSData *keyData = [@"CC0A69779E15780A" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *ivData = [@"CC0A69779E15780A" dataUsingEncoding:NSUTF8StringEncoding];
//    CocoaSecurityResult *aes256 = [CocoaSecurity aesEncryptWithData:data key:keyData iv:ivData];
//    
//    CocoaSecurityResult *aes = [CocoaSecurity aesDecryptWithData:aes256.data key:keyData iv:ivData];
//
//    
//    
//    ImageTitleView *v = [[ImageTitleView alloc] init];
//    [self.view addSubview:v];
//    [v mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(200);
//        make.left.mas_equalTo(0);
//        make.width.height.mas_equalTo(80);
//    }];
//    v.style = ViewStyleImageTop;
//    v.imgTitle = @"tabbar_home_highlight";
//    v.title = @"点击";
//    [v addTarget:self action:@selector(handleV)];
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
//    imgView.image = [UIImage imageNamed:@"quotation_parameter_top"];
//    [self.view addSubview:imgView];
//    imgView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    [imgView addGestureRecognizer:tap];

    
//    ScanView *scan = [[ScanView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 49)];
//    scan.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:scan];
//    self.scan = scan;
//    
////    if (TARGET_IPHONE_SIMULATOR) {
////        NSLog(@"模拟器上运行");
////    } else if (TARGET_OS_IPHONE) { // 真机
////        [self startRunning];
////
////    }
//    CGRect cropRect = CGRectMake(_preview.frame.size.width / 2 - self.scan.scanArea.width / 2, _preview.frame.size.height / 2 - self.scan.scanArea.height / 2, self.scan.scanArea.width, self.scan.scanArea.height);
//
//    LBXScanNative *lbx = [[LBXScanNative alloc] initWithPreView:self.view ObjectType:@[AVMetadataObjectTypeQRCode] cropRect:cropRect success:^(NSArray<LBXScanResult *> *array) {
//        LBXScanResult *result = array[0];
//        NSLog(@"----- %@", result.strScanned);
//    }];
//    [lbx startScan];
    [self requestUserInfo];
    

}


- (void)startRunning {
    
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    AVCaptureConnection *outputConnection = [_output connectionWithMediaType:AVMediaTypeVideo];
    
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResize;
    _preview.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64);
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    _output.rectOfInterest = CGRectMake(_preview.frame.size.width / 2 - self.scan.scanArea.width / 2, _preview.frame.size.height / 2 - self.scan.scanArea.height / 2, self.scan.scanArea.width, self.scan.scanArea.height);

    CGSize size = _preview.frame.size;
    CGRect cropRect = CGRectMake(_preview.frame.size.width / 2 - self.scan.scanArea.width / 2, _preview.frame.size.height / 2 - self.scan.scanArea.height / 2, self.scan.scanArea.width, self.scan.scanArea.height);
    _output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                              cropRect.origin.x/size.width,
                                              cropRect.size.height/size.height,
                                              cropRect.size.width/size.width);
    
    
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue = @"";
    if ([metadataObjects count] >0)
    {
        //停止扫描
//        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"结果" message:stringValue preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [controller dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
        [self presentViewController:controller animated:YES completion:^{
            
        }];
    }
    
    
    NSLog(@" 扫描后的url是:%@",stringValue);
}


- (void)handleTap:(UITapGestureRecognizer *)tap {
    tap.view.transform = CGAffineTransformMakeRotation(-M_PI);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        tap.view.transform = CGAffineTransformMakeRotation(0);

    });
}

- (void)handleV {
    NSLog(@"---------------");
}

- (void)handleBtn {
    MTMessageView *messageView = [[MTMessageView alloc] init];
    [messageView showMessageView];
    messageView.title = @"自定义";


    
    [messageView clickCancelBlock:^{
        NSLog(@"取消");
        [messageView removeMessageView];
    }];
    
    [messageView clickConfirmBlock:^(NSString *msg) {
        NSLog(@"%@", msg);
        [messageView removeMessageView];
        
    }];

}



- (void)requestNewsDetail {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://c.m.163.com/nc/article/CK3V4UQE0529ALUL/full.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *key = responseObject[@"docid"];
        NSDictionary *dic = responseObject[@"CK3V4UQE0529ALUL"];
        NSString *body = dic[@"body"];
        NSArray *arrImg = dic[@"img"];
        for (int i = 0; i < arrImg.count; i++) {
            NSString *url = [arrImg[i][@"src"] stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
            NSArray *pixel = [arrImg[i][@"pixel"] componentsSeparatedByString:@"*"];
            CGFloat w = [pixel[0] floatValue];
            CGFloat h = [pixel[1] floatValue];
            CGFloat nowW = (self.view.frame.size.width - 20);
            CGFloat nowH = nowW * h / w;
            NSString *str = [NSString stringWithFormat:@"<img src='%@' width='%lf' height='%lf' hspace=‘10’ vspace=‘10’ >", url, w, h];
            body = [body stringByReplacingOccurrencesOfString:arrImg[i][@"ref"] withString:str];

        }
        [self.web.webView loadHTMLString:body baseURL:nil];

        __weak RootViewController *weakSelf = self;
        self.web.blockHeight = ^(CGFloat height) {
            weakSelf.webH = height;
            weakSelf.scrollView.contentSize = CGSizeMake(weakSelf.view.frame.size.width, height + 400);
            weakSelf.bottomView.frame = CGRectMake(0, height, weakSelf.view.frame.size.width, 400);
        };
//        [self.navigationController pushViewController:web animated:YES];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestUserInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:@"https://www.swgold.cn/app/banner" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success == %@", responseObject);
//        for (NSDictionary *dic in responseObject[@"Data"]) {
//            [self.arrBanner addObject:[[Banner alloc] initWithResult:dic]];
//        }
//        for (Banner *ba in self.arrBanner) {
//            NSLog(@"-- %@", ba.bannerText);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error == %@", error);
//    }];
    [manager POST:@"https://www.swgold.cn/app/GetUserInfo" parameters:@{@"SW-TokenID":@"f7c7f372-5204-4aeb-a806-b567a91feb45"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        [USER_MANAGER_INSTANCE mergeUserModel:responseObject];
        NSLog(@"username = %@", USER_MANAGER_INSTANCE.userName);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

- (void)requestBanner1 {
//    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"https://www.swgold.cn/app/banner" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"1");
//            dispatch_semaphore_signal(sem);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            dispatch_semaphore_signal(sem);
            NSLog(@"error == %@", error);
        }];
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

}
- (void)requestBanner2 {
    //    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    dispatch_group_enter(self.group);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://www.swgold.cn/app/banner" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"2");
        //            dispatch_semaphore_signal(sem);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            dispatch_semaphore_signal(sem);
        dispatch_group_leave(self.group);
        NSLog(@"error == %@", error);
    }];
    //    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
}
- (void)requestBanner3 {
    //    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    dispatch_group_enter(self.group);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://www.swgold.cn/app/banner" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"3");
        //            dispatch_semaphore_signal(sem);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            dispatch_semaphore_signal(sem);
        dispatch_group_leave(self.group);
        NSLog(@"error == %@", error);
    }];
    //    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}
- (void)requestBanner4 {
    //    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    dispatch_group_enter(self.group);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://www.swgold.cn/app/banner" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"4");
        //            dispatch_semaphore_signal(sem);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            dispatch_semaphore_signal(sem);
        dispatch_group_leave(self.group);
        NSLog(@"error == %@", error);
    }];
    //    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}


- (void)handleClick {
    IBWebView *web = [[IBWebView alloc] init];
    web.url = @"http://news.163.com/17/0505/12/CJM1D00T000189FH.html";
    [self.navigationController pushViewController:web animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleLeftBarButtonItem {
    TestViewController *test = [[TestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
//    IBWebView *ib = [[IBWebView alloc] init];
//    ib.url = @"https://zaozuo.com/box/html/2088";
//    [self.navigationController pushViewController:ib animated:YES];
}


- (void)handleRightBarButtonItem {
    AnimationViewController *animtionVc = [[AnimationViewController alloc] init];
    [self.navigationController pushViewController:animtionVc animated:YES];
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
