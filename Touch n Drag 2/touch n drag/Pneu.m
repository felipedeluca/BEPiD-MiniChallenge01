//
//  Ship.m
//  touch n drag
//
//  Created by Kalim on 07/04/15.
//  Copyright (c) 2015 Kalim. All rights reserved.
//

#import "Pneu.h"

@implementation Pneu

-(instancetype)init {
    
    return (Pneu * ) [ self newPneu ];
    
    //return self;
}

-(SKSpriteNode *)newPneu {
    NSLog(@"Novo pneu...");
    //    SKSpriteNode *hull = [ [SKSpriteNode alloc] initWithColor: [SKColor grayColor]
    //                                                         size: CGSizeMake(64, 32) ];
    SKSpriteNode *hull = [ SKSpriteNode spriteNodeWithImageNamed: @"Pneu" ];
    
    
    
        SKAction *hover = [ SKAction sequence: @[
                                                 [SKAction waitForDuration: 1.0],
                                                 [SKAction moveByX: 100 y: 50.0 duration: 1.0],
                                                 [SKAction waitForDuration: 1.0],
                                                 [SKAction moveByX: -100 y: -50.0 duration: 1.0]
                                                 ]
                           ];
    
        [ hull runAction: [SKAction repeatActionForever: hover] ];
    
    
    hull.name = @"Pneu";
    // hull.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize: hull.size ];
    hull.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"Pneu" ] size: hull.size ];
    
    hull.physicsBody.dynamic = NO;
    hull.physicsBody.affectedByGravity = NO;
    
    
    return hull;
}



@end