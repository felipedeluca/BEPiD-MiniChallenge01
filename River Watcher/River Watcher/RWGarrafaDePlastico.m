//
//  RWGarrafaDePlastico.m
//  River Watcher
//
//  Created by Gabriela  Gomes Pires on 15/04/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWGarrafaDePlastico.h"

@implementation RWGarrafaDePlastico
//----------------------------------------------------------
-(instancetype)init {
    
    if ( self = [super init]){
        self = [ RWGarrafaDePlastico spriteNodeWithImageNamed: @"garafadeplastico" ];
        
        self.objTexture = [ SKTexture textureWithImageNamed: @"garafadeplastico" ];
        
        [ self setScale: 0.3 ];
        self.zPosition = 5.5;
        
        self.name = @"[WLGarrafaPlastico]";
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"garafadeplastico" ] size: self.size ];
        self.physicsBody.dynamic           = YES;
        self.physicsBody.affectedByGravity = YES;
    }
    
    return self;
}
//----------------------------------------------------------
@end
