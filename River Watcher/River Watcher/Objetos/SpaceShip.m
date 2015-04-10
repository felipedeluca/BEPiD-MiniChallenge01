//
//  SpaceShip.m
//  SpriteWalkthrough
//
//  Created by Felipe R. de Luca on 4/5/15.
//  Copyright (c) 2015 Felipe R. de Luca. All rights reserved.
//

#import "SpaceShip.h"

@implementation SpaceShip

//----------------------------------------------------------
-(instancetype)init {
    
    return (SpaceShip * ) [ self newSpaceship ];
    
    //return self;
}
//----------------------------------------------------------
-(SKSpriteNode *)newSpaceship {
    NSLog(@"Nova nave...");
    SKSpriteNode *hull = [ [SKSpriteNode alloc] initWithColor: [SKColor grayColor]
                                                         size: CGSizeMake(100, 100) ];
    //SKSpriteNode *hull = [ SKSpriteNode spriteNodeWithImageNamed: @"Spaceship" ];
    
    SKSpriteNode *light1 = [ self newLight ];
    light1.position = CGPointMake( -28.0, 6.0 );
    
    SKSpriteNode *light2 = [ self newLight ];
    light2.position = CGPointMake( 28.0, 6.0 );
    
    
    SKAction *hover = [ SKAction sequence: @[
                                             [SKAction waitForDuration: 1.0],
                                             [SKAction moveByX: 100 y: 50.0 duration: 1.0],
                                             [SKAction waitForDuration: 1.0],
                                             [SKAction moveByX: -100 y: -50.0 duration: 1.0]
                                             ]
                       ];
    
    [ hull runAction: [SKAction repeatActionForever: hover] ];
    [ hull addChild: light1 ];
    [ hull addChild: light2 ];
    
    [ hull setScale: 0.5 ];
    
   // hull.anchorPoint = CGPointMake( 0.5, 0.5 );

    hull.name = @"Spaceship";
    hull.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize: hull.size ];
    //hull.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"Spaceship" ] size: hull.size ];
    hull.physicsBody.dynamic = NO;
    hull.physicsBody.affectedByGravity = NO;
    

    return hull;
}
//----------------------------------------------------------
-(SKSpriteNode *)newLight {
 
    SKSpriteNode *light = [ [SKSpriteNode alloc] initWithColor: [SKColor yellowColor] size: CGSizeMake( 8, 8)];
    
    SKAction *blink = [ SKAction sequence: @[ [SKAction fadeOutWithDuration: 0.25],
                                              [SKAction fadeInWithDuration: 0.25]
                                             ]
                       ];
    
    SKAction *blinkForever = [ SKAction repeatActionForever: blink ];
    
    [ light runAction: blinkForever ];
    
    return light;
}
//----------------------------------------------------------
@end
