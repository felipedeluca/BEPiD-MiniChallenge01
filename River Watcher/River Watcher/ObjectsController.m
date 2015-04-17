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
-(void)destroyObjectsOffScreen:(SKScene *)scene {
    
    for ( RWBasicObject *obj in [scene children] ){
        if ( (obj.position.x < 0 || obj.position.x > scene.size.width) && (obj.position.y < (scene.size.height - (scene.size.height / 2.00)))){
            if ( [obj isKindOfClass: [RWLixo class]] ){
                NSLog(@"### Removing object: %@", obj.name);
                [ obj removeFromParent ];
            }
        }
    }
    
}
//----------------------------------------------------------
-(void)throwObject:(SKScene *)scene object:(RWBasicObject *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse {
  //  NSLog( @" Throwing: %@", obj );    
    obj.position = parentNode.position;
    [ obj setPosition: CGPointMake( obj.position.x, obj.position.y + 90 ) ];
    //obj.physicsBody.velocity = CGVectorMake(5, -30);//parentNode.physicsBody.velocity;
    
    CGFloat objThrowDirectionX = -1.00;

    if ( obj.position.x <= (scene.size.width / 2.00) )
        objThrowDirectionX = 1;

    
    CGFloat dx = throwImpulse * 500 * objThrowDirectionX * ( obj.physicsBody.mass / 1.00 );//cosf(parentNode.zRotation);
    CGFloat dy = throwImpulse * 1000 * ( obj.physicsBody.mass / 1.00 );//sinf(parentNode.zRotation);
 //   NSLog(@"OBJ: %@   yImpulse: %f", obj.name, dy );
    [ obj.physicsBody applyAngularImpulse: (dx / 1000000) * (-1) ];
    [ obj.physicsBody applyForce: CGVectorMake( dx, dy) ];
}
//--------------------------------------------------------------
@end
