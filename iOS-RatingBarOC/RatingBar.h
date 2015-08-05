//
//  RatingBar.h
//  iOS-RatingBarOC
//
//  Created by 鲁鑫 on 8/3/15.
//  Copyright (c) 2015 luxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingBar;

@protocol RatingBarDelegate<NSObject>

- (void)rateHasChanged:(RatingBar*)ratingBar value:(CGFloat)value;

@end

@interface RatingBar : UIView

@property (nonatomic, assign) IBInspectable BOOL canAnimate;
@property (nonatomic, assign) IBInspectable BOOL allowDecimalValue;
@property (nonatomic, assign) IBInspectable BOOL isIndicator;

/**
 *  当前的数值
 */
@property (nonatomic, assign) IBInspectable CGFloat rate;
/**
 *  星星个数
 */
@property (nonatomic, assign) IBInspectable NSInteger starNum;
/**
 *  最大值，必须是星星个数倍数
 */
@property (nonatomic, assign) IBInspectable CGFloat maxRate;
/**
 *  动画延时
 */
@property (nonatomic, assign) IBInspectable CGFloat animationInterval;
/**
 *  未被选中时的图片
 */
@property (nonatomic, strong) IBInspectable UIImage *darkStarImg;
/**
 *  选中时的图片
 */
@property (nonatomic, strong) IBInspectable UIImage *lightStarImg;


/**
 *  代理
 */
@property (nonatomic, weak) id<RatingBarDelegate> delegate;

@end
