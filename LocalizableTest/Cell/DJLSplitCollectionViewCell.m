//
//  DJLSplitCollectionViewCell.m
//  LocalizableTest
//
//  Created by cz on 16/7/26.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "DJLSplitCollectionViewCell.h"
#import <Masonry.h>
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

@implementation DJLSplitCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 4.0;
        self.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment  = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        WS(ws);

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}


+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
