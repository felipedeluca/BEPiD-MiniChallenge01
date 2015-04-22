//
//  RWLixo.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/16/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWLixo.h"

@implementation RWLixo
//----------------------------------------------------------
-(instancetype)initWithImageNamed:(NSString *)name{
    
    if ( self = [super init]){
        
        self = [ RWLixo spriteNodeWithImageNamed: name ];
        self.objTexture = [ SKTexture textureWithImageNamed: name ];

        [ self setScale: 0.15 ];
        self.zPosition = 22.0;
        
        self.name = name;
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: self.objTexture size: self.size ];
        self.physicsBody.dynamic           = YES;
        self.physicsBody.affectedByGravity = YES;
        self.physicsBody.linearDamping     = 1.0;
        self.physicsBody.angularDamping    = 1.0;
        self.physicsBody.restitution       = 0.01;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        
        self.isInTheAir = YES;
        //        NSLog(@"OBJ: %@    MASS: %f", self.name, self.physicsBody.mass);
    }
    
    return self;
}
//----------------------------------------------------------
@end
