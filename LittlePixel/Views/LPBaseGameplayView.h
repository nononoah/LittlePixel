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
    int _difficultyIncrementer;
    NSTimer *_spawnTimer;
}

@property (nonatomic, retain) NSMutableArray *arrayOfLittleDeath;
@property (nonatomic, retain) LPLittlePixel *littlePixel;
@property (nonatomic, retain) LPBaseGameplayViewController *controller;


- (id) initWithFrame: (CGRect) frame andController: (LPBaseGameplayViewController *) inController;
- (void) surviving: (CADisplayLink *) displayLink;

@end
