//
//  LPBaseGameplayViewController.m
//  LittlePixel
//
//  Created by Noah Blake on 2/17/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

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
    CADisplayLink *displayLink;
}
@end

@implementation LPBaseGameplayViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor: [UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect tmpFrame = {0, 0, self.view.frame.size.width, self.view.frame.size.height};
    LPBaseGameplayView *tmpView = [[LPBaseGameplayView alloc] initWithFrame: tmpFrame andController: self];
    [self.view addSubview: tmpView];
    [tmpView release];
	
    CADisplayLink *tmpDisplayLink = [CADisplayLink displayLinkWithTarget: tmpView selector: @selector(surviving:)];
	tmpDisplayLink.frameInterval = 1;
    
	[tmpDisplayLink addToRunLoop: [NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
}

- (void) littlePixelDied
{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //DLog(@"CurrentGameplayView reference count %i", _currentGameplayView.retainCount);
    
    UIButton *tmpRestartButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [tmpRestartButton setFrame: CGRectMake(self.view.center.x - 75, self.view.center.y - 25, 150 , 50)];
    [tmpRestartButton setTitle: @"Little Pixel lives?" forState: UIControlStateNormal];
    [tmpRestartButton setBackgroundColor: [UIColor grayColor]];
    [tmpRestartButton addTarget: self action: @selector(restart:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: tmpRestartButton];
}

- (void) restart: (UIButton *) inSender
{
    [inSender removeFromSuperview];
    
    CGRect tmpFrame = {0, 0, self.view.frame.size.width, self.view.frame.size.height};
    LPBaseGameplayView *tmpView = [[LPBaseGameplayView alloc] initWithFrame: tmpFrame andController: self];
    [self.view addSubview: tmpView];
    [tmpView release];
	
    CADisplayLink *tmpDisplayLink = [CADisplayLink displayLinkWithTarget: tmpView selector: @selector(surviving:)];
	tmpDisplayLink.frameInterval = 1;
    
	[tmpDisplayLink addToRunLoop: [NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [super dealloc];
}

@end
