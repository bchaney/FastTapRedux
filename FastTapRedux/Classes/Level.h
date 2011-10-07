//
//  Level.h
//  FastTapRedux
//
//  Created by William Chaney on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject {
    int levelNumber;
    float spawnRate;
    int numberAttempts;
    int numberHits;
    NSMutableArray *hitLocations;
}

@property (assign) int levelNumber, numberAttempts, numberHits;
@property (assign) float spawnRate;
@property (nonatomic, retain) NSMutableArray *hitLocations;

-(id)initWithLevelNumber:(int)lvlNumber spawnRate:(float)spwnRate;
-(void)reset;
@end
