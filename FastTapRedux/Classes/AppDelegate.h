//
//  AppDelegate.h
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class MainMenuScene;
@class GameScene;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    
    // Scenes the delegate can switch to
    MainMenuScene   *mainMenuScene;
    GameScene       *gameScene;
    
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) MainMenuScene *mainMenuScene;
@property (nonatomic, retain) GameScene     *gameScene;

-(void)newGameCallback;

@end
