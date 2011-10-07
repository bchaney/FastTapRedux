//
//  HudLayer.m
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"

@implementation HudLayer

@synthesize timeLeftBar, timeLeftOutline;

-(void)updateProgressBar:(float)percentLeft {
    self.timeLeftBar.percentage = percentLeft;
}

-(void)reset {
    
}

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.timeLeftBar = [CCProgressTimer progressWithFile:@"prog_bar_full.png"];
        self.timeLeftBar.type = kCCProgressTimerTypeHorizontalBarLR;
        self.timeLeftBar.percentage = 100.0;
        
        //Want our progress bar to take up 75% of the screen
        self.timeLeftBar.scaleX = 1+(.75-self.timeLeftBar.contentSize.width / winSize.width);
        self.timeLeftBar.position = ccp(self.timeLeftBar.contentSize.width/2, self.timeLeftBar.contentSize.height/2);

        self.timeLeftOutline = [CCSprite spriteWithFile:@"prog_bar_outline.png"];
        self.timeLeftOutline.scaleX = 1+(.75-self.timeLeftBar.contentSize.width / winSize.width);
        self.timeLeftOutline.position = ccp(self.timeLeftBar.contentSize.width/2, self.timeLeftBar.contentSize.height/2);

        
        [self addChild:self.timeLeftBar];
        [self addChild:self.timeLeftOutline];
    }
    
    return self;
}

@end
