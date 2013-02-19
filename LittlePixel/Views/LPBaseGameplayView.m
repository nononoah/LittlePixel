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

static CADisplayLink *_displayLink;
static int _initCount = 0;
- (id) initWithFrame: (CGRect) frame andController: (LPBaseGameplayViewController *) inController
{
	self = [super initWithFrame: frame];
	if (self) {
        self.controller = inController;
        //_alive = YES;
        //_difficultyIncrementer = 0;
        DLog(@"Init count is %i", ++_initCount);
        //control the rate of little death spawn
        _spawnTimer = [NSTimer scheduledTimerWithTimeInterval: .3 target: self selector: @selector(addLittleDeath) userInfo: nil repeats: YES];
        
		self.backgroundColor = [UIColor clearColor];
        self.arrayOfLittleDeath = [NSMutableArray array];
        [self.arrayOfLittleDeath  removeAllObjects];
        
		//Create little pixel
		self.littlePixel = [[LPLittlePixel alloc] initWithFrame:  CGRectMake(40, 300, 30, 30) andWithinView: self];
		[self addSubview: self.littlePixel];
        [_littlePixel release];
        
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    DLog(@"here");
}

- (void) addLittleDeath
{
    LPLittleDeath *tmpLittleDeath = [[LPLittleDeath alloc] initWithFrame: [LPLittleDeath randomFrame] andWithinView: self];
    [self addSubview: tmpLittleDeath];
    [self bringSubviewToFront: tmpLittleDeath];
    [self.arrayOfLittleDeath addObject: tmpLittleDeath];
    [tmpLittleDeath release];
}


- (void) surviving: (CADisplayLink *) displayLink
{
    _displayLink = displayLink;
    NSMutableArray *tmpCopy = [[NSMutableArray alloc] init];
    tmpCopy = [NSMutableArray arrayWithArray: self.arrayOfLittleDeath];
    for (LPLittleDeath *tmpLittleDeath in self.arrayOfLittleDeath)
    {
        //bounce off side walls if colliding with them
        CGFloat tmpHalfOfLittleDeath = tmpLittleDeath.frame.size.width / 2;
        //going off the right, going off the left, reverse x-direction
        if ( (tmpLittleDeath.layer.frame.origin.x + tmpHalfOfLittleDeath >= self.frame.size.width) || (tmpLittleDeath.layer.frame.origin.x - tmpHalfOfLittleDeath <= 0) )
            tmpLittleDeath.dx *= -1;
        
        //left bottom of frame, remove it from screen and array
        if (!(CGRectIntersectsRect(self.bounds, tmpLittleDeath.layer.frame)))
        {
            [tmpLittleDeath removeFromSuperview];
            [tmpCopy removeObject: tmpLittleDeath];
        }
        
        //a collision, you died - this is pretty impressive. The processor is able to move through the entire array in less than 1/60th of a second, which makes this possible.
        else if (CGRectIntersectsRect(tmpLittleDeath.layer.frame, _littlePixel.layer.frame))
        {
            _displayLink.paused = YES;
            [_displayLink removeFromRunLoop: [NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
            [_displayLink invalidate];
            [_spawnTimer invalidate];
            DLog(@"Array count %d", self.arrayOfLittleDeath.count);
            [self.controller littlePixelDied];
            break;
        }
        
        //move the little death
        else
            [tmpLittleDeath raining];
    }
    self.arrayOfLittleDeath = [NSMutableArray arrayWithArray: tmpCopy];
}



- (void) dealloc
{
    [_littlePixel release];
    [_controller release];
    [_arrayOfLittleDeath release];
    [super dealloc];
}

@end
