
//
//  IBWebView.m
//  TestWeb
//
//  Created by huangbo on 17/5/5.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "IBWebView.h"

@interface IBWebView ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation IBWebView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self confWebView];
        [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blueColor];

}


- (void)setUrl:(NSString *)url {
    _url = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}


- (void)setUrlPath:(NSString *)urlPath {
    _urlPath = urlPath;
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:self.urlPath ofType:@"html"];
    NSString *fileURL = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:fileURL baseURL:baseURL];
}

- (void)confWebView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollView];
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, )
    //1、该对象提供了通过js向web view发送消息的途径
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //添加在js中操作的对象名称，通过该对象来向web view发送消息
    [userContentController addScriptMessageHandler:self name:@"Share"];
    
    //2、
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = userContentController;
    
    
    //3、通过初试化方法，生成webview对象并完成配置
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, self.scrollView.frame.size.width, self.scrollView.frame.size.height) configuration:config];
    self.webView.backgroundColor = [UIColor brownColor];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
}


#pragma mark -- WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    // JS调用OC方法
    //message.boby就是JS里传过来的参数
    NSLog(@"body:%@",message.body);
    NSDictionary *body = message.body;
    
    if ([message.name isEqualToString:@"Share"]) {
        // OC调用JS
        NSString *JSResult = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",body[@"title"],body[@"content"],body[@"url"]];
        [self.webView evaluateJavaScript:JSResult completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"---- %@    %@", result, error);
        }];
    } else if ([message.name isEqualToString:@"Camera"]) {
    }
}



- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //设置JS
    NSString *inputValueJS = @"document.getElementsByName('txtInitiations')[0].attributes['value'].value";
    //执行JS
    [webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"value: %@ error: %@", response, error);
    }];
    
    CGFloat height = webView.scrollView.contentSize.height;
//    NSLog(@"----- %lf", height);

}



- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
    NSLog(@"网页开始加载时调用:%s",__func__);
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"加载到内容开始返回时调用:%s",__func__);
    CGFloat height = webView.scrollView.contentSize.height;
//    NSLog(@"----- %lf", height);

    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"网页加载失败时调用:%s",__func__);
    
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
}


- (void)dealloc {
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == self.webView.scrollView && [keyPath isEqual:@"contentSize"]) {
        
        UIScrollView *scrollView = self.webView.scrollView;
        NSLog(@"New contentSize: %f x %f", scrollView.contentSize.width, scrollView.contentSize.height);
        if (self.blockHeight) {
            self.blockHeight(scrollView.contentSize.height);
        }
    }
}


@end
