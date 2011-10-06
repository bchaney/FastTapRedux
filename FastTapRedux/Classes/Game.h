//
//  Game.h
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GAME_TIME 20.0

@interface Game : NSObject {
    int totalScore;
    int attempts;
    int hits;
    float timeLeft;
}

@property (assign) int totalScore, attempts, hits;
@property (assign) float timeLeft;

-(void)reset;
@end
