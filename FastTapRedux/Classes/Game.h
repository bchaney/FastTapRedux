//
//  Game.h
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GAME_TIME 20.0
#define TOTAL_LIVES 3
@interface Game : NSObject {
    int totalScore;
    int attempts;
    int hits;
    int lives;
    float timeLeft;
}

@property (assign) int totalScore, attempts, hits, lives;
@property (assign) float timeLeft;

-(void)reset;
@end
