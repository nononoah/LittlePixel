//
//  LPBaseGameplayViewController.m
//  LittlePixel
//
//  Created by Noah Blake on 2/17/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "LPBaseGameplayViewController.h"
#import "LPBaseGameplayView.h"

@interface LPBaseGameplayViewController ()
{
    CADisplayLink *_displayLink;
}
@end

@implementation LPBaseGameplayViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect tmpFrame = {0, 0, 320, 480};
    LPBaseGameplayView *tmpLevelOneView = [[LPBaseGameplayView alloc] initWithFrame: tmpFrame];
    [self.view addSubview: tmpLevelOneView];
    [tmpLevelOneView release];
	
    _displayLink = [CADisplayLink displayLinkWithTarget: tmpLevelOneView selector: @selector(surviving:)];
	_displayLink.frameInterval = 1;
    
	NSRunLoop *loop = [NSRunLoop currentRunLoop];
	[_displayLink addToRunLoop: loop forMode: NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    NSRunLoop *tmpCurrentLoop = [NSRunLoop currentRunLoop];
	[_displayLink removeFromRunLoop: tmpCurrentLoop forMode: NSDefaultRunLoopMode];
    [super dealloc];
}

@end
