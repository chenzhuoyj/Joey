//
//  DJLSplitCollectionView.h
//  rest-mvvm
//
//  Created by cz on 16/4/21.
//  Copyright © 2016年 lizhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJLFolderCoverView.h"

@class CAMediaTimingFunction;

typedef void (^FolderCompletionBlock)(void);
typedef void (^FolderCloseBlock)(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction);
typedef void (^FolderOpenBlock)(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction);

@interface DJLSplitCollectionView : UICollectionView

@property (nonatomic, strong) UIBezierPath *triangleMaskPath;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (strong, nonatomic) UIView *subClassContentView;

- (void)openFolderAtIndexPath:(NSIndexPath *)indexPath
              WithContentView:(UIView *)subClassContentView
                    openBlock:(FolderOpenBlock)openBlock
                   closeBlock:(FolderCloseBlock)closeBlock
              completionBlock:(FolderCompletionBlock)completionBlock;

- (void)closeSplitView;

@property (nonatomic, strong) DJLFolderCoverView *top, *bottom;
@property (nonatomic) CGPoint oldTopPoint, oldBottomPoint, oldTrianglePoint;
@property (nonatomic) CGPoint oldContentOffset;
@property (nonatomic) BOOL closing;
@property (nonatomic) CGFloat offsetY;
@property (nonatomic, copy) FolderOpenBlock openBlock;
@property (nonatomic, copy) FolderCloseBlock closeBlock;
@property (nonatomic, copy) FolderCompletionBlock completionBlock;

@end
