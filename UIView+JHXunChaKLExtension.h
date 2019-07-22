//
//  UIView+JHXunChaKLExtension.h
//  ZTZLDemo
//
//  Created by likuan on 2019/3/9.
//  Copyright © 2019 com.jinher.likuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JHXunChaKLExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

- (void)changePoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
