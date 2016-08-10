//
//  UIView+DJLScreenshot.h
//  rest-mvvm
//
//  Created by cz on 16/4/21.
//  Copyright © 2016年 lizhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DJLScreenshot)

- (UIImage *)screenshotWithOffset:(CGFloat)deltaY;
- (UIImage *)screenshot;

@end
