//
//  Lixo.m
//  SpriteWalkthrough
//
//  Created by Felipe R. de Luca on 4/9/15.
//  Copyright (c) 2015 Felipe R. de Luca. All rights reserved.
//

#import "WLGarrafaVidro.h"

@implementation WLGarrafaVidro
//----------------------------------------------------------
-(instancetype)init {
    
    return (WLGarrafaVidro * ) [ self newObject ];
    
}
//----------------------------------------------------------
-(WLGarrafaVidro *)newObject {
//    self.img = [ [SKSpriteNode alloc] initWithColor: [SKColor grayColor]
//                                                         size: CGSizeMake(100, 100) ];
    self.img = [ SKSpriteNode spriteNodeWithImageNamed: @"garafadevidro" ];
    [ self.img setScale: 0.3 ];
    self.img.zPosition = 5.5;
    
    self.img.name = @"[WLGarrafaVidro]";
    self.img.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"garafadevidro" ] size: self.img.size ];
    self.img.physicsBody.dynamic           = YES;
    self.img.physicsBody.affectedByGravity = YES;
    //self.img.physicsBody.mass = 0.2;
    
    return self;
}
//----------------------------------------------------------
@end