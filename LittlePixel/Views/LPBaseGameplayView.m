//
//  LPBaseGameplayView.m
//  LittlePixel
//
//  Created by Noah Blake on 2/17/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "LPBaseGameplayViewController.h"
#import "LPBaseGameplayView.h"
#import "LPLittlePixel.h"
#import "LPLittleDeath.h"

@implementation LPBaseGameplayView
static LPBaseGameplayViewController *_inController = nil;
static bool _alive = YES;

- (id) initWithFrame: (CGRect) frame andController: (LPBaseGameplayViewController *) inController
{
	self = [super initWithFrame: frame];
	if (self) {
        _inController = inController;
        _frameCounter = 0;
        _alive = YES;
        
		self.backgroundColor = [UIColor blackColor];
        _arrayOfLittleDeath = [[NSMutableArray array] retain];
        
		//Create little pixel
		_littlePixel = [[LPLittlePixel alloc] initWithFrame:  CGRectMake(40, 300, 30, 30) andWithinView: self];
		[self addSubview:_littlePixel];
        
		//Create a little death
		[self addLittleDeath];
        
	}
	return self;
}

- (void) addLittleDeath
{
    LPLittleDeath *tmpLittleDeath = [[[LPLittleDeath alloc] initWithFrame: [LPLittleDeath randomFrame] andWithinView: self] autorelease];
    [tmpLittleDeath setBackgroundColor: [UIColor redColor]];
    [self addSubview: tmpLittleDeath];
    [_arrayOfLittleDeath addObject: tmpLittleDeath];
}

- (void) deathRain
{
    for (LPLittleDeath *tmpLittleDeath in _arrayOfLittleDeath)
    {
        CGRect tmpRectNextPosition = tmpLittleDeath.frame;
        tmpRectNextPosition.origin.x += tmpLittleDeath.dx;
        tmpRectNextPosition.origin.y += tmpLittleDeath.dy;
    
        if (CGRectIntersectsRect(tmpRectNextPosition, _littlePixel.frame))
        {
           //you died
            _alive = NO;
            [_inController littlePixelDied];
        }
    }
}


- (void) surviving: (CADisplayLink *) displayLink
{
    if (_alive)
    {
        for (LPLittleDeath *tmpLittleDeath in _arrayOfLittleDeath)
        {
            //move each little death
            [tmpLittleDeath raining];
        }
    
        //control the rate of death spawn
        _frameCounter++;
        if (_frameCounter == 30)
        {
            [self addLittleDeath];
            _frameCounter -= 30;
        }
    
        [self deathRain];
    }
}

@end
