//
//  RWMadeira.m
//  River Watcher
//
//  Created by Gabriela  Gomes Pires on 15/04/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWMadeira.h"

@implementation RWMadeira
//----------------------------------------------------------
-(instancetype)init {
    
    if ( self = [super init]){
        self = [ RWMadeira spriteNodeWithImageNamed: @"madeira" ];
        
        self.objTexture = [ SKTexture textureWithImageNamed: @"madeira" ];
        
        [ self setScale: 0.3 ];
        self.zPosition = 5.5;
        
        self.name = @"[WLMadeira]";
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"madeira" ] size: self.size ];
        self.physicsBody.dynamic           = YES;
        self.physicsBody.affectedByGravity = YES;
    }
    
    return self;
}
//----------------------------------------------------------
@end
