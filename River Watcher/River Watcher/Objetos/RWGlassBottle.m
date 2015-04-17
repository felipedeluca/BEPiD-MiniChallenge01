//
//  Lixo.m
//  SpriteWalkthrough
//
//  Created by Felipe R. de Luca on 4/9/15.
//  Copyright (c) 2015 Felipe R. de Luca. All rights reserved.
//

#import "RWGlassBottle.h"

@implementation RWGlassBottle
//----------------------------------------------------------
-(instancetype)init {
    
    if ( self = [super init]){
        self = [ RWGlassBottle spriteNodeWithImageNamed: @"lixo2" ];

        self.objTexture = [ SKTexture textureWithImageNamed: @"lixo2" ];
        
        [ self setScale: 0.3 ];
        self.zPosition = 5.5;
        
        self.name = @"[WLGarrafaVidro]";
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"lixo2" ] size: self.size ];
        self.physicsBody.dynamic           = YES;
        self.physicsBody.affectedByGravity = YES;
    }
    
    return self;
}
//----------------------------------------------------------
@end