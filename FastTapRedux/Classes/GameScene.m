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
#import "Level.h"
#import "LevelOverScene.h"

@implementation GameScene

@synthesize levelLayer, hudLayer, currentGame, currentLevel;

- (id)init
{
    return [self initWithGame:[[Game alloc] init]];
}

-(id)initWithGame:(Game *)game {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        self.currentLevel = [[Level alloc] init];
        
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
    [self.currentLevel reset];
    [self.levelLayer reset];
    [self.hudLayer reset];
    [self.currentGame reset];
    
}

-(void)levelOver {
    NSLog(@"Level Over!");
    [self.levelLayer stopLevel];
    [self unscheduleUpdate];
    LevelOverScene *levelOverScene = [LevelOverScene node];
    levelOverScene.gameScene = self;
    [[CCDirector sharedDirector] replaceScene:levelOverScene];
    [levelOverScene createFromLevel:self.currentLevel fromGame:self.currentGame];
    int lvlScore = (self.currentLevel.numberHits * 10) + ((self.currentLevel.numberAttempts - self.currentLevel.numberHits) * -10);
    [levelOverScene addScoresFromLevel:lvlScore toGame:self.currentGame];


}
-(void)gameOver {
    NSLog(@"Game Over!");
    [self levelOver];
}

-(void)update:(ccTime)dt {
    self.currentGame.timeLeft = self.currentGame.timeLeft - dt;
    if (self.currentGame.timeLeft <= 0.0) {
        self.currentGame.timeLeft = 0.0;
        [self levelOver];
    }
    float percentLeft = (self.currentGame.timeLeft / GAME_TIME) * 100.0;
    [self.hudLayer updateProgressBar:percentLeft];
}

-(void)startGame {
    [[CCDirector sharedDirector] replaceScene:self];
    [self reset];
    [self scheduleUpdate];
    [self.levelLayer startWithLevel:self.currentLevel];
}

-(void)nextLevel {
    NSLog(@"BABOOM");
    self.currentGame.timeLeft = GAME_TIME;
    [self.hudLayer updateProgressBar:100.0];
    [[CCDirector sharedDirector] replaceScene:self];
    Level *newLevel = [[Level alloc] initWithLevelNumber:self.currentLevel.levelNumber+1 spawnRate:self.currentLevel.spawnRate-0.2];
    self.currentLevel = newLevel;
    [self.levelLayer reset];
    [self scheduleUpdate];
    [self.levelLayer startWithLevel:self.currentLevel];
}

-(void)onEnter {
    [super onEnter];
}

-(void) dealloc {
    [self.currentGame release];
    self.currentGame = nil;
    [self.currentLevel release];
    self.currentLevel = nil;
    
    [super dealloc];
}
@end
