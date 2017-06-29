//
//  UserViewController.m
//  TestWeb
//
//  Created by huangbo on 17/5/19.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "UserViewController.h"
#import "MTDefine.h"

#import "HotCityCell.h"
#import "OnlyTitleCell.h"

static NSString *const Cell_UserHotCity = @"Cell_UserHotCity";

static NSString *const Cell_UserOnlyTitle = @"Cell_UserOnlyTitle";

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *userTableView;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableArray *arrKey;
MTPropertyStrong NSMutableArray *arrFlag; // 是否展开的标志
MTPropertyStrong UIView *indexView;
@property (nonatomic, assign) CGFloat indexTop;
MTPropertyStrong UILabel *labIndex;
@property (nonatomic, strong) NSMutableArray *arrLab;


@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"城市选择";
    
    self.arrLab = [NSMutableArray array];
    self.arrFlag = [NSMutableArray array];
    [self requestCityList];
    [self createView];
    [self createIndexView];
    
    
    
}

- (void)requestCityList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    self.dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    self.arrKey = [[self.dic allKeys] sortedArrayUsingSelector:@selector(compare:)].mutableCopy;
    [self.arrKey insertObject:@"热门" atIndex:0];
    NSArray *hot = @[@"bei", @"shang", @"guang", @"shen"];
    [self.dic setObject:hot forKey:@"热门"];
    
    for (int i = 0; i < [self.dic allKeys].count; i++) {
        NSNumber *num = [NSNumber numberWithBool:YES];
        [self.arrFlag addObject:num];
    }
}


- (void)createView  {
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 49) style:UITableViewStyleGrouped];
    [self.view addSubview:self.userTableView];
    self.userTableView.backgroundColor = [UIColor clearColor];
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    [self.userTableView registerClass:[OnlyTitleCell class] forCellReuseIdentifier:Cell_UserOnlyTitle];
    [self.userTableView registerClass:[HotCityCell class] forCellReuseIdentifier:Cell_UserHotCity];

    self.userTableView.tableFooterView = [[UIView alloc] init];
 
}


- (void)createIndexView {
    self.indexView = [[UIView alloc] init];
    [self.view addSubview:self.indexView];
    self.indexView.alpha = 0.8;
    [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(35);
    }];
    
    [self.indexView layoutIfNeeded];
    CGFloat top = (self.indexView.frame.size.height / 2 - self.arrKey.count * 20 / 2);
    self.indexTop = top;
    CGFloat h = 20;

    for (int i = 0; i < self.arrKey.count; i++) {
        UILabel *lab = [[UILabel alloc] init];
        [self.indexView addSubview:lab];
        lab.textColor = MTHexColor(0x000000);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = self.arrKey[i];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top + i * h);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(h);
        }];
        [self.arrLab addObject:lab];
    }
}

#pragma mark - talbeView delefate 方法
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_UserHotCity forIndexPath:indexPath];
        NSArray *arr = [self.dic objectForKey:self.arrKey[indexPath.section]];
        cell.arr = arr;
        return cell;

    } else {
        OnlyTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_UserOnlyTitle forIndexPath:indexPath];
        NSArray *arr = [self.dic objectForKey:self.arrKey[indexPath.section]];
        cell.title = arr[indexPath.row];
        return cell;

    }
    
    
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//
//    return self.arrKey[section];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    view.backgroundColor = [UIColor grayColor];
    UILabel *lab = [[UILabel alloc] init];
    [view addSubview:lab];
    lab.text = self.arrKey[section];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view);
    }];
    UIImageView *img = [[UIImageView alloc] init];
    [view addSubview:img];
    NSNumber *num = self.arrFlag[section];
    if (num.boolValue) {
        img.image = [UIImage imageNamed:@"quotation_parameter_top"];

    } else {
        img.image = [UIImage imageNamed:@"tabbar_live_highlight"];
    }
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.width.height.mas_equalTo(20);
        make.right.mas_equalTo(-10);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClick:)];
    [view addGestureRecognizer:tap];
    view.tag = 200 + section;
    return view;
}

