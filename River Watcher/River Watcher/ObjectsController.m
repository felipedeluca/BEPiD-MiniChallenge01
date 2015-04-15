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
-(void)throwObject:(RWBasicObject *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse {
    NSLog( @" Throwing: %@", obj );
    
    obj.position = parentNode.position;
    [ obj setPosition: CGPointMake( obj.position.x, obj.position.y + 50 ) ];
    //obj.physicsBody.velocity = CGVectorMake(5, -30);//parentNode.physicsBody.velocity;
    
    CGFloat dx = throwImpulse * 5;//cosf(parentNode.zRotation);
    CGFloat dy = throwImpulse * 20;//sinf(parentNode.zRotation);
    
    [ obj.physicsBody applyForce: CGVectorMake(dx, dy) ];
}
//--------------------------------------------------------------
@end
