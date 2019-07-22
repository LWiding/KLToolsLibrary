//
//  UIButton+BlockCallback.h
//  ZTZLDemo
//
//  Created by likuan on 2019/4/18.
//  Copyright © 2019 com.jinher.likuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (BlockCallback)

- (void)addAction:(ButtonBlock)block;

- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
