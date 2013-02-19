//
//  LPLittlePixel.m
//  LittlePixel
//
//  Created by Noah Blake on 2/18/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "LPLittlePixel.h"

@implementation LPLittlePixel

- (id)initWithFrame:(CGRect)frame andWithinView:(LPBaseGameplayView *) inView
{
    self = [super initWithFrame:frame];
    if (self) {
        _gameplayView = inView;
        [self setBackgroundColor: [UIColor blackColor]];
    }
    return self;
}

- (void) touchesMoved: (NSSet *) inTouches withEvent: (UIEvent *) inEvent {
	UITouch *tmpTouch = [inTouches anyObject];
	CGPoint tmpTouchPoint = [tmpTouch locationInView: _gameplayView];
	CGFloat tmpxPosition = tmpTouchPoint.x;
    CGFloat tmpyPosition = tmpTouchPoint.y;
	
	//Don't let little pixel escape the view
	CGFloat halfOfLittlePixelx = self.bounds.size.width / 2;
    //don't fly off the left, little pixel gets what's bigger, the functional left edge, or the x-position. Gets x-position if it's not off the screen.
	tmpxPosition = MAX(tmpxPosition, halfOfLittlePixelx);
	tmpxPosition = MIN(tmpxPosition, _gameplayView.bounds.size.width - halfOfLittlePixelx); //don't fly off the right
    
    CGFloat halfOfLittlePixely = self.bounds.size.height / 2;
    //not off the top
    tmpyPosition = MAX(tmpyPosition, halfOfLittlePixely);
    //not off the bottom
	tmpyPosition = MIN(tmpyPosition, _gameplayView.bounds.size.height - halfOfLittlePixely - [[UIApplication sharedApplication] statusBarFrame].size.height);
	
	self.center = CGPointMake(tmpxPosition, tmpyPosition);
}

- (void) dealloc
{
    [super dealloc];
}

@end
