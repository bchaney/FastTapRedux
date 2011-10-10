//
//  GameScene.h
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

// A game is represented by 3 components: Level, Hud, and the Game object
@class LevelLayer;
@class HudLayer;
@class Game;
@class Level;

@interface GameScene : CCScene {
    LevelLayer  *levelLayer;
    HudLayer    *hudLayer;
    Game        *currentGame;
    Level       *currentLevel;
}

@property (nonatomic, retain) LevelLayer    *levelLayer;
@property (nonatomic, retain) HudLayer      *hudLayer;
@property (nonatomic, retain) Game          *currentGame;
@property (nonatomic, retain) Level         *currentLevel;

-(id)initWithGame:(Game *)game;
-(void)startGame;
-(void)nextLevel;
-(void)gameOver;
-(void)reset;

@end
