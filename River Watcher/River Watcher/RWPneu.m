//
//  RWPneu.m
//  River Watcher
//
//  Created by Gabriela  Gomes Pires on 15/04/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWPneu.h"

@implementation RWPneu
//----------------------------------------------------------
-(instancetype)init {
    
    if ( self = [super init]){
        self = [ RWPneu spriteNodeWithImageNamed: @"pneu" ];
        
        self.objTexture = [ SKTexture textureWithImageNamed: @"pneu" ];
        
        [ self setScale: 0.3 ];
        self.zPosition = 5.5;
        
        self.name = @"[WLPneu]";
        self.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"pneu" ] size: self.size ];
        self.physicsBody.dynamic           = YES;
        self.physicsBody.affectedByGravity = YES;
    }
    
    return self;
}
//----------------------------------------------------------

@end
