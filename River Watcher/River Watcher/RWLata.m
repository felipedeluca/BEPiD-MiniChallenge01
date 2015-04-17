//
//  RWLata.m
//  River Watcher
//
//  Created by Gabriela  Gomes Pires on 15/04/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWLata.h"

@implementation RWLata
//----------------------------------------------------------
-(instancetype)init {
    
    if ( self = [super init]){
        self = [ RWLata spriteNodeWithImageNamed: @"lixo3" ];
        
        self.objTexture = [ SKTexture textureWithImageNamed: @"lixo3" ];
        
        [ self setScale: 0.3 ];
        self.zPosition = 5.5;
        
        self.name = @"[WLLata]";
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: self.objTexture size: self.size ];
        self.physicsBody.dynamic           = YES;
        self.physicsBody.affectedByGravity = YES;
        self.physicsBody.linearDamping     = 1.0;
    }
    
    return self;
}
//----------------------------------------------------------
@end
