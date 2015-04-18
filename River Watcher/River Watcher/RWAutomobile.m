//
//  WLCarro1.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWAutomobile.h"

@implementation RWAutomobile

//----------------------------------------------------------
-(instancetype)init {

    if ( self = [super init]){
        self = [ RWAutomobile spriteNodeWithImageNamed: @"carro1" ];
        
        self.objTexture = [ SKTexture textureWithImageNamed: @"carro1" ];
        
        [ self setScale: 0.8 ];
        self.zPosition = 5.5;
        
        self.name = @"[Automovel]";
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: self.objTexture size: self.size ];
        self.physicsBody.dynamic           = NO;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        
        self.atirouObjeto = FALSE;
    }
    
    return self;
}
//----------------------------------------------------------
@end
