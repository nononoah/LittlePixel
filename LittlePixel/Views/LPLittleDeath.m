//
//  LPLittleDeath.m
//  LittlePixel
//
//  Created by Noah Blake on 2/18/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "LPLittleDeath.h"
#include <stdlib.h>

@implementation LPLittleDeath

- (id)initWithFrame:(CGRect)frame andWithinView:(LPBaseGameplayView *) inView
{
    self = [super initWithFrame:frame];
    if (self) {
        _gameplayView = inView;
        [self setBackgroundColor: [UIColor redColor]];
        [self randomSpeedForDifficulty: 3];
    }
    return self;
}

- (void) randomSpeedForDifficulty: (int) inDifficulty
{
    //xDirection equal 1 or -1
    int xDirection = 1 - 2 * arc4random_uniform(2);
	self.dx = (inDifficulty - 1) * xDirection;
    self.dy = inDifficulty;

}

- (void) raining
{
	self.center = CGPointMake(self.center.x + self.dx, self.center.y + self.dy);
}

+ (CGRect) randomFrame
{
    CGRect tmpMainScreenRect = [UIScreen mainScreen].bounds;
    CGFloat tmpWidth = arc4random_uniform(16) + 5;
    CGFloat tmpHeight = tmpWidth;
    CGRect rtnRect = CGRectMake(tmpMainScreenRect.size.width - arc4random_uniform(tmpMainScreenRect.size.width +1) + tmpWidth / 2,
                                tmpHeight / 2,
                                tmpWidth,
                                tmpHeight);
    return rtnRect;
}

@end
