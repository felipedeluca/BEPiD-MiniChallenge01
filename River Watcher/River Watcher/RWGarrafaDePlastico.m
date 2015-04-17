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
        self = [ RWGarrafaDePlastico spriteNodeWithImageNamed: @"lixo1" ];
        
        self.objTexture = [ SKTexture textureWithImageNamed: @"lixo1" ];
        
        [ self setScale: 0.3 ];
        self.zPosition = 5.5;
        
        self.name = @"[WLGarrafaPlastico]";
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"lixo1" ] size: self.size ];
        self.physicsBody.dynamic           = YES;
        self.physicsBody.affectedByGravity = YES;
    }
    
    return self;
}
//----------------------------------------------------------
@end
