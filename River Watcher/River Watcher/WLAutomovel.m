//
//  WLCarro1.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "WLAutomovel.h"

@implementation WLAutomovel

-(instancetype)init {
    
    return (WLAutomovel * ) [ self newObject ];
    
}
//----------------------------------------------------------
-(WLAutomovel *)newObject {
    //    self.img = [ [SKSpriteNode alloc] initWithColor: [SKColor grayColor]
    //                                                         size: CGSizeMake(100, 100) ];
    self.img = [ SKSpriteNode spriteNodeWithImageNamed: @"carro1" ];
    [ self.img setScale: 0.8 ];
    self.img.zPosition = 5.5;
    
    self.img.name = @"[Automovel]";
//    self.img.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"garafadevidro" ] size: self.img.size ];
    self.img.physicsBody.dynamic           = NO;
    self.img.physicsBody.affectedByGravity = NO;
    
    self.atirouObjeto = FALSE;
    //self.img.physicsBody.mass = 0.2;
    
    return self;
}
//----------------------------------------------------------
@end
