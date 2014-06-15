//
//  ViewController.m
//  SKTutorial
//
//  Created by Emerson Carvalho on 6/15/14.
//  Copyright (c) 2014 Emerson Carvalho. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "PressStartScene.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewWillAppear:(BOOL)animated
{
    // display a scene
    PressStartScene *pressStart = [[PressStartScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene:pressStart];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // configure a SKView with debug information
    SKView *spriteView = (SKView *) self.view;
    
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
