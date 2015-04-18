//
//  Water.m
//  SpriteWalkthrough
//
//  Created by Felipe R. de Luca on 4/7/15.
//  Copyright (c) 2015 Felipe R. de Luca. All rights reserved.
//

#import "WLWater2.h"

@implementation WLWater2

//----------------------------------------------------------
-(instancetype)init {
    
    if ( self = [super init]){
        self = [ WLWater2 spriteNodeWithImageNamed: @"agua2" ];
        [ self setScale: 0.5 ];
        
        self.physicsBody.dynamic = NO;
        self.zPosition = 23.0;
        self.alpha     = 0.7;
        self.name      = @"water";
    }
    
    return self;
}
//----------------------------------------------------------
@end
