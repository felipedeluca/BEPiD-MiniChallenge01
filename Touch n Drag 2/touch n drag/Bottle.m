//
//  Bottle.m
//  touch n drag
//
//  Created by Kalim on 09/04/15.
//  Copyright (c) 2015 Kalim. All rights reserved.
//

#import "Bottle.h"

@implementation Bottle

-(instancetype)init {
    
    return (Bottle * ) [ self newBottle ];
    
    //return self;
}

-(SKSpriteNode *)newBottle {
    NSLog(@"Nova bottle...");
    //    SKSpriteNode *hull = [ [SKSpriteNode alloc] initWithColor: [SKColor grayColor]
    //                                                         size: CGSizeMake(64, 32) ];
    SKSpriteNode *hull = [ SKSpriteNode spriteNodeWithImageNamed: @"Bottle" ];
    
    
    
    SKAction *hover = [ SKAction sequence: @[
                                             [SKAction waitForDuration: 1.0],
                                             [SKAction moveByX: 100 y: 50.0 duration: 1.0],
                                             [SKAction waitForDuration: 1.0],
                                             [SKAction moveByX: -100 y: -50.0 duration: 1.0]
                                             ]
                       ];
    
    [ hull runAction: [SKAction repeatActionForever: hover] ];
    
    
    hull.name = @"Bottle";
    // hull.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize: hull.size ];
    hull.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"Bottle" ] size: hull.size ];
    
    hull.physicsBody.dynamic = NO;
    hull.physicsBody.affectedByGravity = NO;
    
    
    return hull;
}



@end
