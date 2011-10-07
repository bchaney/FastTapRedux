//
//  Level.m
//  FastTapRedux
//
//  Created by William Chaney on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level.h"

@implementation Level

@synthesize levelNumber, spawnRate, numberHits, numberAttempts, hitLocations;

-(id)init {
    return [self initWithLevelNumber:1 spawnRate:2.0];
} 
-(id)initWithLevelNumber:(int)num spawnRate:(float)rate {
    self = [super init];
    if (self) {
        self.levelNumber = num;
        self.spawnRate = rate;
        self.numberAttempts = 0;
        self.numberHits = 0;
        self.hitLocations = [NSMutableArray array];
    }
    
    return self;
}

-(void)reset {
    self.numberAttempts = 0;
    self.numberHits = 0;
    [self.hitLocations removeAllObjects];
}
-(void)dealloc {
    [self.hitLocations release];
    self.hitLocations = nil;
    [super dealloc];
}

@end
