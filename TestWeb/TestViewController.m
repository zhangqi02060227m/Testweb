//
//  TestViewController.m
//  TestWeb
//
//  Created by huangbo on 17/5/17.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "TestViewController.h"
#import "MTDefine.h"
#import "Masonry.h"
#import "IBWebView.h"
#import "TestCell.h"
#import "AFNetworking.h"
#import "TestModel.h"
#import <UITableView+FDTemplateLayoutCell.h>

static NSString *const Cell_UserMain = @"Cell_UserMain";

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *userTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MTHexColor(0xffffff);
    self.arrData = [NSMutableArray array];
    NSLog(@"---- %@", NSHomeDirectory());
    [self createView];
    [self requestData];
    
    
}


- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.zaozuo.com/api/paper/13" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"data"][@"boxCovers"];
        for (NSDictionary *dic in arr) {
            TestModel *model = [[TestModel alloc] initWithDic:dic];
            [self.arrData addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userTableView reloadData];
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



- (void)createView  {
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT ) style:UITableViewStylePlain];
    [self.view addSubview:self.userTableView];
    self.userTableView.backgroundColor = [UIColor clearColor];
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
//    [self.userTableView registerClass:[TestCell class] forCellReuseIdentifier:Cell_UserMain];
    [self.userTableView registerNib:[UINib nibWithNibName:@"TestCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Cell_UserMain];
    self.userTableView.tableFooterView = [[UIView alloc] init];


}

#pragma mark - talbeView delefate 方法
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_UserMain forIndexPath:indexPath];
    cell.fd_enforceFrameLayout = NO;
    cell.model = self.arrData[indexPath.row];
    return cell;
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    TestModel *model = [self.arrData objectAtIndex:indexPath.row];
//    CGRect rect = [model.name boundingRectWithSize:CGSizeMake(SCREENWIDTH - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:25]} context:nil];
//    float h = SCREENWIDTH * model.height / model.width + rect.size.height + 20;
//
//    return h;
    return [tableView fd_heightForCellWithIdentifier:Cell_UserMain cacheByIndexPath:indexPath configuration:^(TestCell *cell) {
        
        cell.model = self.arrData[indexPath.row];
    }];
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
