//
//  UIColor+MCExtension.h
//  MCFoundation
//
//  Created by illScholar on 2019/2/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MCExtension)

/**
 获取颜色

 @param startHex 开始十六进制颜色
 @param endHex 结束十六进制颜色
 @param startAlpha 开始透明度
 @param endAlpha 结束透明度
 @param rate 比例
 @return UIColor
 */
+ (UIColor *)mcCalcLinearGradientColorWithStartHexColor:(NSString *)startHex
                                            endHexColor:(NSString *)endHex
                                             startAlpha:(CGFloat)startAlpha
                                               endAlpha:(CGFloat)endAlpha
                                                   rate:(CGFloat)rate;

/**
 获取颜色

 @param startColor 开始颜色
 @param endColor 结束颜色
 @param startAlpha 开始透明度
 @param endAlpha 结束透明度
 @param rate 比例
 @return UIColor
 */
+ (UIColor *)mcCalcLinearGradientColorWithStartColor:(UIColor *)startColor
                                            endColor:(UIColor *)endColor
                                          startAlpha:(CGFloat)startAlpha
                                            endAlpha:(CGFloat)endAlpha
                                                rate:(CGFloat)rate;

+ (UIColor *)mcColorWithHexValue:(NSUInteger)hex;
+ (UIColor *)mcColorWithHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;
+ (UIColor *)mcColorWithShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;
    
/**
 随机颜色

 @return UIColor
 */
+ (UIColor *)mcRandomColor;

/**
 hex颜色

 @param alpha 透明度
 @param hex 颜色字符串
 @param defaultHex 默认的颜色字符串
 @return UIColor
 */
+ (UIColor *)mcColorWithAlpha:(CGFloat)alpha hexString:(NSString *)hex defaultHexString:(NSString *)defaultHex;

/**
 hex颜色

 @param alpha 透明度
 @param hex 颜色字符串
 @return UIColor
 */
+ (UIColor *)mcColorWithAlpha:(CGFloat)alpha hexString:(NSString *)hex;

/**
 hex颜色

 @param hex 颜色字符串
 @param defaultHex 默认的颜色字符串
 @return UIColor
 */
+ (UIColor *)mcColorWithHexString:(NSString *)hex defaultHexString:(NSString *)defaultHex;

/**
 hex颜色

 @param hex 颜色字符串
 @return UIColor
 */
+ (UIColor *)mcColorWithHexString:(NSString *)hex;

@end

NS_ASSUME_NONNULL_END
