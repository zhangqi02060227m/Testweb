//
//  IBWebView.h
//  TestWeb
//
//  Created by huangbo on 17/5/5.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface IBWebView : UIViewController

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) void (^blockHeight)(CGFloat height);


@end