- (void)handleClick:(UITapGestureRecognizer *)tap {
    NSNumber *num = self.arrFlag[tap.view.tag - 200];
    UIImageView *imgView = nil;
    for (id view in tap.view.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            imgView = view;
        }
    }
    if (num.boolValue) {
        self.arrFlag[tap.view.tag - 200] = [NSNumber numberWithBool:NO];
//        imgView.image = [UIImage imageNamed:@"tabbar_live_highlight"];
    } else {
        self.arrFlag[tap.view.tag - 200] = [NSNumber numberWithBool:YES];
//        imgView.image = [UIImage imageNamed:@"quotation_parameter_top"];

    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.userTableView reloadSections:[[NSIndexSet alloc] initWithIndex:tap.view.tag - 200] withRowAnimation:UITableViewRowAnimationFade];
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrKey.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = [self.dic objectForKey:self.arrKey[indexPath.section]];
    NSNumber *num = self.arrFlag[indexPath.section];
    
    if (num.boolValue) {
        if (indexPath.section == 0) {
            if (arr.count % 3 == 0) {
                return arr.count / 3 * 40;
            } else {
                return (arr.count / 3 + 1) * 40;
            }
        }
        return 40;

    } else {
        return 0;
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self.dic objectForKey:self.arrKey[section]];
    if (section == 0) {
        return 1;
    }

    return arr.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UILabel *)labIndex {
    if (!_labIndex) {
        self.labIndex = [[UILabel alloc] init];
        self.labIndex.backgroundColor = MTHexColor(0x000000);
        self.labIndex.alpha = 0.8;
        self.labIndex.textColor = MTHexColor(0xffffff);
        self.labIndex.font = [UIFont systemFontOfSize:30];
        self.labIndex.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.labIndex];
        [self.labIndex mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.userTableView);
            make.width.height.mas_equalTo(80);
        }];
    }
    return _labIndex;
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self.indexView]) {

        CGPoint point = [touch locationInView:self.indexView];
//        NSLog(@"-- %@", NSStringFromCGPoint(point));
        int index = (int)((point.y - self.indexTop) / 20);
        if (index < self.arrLab.count && point.y >= self.indexTop) {
            self.labIndex.hidden = NO;
            for (UILabel *lbl in self.arrLab) {
                lbl.textColor = MTHexColor(0xffffff);
            }
            self.indexView.backgroundColor = [UIColor clearColor];
            UILabel *lab = [self.arrLab objectAtIndex:index];
//            NSLog(@"%@", lab.text);
            self.labIndex.text = lab.text;
            NSArray *arr = self.dic[self.arrKey[index]];
            [self.userTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];

        }

    }
}



- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self.indexView]) {
        CGPoint point = [touch locationInView:self.indexView];
        //        NSLog(@"-- %@", NSStringFromCGPoint(point));
        int index = (int)((point.y - self.indexTop) / 20);
        if (index < self.arrLab.count && point.y >= self.indexTop) {
            self.labIndex.hidden = NO;
            self.indexView.backgroundColor = MTHexColor(0x000000);
            for (UILabel *lbl in self.arrLab) {
                lbl.textColor = MTHexColor(0xffffff);
            }

            UILabel *lab = [self.arrLab objectAtIndex:index];
            self.labIndex.text = lab.text;
            [self.userTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];

        }
        
    }

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UILabel *lbl in self.arrLab) {
        lbl.textColor = MTHexColor(0x000000);
    }

    self.indexView.backgroundColor = [UIColor clearColor];
        self.labIndex.hidden = YES;
        

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UILabel *lbl in self.arrLab) {
        lbl.textColor = MTHexColor(0x000000);
    }

        self.indexView.backgroundColor = [UIColor clearColor];
        self.labIndex.hidden = YES;

}


//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return self.arrKey;
//}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH / 2 - 100 / 2, SCREENHEIGHT - 200, 100, 100)];
//    
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//    UILabel *lab = [[UILabel alloc] init];
//    lab.text = title;
//    [view addSubview:lab];
//    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [view removeFromSuperview];
//    });
//    
//    return index;
//}


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
