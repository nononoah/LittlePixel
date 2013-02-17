//
//  LPBaseGameplayView.h
//  LittlePixel
//
//  Created by Noah Blake on 2/17/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPBaseGameplayView : UIView
{
    UIView *_littlePixel;
	UIView *_littleDeath;
	CGFloat _dx, _dy;
}

- (void) surviving: (CADisplayLink *) displayLink;
@end
