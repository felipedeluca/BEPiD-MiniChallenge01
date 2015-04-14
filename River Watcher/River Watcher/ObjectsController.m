//
//  ObjetosController.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "ObjectsController.h"

@implementation ObjectsController

//----------------------------------------------------------
-(void)throwObject:(SKSpriteNode *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse {
    //  NSLog( @"Parent %@!", parentNode.physicsBody.velocity );
    
    obj.position = parentNode.img.position;
    obj.physicsBody.velocity = parentNode.img.physicsBody.velocity;
    
    CGFloat dx = throwImpulse * 5;//cosf(parentNode.zRotation);
    CGFloat dy = throwImpulse * 20;//sinf(parentNode.zRotation);
    
    [ obj.physicsBody applyForce: CGVectorMake(dx, dy) ];
}
//--------------------------------------------------------------
@end
