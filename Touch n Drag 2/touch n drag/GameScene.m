//
//  GameScene.m
//  touch n drag
//
//  Created by Kalim on 07/04/15.
//  Copyright (c) 2015 Kalim. All rights reserved.
//

#import "GameScene.h"
#import "ShipScene.h"


@interface GameScene()

@property BOOL contentCreated;

@end

@implementation GameScene


-(SKLabelNode *)newHelloNode{
    SKLabelNode * helloNode = [ SKLabelNode labelNodeWithFontNamed: @"Chalduster" ];
    
    helloNode.text = @"Hello World!";
    helloNode.fontSize = 42;
    helloNode.position = CGPointMake( CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) );
    helloNode.name     = @"helloNode";
    
    return helloNode;
}
//------------------------------------------------------------------------
-(void)createSceneContents{
    
    self.backgroundColor = [ SKColor redColor ];
    self.scaleMode       = SKSceneScaleModeAspectFill;
    [ self addChild: [self newHelloNode] ];
}
//------------------------------------------------------------------------
-(void)didMoveToView:(SKView *)view {
    
    if ( !self.contentCreated ){
        [ self createSceneContents ];
        self.contentCreated = TRUE;
    }
}
//------------------------------------------------------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    SKNode *helloNode = [ self childNodeWithName: @"helloNode" ];
    
    if ( helloNode != nil ){
        
        helloNode.name = nil;
        SKAction *moveUp   = [ SKAction moveByX: 0
                                              y: 100.0
                                       duration: 0.5  ];
        
        SKAction *zoom     = [ SKAction scaleTo: 2.0
                                       duration: 0.25];
        
        SKAction *pause    = [ SKAction waitForDuration: 0.5 ];
        
        SKAction *fadeAway = [ SKAction fadeOutWithDuration: 0.25 ];
        
        SKAction *remove   = [ SKAction removeFromParent ];
        
        SKAction *moveSequence = [ SKAction sequence: @[moveUp, zoom, pause, fadeAway, remove] ];
        
        [ helloNode runAction: moveSequence
                   completion: ^{
                       
                       SKScene *spaceshipScene = [ [ShipScene alloc ] initWithSize: CGSizeMake(750, 1334)];
                       SKTransition *doors     = [ SKTransition doorsOpenVerticalWithDuration: 0.5 ];
                       
                       [ self.view presentScene: spaceshipScene
                                     transition: doors ];
                   }];
        
    }
}
//------------------------------------------------------------------------
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


@end
