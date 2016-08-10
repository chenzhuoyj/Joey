//
//  SplitViewController.m
//  LocalizableTest
//
//  Created by cz on 16/7/26.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "SplitViewController.h"
#import "DJLSplitCollectionView.h"
#import "DJLSplitCollectionViewCell.h"
#import <Masonry.h>
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define CELL_WIDTH 76
#define CELL_HEIGHT 60

@interface SplitViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) DJLSplitCollectionView *collectionView;

//显示拆开菜品
@property (nonatomic, strong) UIView *splitView;

@property (nonatomic, strong) UICollectionView *splitCollectionView;

@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Split";
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initViews {
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[DJLSplitCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[DJLSplitCollectionViewCell class] forCellWithReuseIdentifier:[DJLSplitCollectionViewCell cellIdentifier]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    WS(ws);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Split" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(reloadViews) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:1].CGColor;
    button.layer.cornerRadius = 5;
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view).with.offset(0);
    }];

    
    
#pragma mark - split 
    self.splitView = [UIView new];
    self.splitView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    //
    UICollectionViewFlowLayout *splitFlowLayout = [UICollectionViewFlowLayout new];
    splitFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.splitCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:splitFlowLayout];
    [self.splitCollectionView registerClass:[DJLSplitCollectionViewCell class] forCellWithReuseIdentifier:[DJLSplitCollectionViewCell cellIdentifier]];
    self.splitCollectionView.backgroundColor = [UIColor clearColor];
    self.splitCollectionView.showsVerticalScrollIndicator = NO;
    self.splitCollectionView.delegate = self;
    self.splitCollectionView.dataSource = self;
    [self.splitView addSubview:self.splitCollectionView];
    [self.splitCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.splitView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

}

- (void)reloadViews {
    
}

#pragma mark - UICollectionViewDataSource
// --------------------------------------------------------------------------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (collectionView == self.collectionView) {
        count = 20;
    } else {
        count = 4;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (collectionView == self.collectionView) {
        DJLSplitCollectionViewCell *splitCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DJLSplitCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        splitCell.titleLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
        cell = splitCell;
    } else {
        DJLSplitCollectionViewCell *splitCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DJLSplitCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        splitCell.titleLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
        cell = splitCell;
    }
    return cell;
}

// --------------------------------------------------------------------------------------
#pragma mark - collectionView delegate
// --------------------------------------------------------------------------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self calculateCellWidth:SCREEN_WIDTH], CELL_HEIGHT);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(3, 3, 3, 3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView) {
        [self splitAtIndex:indexPath];
    }
}

- (CGFloat)calculateCellWidth:(CGFloat)containerWidth {
    CGFloat maxNum = (containerWidth - 3)/79;
    CGFloat minNum = (containerWidth - 3)/98;
    CGFloat blearWidth;
    if(ceil(minNum) == floor(maxNum)) {
        blearWidth = (containerWidth - 3)/ceil(minNum) - 3;
    } else if (ceil(minNum) > floor(maxNum)) {
        blearWidth = (containerWidth - 3)/floor(maxNum) - 3;
    } else {
        blearWidth = (containerWidth - 3)/floor(maxNum) - 3;
    }
    if (blearWidth < CELL_WIDTH) {
        blearWidth = CELL_WIDTH;
    }
    return floor(blearWidth);
}

#pragma mark - split
- (void)splitAtIndex:(NSIndexPath *)indexPath {
    DJLSplitCollectionView *splitCollectionView;
    UIView *view;
    splitCollectionView = self.collectionView;
    view = self.splitView;
    if (indexPath != nil) {
        CGRect rect = CGRectMake(view.frame.origin.x, view.frame.origin.y, splitCollectionView.frame.size.width, 70);
        view.frame = rect;
        [splitCollectionView openFolderAtIndexPath:indexPath
                                   WithContentView:view
                                         openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                             // opening actions
                                             splitCollectionView.scrollEnabled = NO;
                                             [self.splitCollectionView reloadData];
                                         }
                                        closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                            splitCollectionView.scrollEnabled = YES;
                                            // closing actions
                                        }
                                   completionBlock:^{
                                       // completed actions
                                       splitCollectionView.scrollEnabled = YES;
                                   }];
    } else {
        [self.collectionView closeSplitView];
    }
}

@end
