//
//  RatingBar.m
//  iOS-RatingBarOC
//
//  Created by 鲁鑫 on 8/3/15.
//  Copyright (c) 2015 luxin. All rights reserved.
//

#import "RatingBar.h"

@interface RatingBar()
/**
 *  是否已经绘制view
 */
@property (nonatomic, assign) BOOL hasDrew;

@property (nonatomic, strong) UIView *backgroundStarView;
@property (nonatomic, strong) UIView *foregroundStarView;

@property (nonatomic, strong) UIPanGestureRecognizer *panGes;

@end

@implementation RatingBar


- (void)buildRatingView {
    if (_hasDrew) {
        return;
    }
    _hasDrew = YES;
    self.foregroundStarView = [self createRatingView:self.lightStarImg];
    self.backgroundStarView = [self createRatingView:self.darkStarImg];
    [self animateStarView];
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    if (!self.isIndicator) {
        self.panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRateView:)];
        _panGes.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:self.panGes];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self buildRatingView];
    NSTimeInterval timeInterVal = self.canAnimate?self.animationInterval:0;
    __block RatingBar *weakSelf = self;
    [UIView animateWithDuration:timeInterVal animations:^{
        [weakSelf animateStarView];
    }];
}


- (UIView*)createRatingView:(UIImage *)image {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (int position = 0; position < self.starNum; ++position) {
        UIImageView *starImgV = [[UIImageView alloc] initWithImage:image];
        starImgV.frame = CGRectMake(position*self.bounds.size.width/_starNum, 0, self.bounds.size.width/_starNum, self.bounds.size.height);
        starImgV.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:starImgV];
    }
    return view;
}


- (void)animateStarView {
    CGFloat realScorePercentage = self.rate / self.maxRate;
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*realScorePercentage, self.bounds.size.height);
}


- (void)panRateView:(UIPanGestureRecognizer *)pan {
    CGPoint panPoint = [pan locationInView:self];
    CGFloat offset = panPoint.x;
    CGFloat realRateScore = offset / self.bounds.size.width * self.maxRate;
    self.rate = self.allowDecimalValue?realRateScore:round(realRateScore);
}

- (void)setRate:(CGFloat)rate {
    _rate = rate;
    if (0 > _rate) {
        _rate = 0;
    }else if(_maxRate < _rate){
        _rate = _maxRate;
    }
    if ([self.delegate respondsToSelector:@selector(rateHasChanged:value:)]) {
        [self.delegate rateHasChanged:self value:_rate];
    }
    [self setNeedsLayout];
}

@end
