//
//  LevelOne.m
//  SKTutorial
//
//  Created by Emerson Carvalho on 6/15/14.
//  Copyright (c) 2014 Emerson Carvalho. All rights reserved.
//

#import "LevelOneScene.h"

@interface LevelOneScene()

// private property
@property BOOL contentCreated;

@end

@implementation LevelOneScene

-(void)didMoveToView:(SKView *)view
{
    if(!self.contentCreated){
        [self createSceneContents];
        self.contentCreated = YES;
    }
}


-(void) createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    
    // create a spaceship node
    SKSpriteNode *spaceship = [self newSpaceship];
    int paddingBotton = 20;
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), spaceship.frame.size.height+paddingBotton);
    [self addChild:spaceship];
    
    
    // create rocks
    SKAction *makeRocks = [SKAction sequence:@[
                                               [SKAction performSelector:@selector(addRock) onTarget:self],
                                               [SKAction waitForDuration:0.03 withRange:0.6]]];
    
    // tell the scene to create the rocks
    [self runAction:[SKAction repeatActionForever:makeRocks]];
    
}

static inline CGFloat skRandf(){
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high){
    return skRandf() * (high -low) +low;
}


-(void) addRock
{
    SKColor *rockColor = nil;
    
    // generates a random number 1 or 2
    int rand = arc4random_uniform(5) + 1;
    
    switch (rand) {
        case 1:
            rockColor = [SKColor purpleColor];
            break;
        case 2:
            rockColor = [SKColor yellowColor];
            break;
        case 3:
            rockColor = [SKColor whiteColor];
            break;
        case 4:
            rockColor = [SKColor magentaColor];
            break;
        case 5:
            rockColor = [SKColor blueColor];
            break;
            
        default:
            rockColor = [SKColor redColor];
            break;
    }
    
    
    // basic node create
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor: rockColor size:CGSizeMake(12,12)];
    
    rock.position = CGPointMake( skRand(0, self.size.width), self.size.height+10);
    rock.name = @"rock";
    
    // add physics to the node
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
   
    
    [self addChild:rock];
}





- (void) didSimulatePhysics
{
    // remove rocks that are off screen (y < 0)
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop){
        if(node.position.y < 0){
            [node removeFromParent];
        }
    }];
    
}

-(SKSpriteNode *) newSpaceship
{
    // make the hull
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(45,15)];
    
    // add physisc
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: hull.size];
    hull.physicsBody.dynamic = NO; // prevent space ship to fall down by gravity
    
    //create actions for hull
    NSLog(@"%f",-(hull.frame.size.width/2));
    
    SKAction *wait = [SKAction waitForDuration:1.0];
    SKAction *moveRight = [SKAction moveByX: (hull.frame.size.width*2) y:0 duration:0.5];
    SKAction *moveLeft = [SKAction moveByX: -(hull.frame.size.width*2) y:0 duration:0.5];

    SKAction *hover = [SKAction sequence:@[wait, moveLeft, wait, moveRight, wait, moveRight, wait, moveLeft]];
    
    // perform sequence forever
    [hull runAction:[SKAction repeatActionForever: hover]];
    
    // make light nodes for spaceship
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake( -(hull.frame.size.width/2)+(light1.frame.size.width/2), 0.0);
    [hull addChild:light1];
    
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake((hull.frame.size.width/2)+(light1.frame.size.width/2),0.0);
    [hull addChild:light2];
    
    return hull;
}

-(SKSpriteNode *) newLight
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(8,15)];
    
    // blinking action
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.25];
    SKAction *fadeIn =  [SKAction fadeInWithDuration:0.25];
    SKAction *blink = [SKAction sequence:@[fadeOut,fadeIn]];
    
    [light runAction:[SKAction repeatActionForever:blink]];
    
    return light;
}


@end
