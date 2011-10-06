//
//  Game.m
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize totalScore, attempts, hits, timeLeft;

- (id)init
{
    self = [super init];
    if (self) {
        self.totalScore = 0;
        self.attempts = 0;
        self.hits = 0;
        
        self.timeLeft = GAME_TIME;
    }
    
    return self;
}

-(void)reset {
    self.totalScore = 0;
    self.attempts = 0;
    self.hits = 0;
    
    self.timeLeft = GAME_TIME;
}

@end
