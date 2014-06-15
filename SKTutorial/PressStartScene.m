//
//  PressStart.m
//  SKTutorial
//
//  Created by Emerson Carvalho on 6/15/14.
//  Copyright (c) 2014 Emerson Carvalho. All rights reserved.
//

#import "PressStartScene.h"
#import "LevelOneScene.h"

@interface PressStartScene()

// private property
@property BOOL contentCreated;

@end

@implementation PressStartScene

-(void) didMoveToView:(SKView *)view
{
    if(!self.contentCreated){
        [self createSceneContents];
        self.contentCreated = YES;
    }
}


-(void) createSceneContents
{
    self.backgroundColor = [SKColor redColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    
    
    [self addChild: [self newPressStartNode]];
    
}


-(SKLabelNode *) newPressStartNode
{
    SKLabelNode *pressStartNode = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter"];
    pressStartNode.text = @"Touch to Start";
    pressStartNode.name = @"pressStart";
    pressStartNode.color = [SKColor whiteColor];
    pressStartNode.fontSize = 20;
    pressStartNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    // perform sequence forever
    [pressStartNode runAction:[SKAction repeatActionForever: [self getWaitingAction]]];
    
    return pressStartNode;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *pressStartNode = [self childNodeWithName:@"pressStart"];
    if(pressStartNode != nil){
        pressStartNode.name = nil;
        
        // create the actions
        [pressStartNode removeAllActions];
        
        SKAction *zoomOut = [SKAction scaleTo:0.3 duration:0.8];
        SKAction *fadeAway = [SKAction fadeAlphaTo:0.0 duration:0.8];
        SKAction *goDown = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame), 0.0) duration:0.8];
        SKAction *remove = [SKAction removeFromParent];
        
        SKAction *group = [SKAction group:@[goDown, zoomOut, fadeAway]];
        SKAction *sequence = [SKAction sequence:@[group, remove]];
        
        // run the action and transition to level one.
        [pressStartNode runAction:sequence completion:^{
            SKScene *levelOneScene = [[LevelOneScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:0.5];
            [self.view presentScene:levelOneScene transition:doors];
        }];
        
    }
}

-(SKAction *) getWaitingAction
{
    // create the actions
    SKAction *zoomIn = [SKAction scaleTo:1.05 duration:0.12];
    SKAction *zoomOut = [SKAction scaleTo:1.0 duration:0.08];
    
    SKAction *pause = [SKAction waitForDuration:1];
    
    SKAction *sequence = [SKAction sequence:@[pause, zoomIn, zoomOut, zoomIn, zoomOut, pause]];
    
    return sequence;
}

@end
