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
        self = [ RWLata spriteNodeWithImageNamed: @"lata" ];
        
        self.objTexture = [ SKTexture textureWithImageNamed: @"lata" ];
        
        [ self setScale: 0.3 ];
        self.zPosition = 5.5;
        
        self.name = @"[WLLata]";
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"lata" ] size: self.size ];
        self.physicsBody.dynamic           = YES;
        self.physicsBody.affectedByGravity = YES;
    }
    
    return self;
}
//----------------------------------------------------------
@end
