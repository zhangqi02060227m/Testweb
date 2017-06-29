//
//  HotCityCell.m
//  TestWeb
//
//  Created by huangbo on 17/5/19.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "HotCityCell.h"
#import "MTDefine.h"

static NSString *const Coll_UserHotCity = @"Coll_UserHotCity";


@interface HotCityCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HotCityCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake((SCREENWIDTH - 20) / 3, 30);
    self.flowLayout.minimumInteritemSpacing = 0; // 水平方向
    self.flowLayout.minimumLineSpacing = 10; // 垂直方向的space
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.contentView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Coll_UserHotCity];
    self.collectionView.scrollEnabled = NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Coll_UserHotCity forIndexPath:indexPath];
    cell.backgroundColor = MTRandColor;
    return cell;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
