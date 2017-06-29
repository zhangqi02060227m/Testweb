//
//  MTMessageView.m
//  TestWeb
//
//  Created by huangbo on 17/5/15.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "MTMessageView.h"
#import "Masonry.h"
#import "MTDefine.h"
@interface MTMessageView ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *labMessage;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, copy) MTClickCancel clickCancel;
@property (nonatomic, copy) MTClickConfirm clickConfirm;

@property (nonatomic, strong) UIView *viewBg;

@end
@implementation MTMessageView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        [self createView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        [self createView];
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.labTitle.text = self.title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.labTitle.textColor = self.titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.labTitle.font = self.titleFont;
}

- (void)setMsgStr:(NSString *)msgStr {
    _msgStr = msgStr;
    self.labMessage.text = self.msgStr;
}

- (void)setMsgColor:(UIColor *)msgColor {
    _msgColor = msgColor;
    self.labMessage.textColor = self.msgColor;
}

- (void)setMsgFont:(UIFont *)msgFont {
    _msgFont = msgFont;
    self.labMessage.font = msgFont;
}

- (void)showMessageView {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    self.viewBg = [[UIView alloc] initWithFrame:window.frame];
    self.viewBg.alpha = 0;
    self.viewBg.backgroundColor = MTHexColor(0x000000);
    [window addSubview:self.viewBg];
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREENHEIGHT);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.viewBg.alpha = 0.5;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SCREENHEIGHT - 200);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)removeMessageView {
    [UIView animateWithDuration:0.25 animations:^{
        self.viewBg.alpha = 0;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SCREENHEIGHT);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.viewBg removeFromSuperview];
        [self removeFromSuperview];
    }];

}


- (void)createView {
    self.labTitle = [[UILabel alloc] init];
    [self addSubview:self.labTitle];
    
    self.scrollView  = [[UIScrollView alloc] init];
    [self addSubview:self.scrollView];
    
    
    self.labMessage = [[UILabel alloc] init];
    [self.scrollView addSubview:self.labMessage];
    self.labMessage.numberOfLines = 0;

    
    self.btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    self.btnCancel.backgroundColor = [UIColor brownColor];
    [self addSubview:self.btnCancel];
    [self.btnCancel addTarget:self action:@selector(handleClickCancel) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    self.btnConfirm.backgroundColor = [UIColor brownColor];

    [self addSubview:self.btnConfirm];
    [self.btnConfirm addTarget:self action:@selector(handleClickConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    self.labTitle.text = @"标题";
    
    self.labMessage.text = @"fasdfnafbdangv.fdjb、个卡率负s/vksafv阿福。 的，办法daf/bvadfv.dsmv/dvba/vs/\n你发发给你方便kdar/gnRGVCMB DFJ E/FV  VADLVF DF.B FDMV A/V .V .2.根据上面要进行动画的视图 在另一个方法中去实现它，在这个方法中，注意下图attention_2 调用了setNeedsUpdateConstraints这个方法，这是为了提前告诉superView需要更新约束了但是没告诉他约束是什么（体育课的热身活动🤔）。再来就是attention_3位置，其实这个方法不用调用貌似也行，但masonry官方建议加上🤔。然后呢，再下面添加需要更新的约束。这里有点要注意的地方：请调用mas_updateConstraints方法进行约束的更新。最后呢你添加好了约束了就是刷新你的view让动画展示出来，在动画实现的闭包里再次调用layoutIfNeeded。这样一个基本的动画就可以实现了。";
    
    self.labMessage.font = [UIFont systemFontOfSize:20];

    MASAttachKeys(self.labTitle, self.labMessage, self.scrollView, self.btnCancel, self.btnConfirm); // 解决masonry冲突的问题
}


- (void)clickCancelBlock:(void (^)())block {
    self.clickCancel = block;
}

- (void)clickConfirmBlock:(void (^)(NSString *msg))block {
    self.clickConfirm = block;
}


- (void)handleClickCancel {
    if (self.clickCancel) {
        self.clickCancel();
    }
}

- (void)handleClickConfirm {
    if (self.clickConfirm) {
        self.clickConfirm(self.labMessage.text);
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(5);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.labTitle.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(100);
    }];
    CGRect rect = [self.labMessage.text boundingRectWithSize:CGSizeMake(SCREENWIDTH - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.labMessage.font } context:nil];
    [self.labMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(rect.size.height);
    }];
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom).offset(20);
        make.right.mas_equalTo(self.mas_centerX).offset(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mas_centerX).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, rect.size.height + 20);

}

@end






