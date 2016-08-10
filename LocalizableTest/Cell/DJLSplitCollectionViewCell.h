//
//  DJLSplitCollectionViewCell.h
//  LocalizableTest
//
//  Created by cz on 16/7/26.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJLSplitCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *titleLabel;

+ (NSString *)cellIdentifier;

@end
