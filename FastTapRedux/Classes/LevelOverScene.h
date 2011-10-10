//
//  LevelOverScene.h
//  FastTapRedux
//
//  Created by William Chaney on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
@class Level;
@class Game;
@class GameScene;

@interface LevelOverLayer : CCLayer {
    CCSprite *bigTarget;
    CCLabelTTF *totalScoreLabel;
    CCLabelTTF *levelScoreLabel;
    GameScene *gameScene;
    CCLabelTTF *gameOverLabel;


}
@property (nonatomic, retain) CCSprite *bigTarget;
@property (nonatomic, retain) CCLabelTTF *totalScoreLabel, *levelScoreLabel, *gameOverLabel;
@property (nonatomic, retain) GameScene *gameScene;

-(void)addScoresFromLevel:(int)lvlScore toGame:(Game *)game;
-(void)createFromLevel:(Level *)level fromGame:(Game *)game;
@end

@interface LevelOverScene : CCScene {
    LevelOverLayer *levelOverLayer;
    GameScene *gameScene;
    
}

@property (nonatomic, retain) LevelOverLayer *levelOverLayer;
@property (nonatomic, retain) GameScene *gameScene;

-(void)addScoresFromLevel:(int)lvlScore toGame:(Game *)game;
-(void)createFromLevel:(Level *)level fromGame:(Game *)game;
@end
