//
//  NSString+SizeFitExtension.h
//  GBCheckUpLibrary
//
//  Created by likuan on 2019/3/19.
//  Copyright © 2019 pk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SizeFitExtension)

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  添加行间距并返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *  @param lineSpaceing 行间距
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize andlineSpacing:(CGFloat) lineSpaceing;

/**
 *  自适应图片url
 */
- (NSString *)self_adaptionHost;

- (NSString *)timing;

@end

NS_ASSUME_NONNULL_END
