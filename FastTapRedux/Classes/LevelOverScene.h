//
//  LevelOverScene.h
//  FastTapRedux
//
//  Created by William Chaney on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface LevelOverLayer : CCLayer {
    
}
@end

@interface LevelOverScene : CCScene {
    LevelOverLayer *levelOverLayer;
    
}

@property (nonatomic, retain) LevelOverLayer *levelOverLayer;

@end
