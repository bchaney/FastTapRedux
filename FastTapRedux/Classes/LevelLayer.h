//
//  LevelLayer.h
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
@class GameScene;
@class Level;

@interface LevelLayer : CCLayer {
    GameScene *parentGameScene;
    
    NSMutableArray *targetList;
}

@property (nonatomic, retain) NSMutableArray    *targetList;
@property (nonatomic, retain) GameScene         *parentGameScene;

-(void)reset;
-(void)startWithLevel:(Level *)level;
-(void)stopLevel;

@end
