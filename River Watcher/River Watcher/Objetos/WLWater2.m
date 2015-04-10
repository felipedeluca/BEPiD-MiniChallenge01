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
    
    return (WLWater2 * ) [ self newWater ];
    
    //return self;
}
//----------------------------------------------------------
-(WLWater2 *)newWater {

    self.img = [ SKSpriteNode spriteNodeWithImageNamed: @"agua2" ];
    [ self.img setScale: 0.5 ];
    
    self.img.physicsBody.dynamic = NO;
    self.img.zPosition = 6.0;
    self.img.alpha     = 0.8;
    self.img.name      = @"water";
    
    return self;
}
//----------------------------------------------------------

@end
