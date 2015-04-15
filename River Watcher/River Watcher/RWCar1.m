//
//  WLCarro1.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWCar1.h"

@implementation RWCar1


-(instancetype)init {
    
    if ( self = [super init]){

        self.objTexture = [ SKTexture textureWithImageNamed: @"carro1" ];
        [self setTexture:self.objTexture];
        
        [ self setScale: 0.8 ];
        self.zPosition = 5.5;
        
        self.name = @"[Automovel 1]";
        self.physicsBody = [SKPhysicsBody bodyWithTexture: self.objTexture size: self.size];
        self.physicsBody.dynamic           = NO;
        self.physicsBody.affectedByGravity = NO;
        
        self.atirouObjeto = FALSE;
        self.positionOffset = 100;
    }
    
    
    return self;
}

@end
