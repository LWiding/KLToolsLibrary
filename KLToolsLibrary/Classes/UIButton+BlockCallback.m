//
//  UIButton+BlockCallback.m
//  ZTZLDemo
//
//  Created by likuan on 2019/4/18.
//  Copyright © 2019 com.jinher.likuan. All rights reserved.
//

#import "UIButton+BlockCallback.h"
#import <objc/runtime.h>

@implementation UIButton (BlockCallback)

static char ActionTag;

- (void)addAction:(ButtonBlock)block
{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

- (void)action:(id)sender
{
    ButtonBlock blockAction = (ButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction)
    {
        blockAction(self);
    }
}

@end
