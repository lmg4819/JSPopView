//
//  JSPopAnimationTool.h
//  Objective
//
//  Created by lmg on 2018/12/21.
//  Copyright © 2018 we. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSPopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSPopAnimationTool : NSObject
+ (CABasicAnimation *)getShowPopAnimationWithType:(PopViewDirection)popDirecton contentView:(UIView *)contentView belowView:(nullable UIView *)belowView;
+ (CABasicAnimation *)getHidenPopAnimationWithType:(PopViewDirection)popDirecton contentView:(UIView *)contentView belowView:(nullable UIView *)belowView;
@end

NS_ASSUME_NONNULL_END
