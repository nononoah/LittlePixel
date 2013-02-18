//
//  LPLittleDeath.h
//  LittlePixel
//
//  Created by Noah Blake on 2/18/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPBaseGameplayView;

@interface LPLittleDeath : UIView
{
    LPBaseGameplayView *_gameplayView;
}

@property (nonatomic) float dx;
@property (nonatomic) float dy;


- (id)initWithFrame:(CGRect)frame andWithinView:(LPBaseGameplayView *) inView;
- (void) raining;
+ (CGRect) randomFrame;
@end
