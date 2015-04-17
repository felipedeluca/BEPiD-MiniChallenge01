//
//  Water.m
//  SpriteWalkthrough
//
//  Created by Felipe R. de Luca on 4/7/15.
//  Copyright (c) 2015 Felipe R. de Luca. All rights reserved.
//

#import "RWWater1.h"

@implementation RWWater1


//----------------------------------------------------------
-(instancetype)init {
    
    if ( self == [super init]){
        self = [ RWWater1 spriteNodeWithImageNamed: @"agua1" ];
        self.name = @"water";
        self.zPosition = 5.0;
        [ self setScale: 0.5 ];
        
        self.physicsBody.dynamic = NO;
        self.alpha = 0.7;
    }
    return self;
}
//----------------------------------------------------------
@end
