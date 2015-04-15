//
//  RWCar2.m
//  River Watcher
//
//  Created by Gabriela  Gomes Pires on 15/04/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWCar2.h"

@implementation RWCar2

-(instancetype)init {
    
    if ( self = [super init]){
       // self = [ RWAutomobile spriteNodeWithImageNamed: @"carro1" ];
        
        self.objTexture = [ SKTexture textureWithImageNamed: @"carro2" ];
        [self setTexture:self.objTexture];
        
        [ self setScale: 0.8 ];
        self.zPosition = 5.5;
        
        self.name = @"[Automovel 2]";
        self.physicsBody = [SKPhysicsBody bodyWithTexture: self.objTexture size: self.size];
        self.physicsBody.dynamic           = NO;
        self.physicsBody.affectedByGravity = NO;
        
        self.atirouObjeto = FALSE;
        self.positionOffset = 50;
    }
        
    return self;
}


@end
