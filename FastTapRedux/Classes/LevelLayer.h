//
//  LevelLayer.h
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
@class GameScene;

@interface LevelLayer : CCLayer {

    CCAction *growAndShrink;
    GameScene *parentGameScene;
    
    NSMutableArray *targetList;
}

@property (nonatomic, retain) NSMutableArray    *targetList;
@property (nonatomic, retain) GameScene         *parentGameScene;

-(void)reset;
-(void)startLevel;
-(void)stopLevel;

@end
