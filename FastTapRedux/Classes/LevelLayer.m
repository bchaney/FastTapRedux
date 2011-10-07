//
//  LevelLayer.m
//  FastTapRedux
//
//  Created by William Chaney on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelLayer.h"
#import "GameScene.h"
#import "Game.h"
#import "Level.h"

#define SCALE_FROM_FACTOR   .01
#define SCALE_TO_FACTOR     .5
@implementation LevelLayer

@synthesize targetList, parentGameScene;

-(void)reset {
    
}
-(void)slideAndShow:(id)sender {
    CCProgressTimer *sprite = (CCProgressTimer *)sender;
    sprite.percentage = sprite.percentage + 1;
    sprite.position = ccp(sprite.position.x + sprite.contentSize.width / 100, sprite.position.y);
}
-(void)slideAndHide:(id)sender {
    CCProgressTimer *sprite = (CCProgressTimer *)sender;
    sprite.percentage = sprite.percentage - 2;
    sprite.position = ccp(sprite.position.x - sprite.contentSize.width / 50, sprite.position.y);
}

-(void)animOver:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
}

-(CCAction *)makeRandomGrowAndShrink {
    // Random time for target to grow and shrink
    // Total visible time is 2*time
    float time = (arc4random() % 30)/10.0 + 0.75;
    return [CCSequence actions:
            [CCScaleTo actionWithDuration:time scale:SCALE_TO_FACTOR],
            [CCScaleTo actionWithDuration:time scale:SCALE_FROM_FACTOR],
            [CCCallFuncN actionWithTarget:self selector:@selector(animOver:)],
            nil];
}

// Add a target at a random position on the layer (layer has been adjusted to account for hudLayer)
-(void)addTarget {
    CGSize winSize = self.contentSize;
    CCSprite *target = [CCSprite spriteWithFile:@"Target.png"];
    //CCProgressTimer *t = [CCProgressTimer progressWithFile:@"Target.png"];
    //t.percentage = 0.0;
    //t.type = kCCProgressTimerTypeHorizontalBarRL;
    target.scale = SCALE_FROM_FACTOR;
    
    int minY = (target.contentSize.height*SCALE_TO_FACTOR)/2;
    int maxY = winSize.height - (target.contentSize.height*SCALE_TO_FACTOR)/2;
    int rangeY = maxY - minY;
    int posY = (arc4random() % rangeY) + minY;
    
    int minX = (target.contentSize.width*SCALE_TO_FACTOR)/2;
    int maxX = winSize.width - (target.contentSize.width*SCALE_TO_FACTOR)/2;
    int rangeX = maxX - minX;
    int posX = (arc4random() % rangeX) + minX;
    target.position = ccp(posX, posY);
    //t.position = ccp(posX, posY);
    //NSLog(@"%d, %d", posX, posY);
    [self.targetList addObject:target];
    [self addChild:target];
    [target runAction:[[[self makeRandomGrowAndShrink] copy] autorelease]];
    //[t runAction:[CCSequence actions:
    //              [CCRepeat actionWithAction:[CCCallFuncN actionWithTarget:self selector:@selector(slideAndShow:)] times:100], nil]];
                  //[CCDelayTime actionWithDuration:1.0],
                  //[CCRepeat actionWithAction:[CCCallFuncN actionWithTarget:self selector:@selector(slideAndHide:)] times:50],
                  //[CCCallFuncN actionWithTarget:self selector:@selector(animOver:)], nil]];
    
    //[t runAction:[CCSequence actions:[CCProgressTo actionWithDuration:0.5f
      //                                                        percent:100], nil]];
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    // Since we've moved our layer to adjust for the hudLayer, we want our touches in nodeSpace not screenSpace
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    CCSprite *removeNumber = nil;
    
    // Check if the location of our touch is within the circle of on oef the targets
    for (CCSprite *target in self.targetList) {
        int distX, distY, squareDist, squareRadius;
        squareRadius = target.contentSize.width * target.scaleX/2 * target.contentSize.width * target.scaleY/2;
        distX = target.position.x - location.x;
        distY = target.position.y - location.y;
        squareDist = distX * distX + distY * distY;
        if (squareDist < squareRadius) {
            removeNumber = target;
            break;
        }
        
    }
    CCAction *fadeAndScaleAction = [CCSequence actions:
                                    [CCScaleTo actionWithDuration:0.3 scale:2.0],
                                    [CCFadeOut actionWithDuration:0.3],
                                    [CCCallFuncN actionWithTarget:self selector:@selector(animOver:)],
                                    nil];
    
    // Add or subtract 10 depending on if touch is successful
    if (removeNumber) {
        self.parentGameScene.currentGame.totalScore = self.parentGameScene.currentGame.totalScore + 10;
        
        CCSprite *plus10Sprite = [CCSprite spriteWithFile:@"plus10.png"];
        plus10Sprite.position = location;
        [self addChild:plus10Sprite];
        [self.targetList removeObject:removeNumber];
        [self removeChild:removeNumber cleanup:YES];
        [plus10Sprite runAction:[[fadeAndScaleAction copy] autorelease]];
    }
    else {
        self.parentGameScene.currentGame.totalScore = self.parentGameScene.currentGame.totalScore - 10;
        CCSprite *minus10Sprite = [CCSprite spriteWithFile:@"minus10.png"];
        minus10Sprite.position = location;
        [self addChild:minus10Sprite];
        [minus10Sprite runAction:[[fadeAndScaleAction copy] autorelease]];
    }

}

-(void)stopLevel {
    [self unschedule:@selector(addTarget)];
}
-(void)startWithLevel:(Level *)level {
    NSLog(@"Level Number = %d, spawnRate = %g", level.levelNumber, level.spawnRate);
    [self schedule:@selector(addTarget) interval:level.spawnRate];
}
- (id)init {
    self = [super init];
    if (self) {
        self.targetList = [NSMutableArray array];
        self.parentGameScene = (GameScene *)self.parent;
        self.isTouchEnabled = YES;

    }
    
    return self;
}

@end
