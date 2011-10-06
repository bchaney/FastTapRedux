//
//  MainMenuScene.m
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "AppDelegate.h"

@implementation MainMenuLayer

@synthesize menu;

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        
        // Setup and position main logo
        CCSprite *logoSprite = [CCSprite spriteWithFile:@"FastTapLogo.png"];
        logoSprite.anchorPoint = ccp(0.5, 1);
        logoSprite.position = ccp(winSize.width/2, winSize.height);
        
        // Load the individual menu sprites
        CCSprite *newGameSprite = [CCSprite spriteWithFile:@"NewGame.png"];
        CCSprite *newGameSpriteSelected = [CCSprite spriteWithFile:@"NewGame.png"];
        CCSprite *settingsSprite = [CCSprite spriteWithFile:@"Settings.png"];
        CCSprite *settingsSpriteSelected = [CCSprite spriteWithFile:@"Settings.png"];
        
        CCMenuItemSprite *newGameMenuSprite = [CCMenuItemSprite itemFromNormalSprite:newGameSprite
                                                                      selectedSprite:newGameSpriteSelected 
                                                                              target:delegate 
                                                                            selector:@selector(newGameCallback)];
        
        CCMenuItemSprite *settingsMenuSprite = [CCMenuItemSprite itemFromNormalSprite:settingsSprite 
                                                                       selectedSprite:settingsSpriteSelected];
        
        self.menu = [CCMenu menuWithItems: newGameMenuSprite, settingsMenuSprite, nil];
		[self.menu alignItemsVertically];
        //self.menu.anchorPoint = ccp(0.5, 1.0);
        self.menu.position = ccp(winSize.width/2, 100);
        
        self.isTouchEnabled = YES;
        
        [self addChild:logoSprite];
        [self addChild:self.menu];
    }
    
    return self;
}

@end

@implementation MainMenuScene
@synthesize menuLayer;

-(id)init {
    self =  [super init];
    if (self) {
        self.menuLayer = [MainMenuLayer node];
        [self addChild:self.menuLayer];
    }
    return self;
}
@end
