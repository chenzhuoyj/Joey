//
//  DJLFolderCoverView.h
//  rest-mvvm
//
//  Created by cz on 16/4/21.
//  Copyright © 2016年 lizhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJLFolderCoverView : UIControl

@property (strong, nonatomic) UIView *cover;
@property (nonatomic) CGPoint position;
@property (nonatomic, strong) CALayer *highlight;

- (void)setIsTopView:(BOOL)isTop;
- (void)createHighlightWithFrame:(CGRect)aFrame;
- (instancetype)initWithFrame:(CGRect)frame offset:(CGFloat)delta;

@end
