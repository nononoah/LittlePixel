//
//  LPLittlePixel.h
//  LittlePixel
//
//  Created by Noah Blake on 2/18/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPBaseGameplayView.h"

@interface LPLittlePixel : UIView
{
    LPBaseGameplayView *_gameplayView;
}

- (id)initWithFrame:(CGRect)frame andWithinView: (LPBaseGameplayView *) inView;
@end
