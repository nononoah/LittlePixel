//
//  LPBaseGameplayView.m
//  LittlePixel
//
//  Created by Noah Blake on 2/17/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "LPBaseGameplayView.h"

@implementation LPBaseGameplayView

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor blackColor];
        
		//Create the blaster
		_littlePixel = [[UIView alloc] initWithFrame: CGRectMake(40, 300, 30, 30)];
		[_littlePixel setBackgroundColor: [UIColor whiteColor]];
		[self addSubview:_littlePixel];
        
		//Create a target for blasting
		_littleDeath = [[UIView alloc] initWithFrame: CGRectMake(80, 10, 20, 20)];
		[_littleDeath setBackgroundColor: [UIColor redColor]];
		[self addSubview: _littleDeath];
        
		//target initially moves to lower right.
		_dx = 2;
		_dy = 2;
	}
	return self;
}

- (void) deathRain
{
	CGRect tmpRectNextPosition = _littleDeath.frame;
	tmpRectNextPosition.origin.x += _dx;
    tmpRectNextPosition.origin.y += _dy;
}


- (void) touchesMoved: (NSSet *) inTouches withEvent: (UIEvent *) inEvent {
	UITouch *tmpTouch = [inTouches anyObject];
	CGPoint tmpTouchPoint = [tmpTouch locationInView: self];
	CGFloat tmpxPosition = tmpTouchPoint.x;
    CGFloat tmpyPosition = tmpTouchPoint.y;
	
	//Don't let little pixel escape the view
	CGFloat halfOfLittlePixelx = _littlePixel.bounds.size.width / 2;
    //don't fly off the left, little pixel gets what's bigger, the functional left edge, or the x-position. Gets x-position if it's not off the screen.
	tmpxPosition = MAX(tmpxPosition, halfOfLittlePixelx);
	tmpxPosition = MIN(tmpxPosition, self.bounds.size.width - halfOfLittlePixelx); //don't fly off the right
    
    CGFloat halfOfLittlePixely = _littlePixel.bounds.size.height / 2;
    //not off the top
    tmpyPosition = MAX(tmpyPosition, halfOfLittlePixely);
    //not off the bottom
	tmpyPosition = MIN(tmpyPosition, self.bounds.size.height - halfOfLittlePixely - [[UIApplication sharedApplication] statusBarFrame].size.height);
	
	_littlePixel.center = CGPointMake(tmpxPosition, tmpyPosition);
	[self deathRain];
}

- (void) surviving: (CADisplayLink *) displayLink {
	_littleDeath.center = CGPointMake(_littleDeath.center.x + _dx, _littleDeath.center.y + _dy);
	[self deathRain];
}

@end
