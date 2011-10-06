//
//  GameScene.m
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "HudLayer.h"
#import "LevelLayer.h"
#import "Game.h"

@implementation GameScene

@synthesize levelLayer, hudLayer, currentGame;

- (id)init
{
    return [self initWithGame:[[Game alloc] init]];
}

-(id)initWithGame:(Game *)game {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        self.currentGame = [game retain];
        self.levelLayer = [LevelLayer node];
        self.hudLayer = [HudLayer node];
        
        // Set our level layer size to exclude the hudLayer
        CGSize s;
        s.width = winSize.width;
        s.height = winSize.height - (self.hudLayer.timeLeftBar.contentSize.height);
        self.levelLayer.contentSize = s;
        
        self.levelLayer.position = ccp(0, self.hudLayer.timeLeftBar.contentSize.height);
        [self addChild:levelLayer];
        [self addChild:hudLayer z:1];
    }
    
    return self;
}

-(void)reset {
    [self.levelLayer reset];
    [self.hudLayer reset];
    [self.currentGame reset];
    
}

-(void)gameOver {
    NSLog(@"Game Over!");
    [self unscheduleUpdate];
    [self.levelLayer stopLevel];
}

-(void)update:(ccTime)dt {
    self.currentGame.timeLeft = self.currentGame.timeLeft - dt;
    if (self.currentGame.timeLeft <= 0.0) {
        self.currentGame.timeLeft = 0.0;
        [self gameOver];
    }
    float percentLeft = (self.currentGame.timeLeft / GAME_TIME) * 100.0;
    [self.hudLayer updateProgressBar:percentLeft];
}
-(void)startGame {
    [self scheduleUpdate];
    [self.levelLayer startLevel];
}

-(void)onEnter {
    [self startGame];
    [super onEnter];
}
-(void) dealloc {
    [self.currentGame release];
    self.currentGame = nil;
    
    [super dealloc];
}
@end
