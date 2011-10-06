//
//  MainMenuScene.h
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface MainMenuLayer : CCLayer {
    CCMenu *menu;
}

@property (nonatomic, retain) CCMenu *menu;

@end


@interface MainMenuScene : CCScene {
    MainMenuLayer *menuLayer;
}

@property (nonatomic, retain) MainMenuLayer *menuLayer;

@end
