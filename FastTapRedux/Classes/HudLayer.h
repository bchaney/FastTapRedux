//
//  HudLayer.h
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface HudLayer : CCLayer {
    CCProgressTimer *timeLeftBar;
}

@property (nonatomic, retain) CCProgressTimer *timeLeftBar;

-(void)reset;
-(void)updateProgressBar:(float)percentLeft;

@end
