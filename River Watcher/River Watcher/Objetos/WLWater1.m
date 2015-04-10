//
//  Water.m
//  SpriteWalkthrough
//
//  Created by Felipe R. de Luca on 4/7/15.
//  Copyright (c) 2015 Felipe R. de Luca. All rights reserved.
//

#import "WLWater1.h"

@implementation WLWater1


//----------------------------------------------------------
-(instancetype)init {
    
    return (WLWater1 * ) [ self newWater ];

}
//----------------------------------------------------------
-(WLWater1 *)newWater {
    self.img = [ SKSpriteNode spriteNodeWithImageNamed: @"agua1" ];
    self.img.name = @"water";
    self.img.zPosition = 5.0;
    [ self.img setScale: 0.5 ];
    
    self.img.physicsBody.dynamic = NO;
    self.img.alpha = 0.5;
    
    return self;
}
//----------------------------------------------------------

@end
