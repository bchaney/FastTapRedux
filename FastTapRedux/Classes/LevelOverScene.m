//
//  LevelOverScene.m
//  FastTapRedux
//
//  Created by William Chaney on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelOverScene.h"
#import "Level.h"
#import "Game.h"
#import "GameScene.h"

@implementation LevelOverLayer
@synthesize bigTarget, totalScoreLabel, levelScoreLabel, gameScene, gameOverLabel;

-(void)addScoresFromLevel:(int)lvlScore toGame:(Game *)game {
    
    NSLog(@"in func");
    NSString *scoreString;
    scoreString = [NSString stringWithFormat:@"%d", lvlScore];
    [self.levelScoreLabel setString:scoreString];
    game.totalScore += lvlScore;
    scoreString = [NSString stringWithFormat:@"%d", game.totalScore];
    [self.totalScoreLabel setString:scoreString];
//    while(lvlScore > 0) {
//        lvlScore -= 1;
//        NSLog(@"%d", lvlScore);
//        game.totalScore += 5;
//        scoreString = [NSString stringWithFormat:@"%d", lvlScore];
//        [self.levelScoreLabel setString:scoreString];
//        scoreString = [NSString stringWithFormat:@"%d", game.totalScore];
//        [self.totalScoreLabel setString:scoreString];
//    }

}
-(void)createFromLevel:(Level *)level fromGame:(Game *)game {
    for (id hit in level.hitLocations) {
        CCSprite *hitSprite = [CCSprite spriteWithFile:@"hit_sprite.png"];
        CGPoint p = [hit CGPointValue];
        NSLog(@"Hit. (%f, %f)", p.x, p.y);
        hitSprite.position = ccp(p.x + self.bigTarget.position.x*self.bigTarget.scaleX, p.y + self.bigTarget.position.y*self.bigTarget.scaleY);
        [self addChild:hitSprite];
    }
    double totalRxnTime;
    for (id rxn in level.rxnTime) {
        totalRxnTime += [rxn doubleValue];
    }
    int lvlScore = (level.numberHits * 10) + ((level.numberAttempts - level.numberHits) * -10);
    NSLog(@"Avg Rxn: %f", totalRxnTime / level.numberHits);
    NSString *scoreString = [NSString stringWithFormat:@"%d", lvlScore];
    [self.levelScoreLabel setString:scoreString];
    scoreString = [NSString stringWithFormat:@"%d", game.totalScore];
    [self.totalScoreLabel setString:scoreString];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    NSLog(@"lives = %d", game.lives);
    if (game.lives > 0) {
        CCMenuItemLabel *nextLevelMenuLabel = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Next Level" fontName:@"Helvetica" fontSize:20]
                                                                  target:self.gameScene 
                                                                selector:@selector(nextLevel)];
        CCMenu *menu = [CCMenu menuWithItems:nextLevelMenuLabel, nil];
        menu.position = ccp(winSize.width/2, 100);
        [self addChild:menu];
    }
    else {
        CCMenuItemLabel *nextLevelMenuLabel = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Replay?" fontName:@"Helvetica" fontSize:20]
                                                                  target:self.gameScene 
                                                                selector:@selector(startGame)];
        CCMenu *menu = [CCMenu menuWithItems:nextLevelMenuLabel, nil];
        menu.position = ccp(winSize.width/2, 100);
        [self addChild:menu];
        [self addChild:self.gameOverLabel];
    }
}

-(id)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.bigTarget = [CCSprite spriteWithFile:@"Target.png"];
        bigTarget.position = ccp(self.bigTarget.contentSize.width/2, winSize.height/2);
        [self addChild:self.bigTarget];
        
        CCLabelTTF *levelScore = [CCLabelTTF labelWithString:@"Level Score:" fontName:@"Helvetica" fontSize:20];
        CCLabelTTF *totalScore = [CCLabelTTF labelWithString:@"Total Score:" fontName:@"Helvetica" fontSize:20];
        
        self.gameOverLabel = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Helvetica" fontSize:40];
        self.gameOverLabel.position = ccp(winSize.width/2, 290);
        
        self.levelScoreLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:20];
        self.totalScoreLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:20];
        
        levelScore.position = ccp(winSize.width/2, winSize.height/2);
        totalScore.position = ccp(winSize.width/2, levelScore.position.y - 30);
        self.levelScoreLabel.position = ccp(levelScore.position.x + levelScore.contentSize.width/2 + 20, levelScore.position.y);
        self.totalScoreLabel.position = ccp(totalScore.position.x + totalScore.contentSize.width/2 + 20, totalScore.position.y);
        
        [self addChild:levelScore];
        [self addChild:totalScore];
        [self addChild:self.levelScoreLabel];
        [self addChild:self.totalScoreLabel];
        

        
        
    }
    return self;
}

@end

@implementation LevelOverScene
@synthesize levelOverLayer, gameScene;
-(void)addScoresFromLevel:(int)lvlScore toGame:(Game *)game {
    [self.levelOverLayer addScoresFromLevel:lvlScore toGame:game];
}

-(void)createFromLevel:(Level *)level fromGame:(Game *)game {
    NSLog(@"LevelOverScene createFromLevel");
    self.levelOverLayer.gameScene = self.gameScene;
    [self.levelOverLayer createFromLevel:level fromGame:game];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.levelOverLayer = [LevelOverLayer node];
        [self addChild:self.levelOverLayer];
    }
    
    return self;
}

@end
