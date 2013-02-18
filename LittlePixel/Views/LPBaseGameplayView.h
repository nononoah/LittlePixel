//
//  LPBaseGameplayView.h
//  LittlePixel
//
//  Created by Noah Blake on 2/17/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPLittlePixel;
@class LPBaseGameplayViewController;

@interface LPBaseGameplayView : UIView
{
    LPLittlePixel *_littlePixel;
	NSMutableArray *_arrayOfLittleDeath;
    float _dx, _dy;
    int _frameCounter;
}

- (id) initWithFrame: (CGRect) frame andController: (LPBaseGameplayViewController *) inController;
- (void) surviving: (CADisplayLink *) displayLink;
- (void) deathRain;

@end
