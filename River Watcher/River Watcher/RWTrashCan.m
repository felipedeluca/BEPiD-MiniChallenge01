//
//  TrashCan.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/13/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWTrashCan.h"

@implementation RWTrashCan
//------------------------------------------------------------------------------------
-(instancetype)init {
    
    if ( self == [super init]){
        self = ( RWTrashCan *) [ self newObject ];
    }
    
    return self;
}
//------------------------------------------------------------------------------------
-(RWTrashCan *)newObject {
    
    SKTexture *trashCanSpriteA = [ SKTexture textureWithImageNamed: @"lixeira" ];
    SKTexture *trashCanSpriteB = [ SKTexture textureWithImageNamed: @"lixeira2" ];
    SKTexture *trashCanSpriteC = [ SKTexture textureWithImageNamed: @"lixeira3" ];
    
    NSArray *trashCanTextures = @[ trashCanSpriteA,trashCanSpriteB,trashCanSpriteC ];
    self.img = [ SKSpriteNode spriteNodeWithTexture: trashCanSpriteC ];
    self.img.position         = CGPointMake( 200, 130);
    self.img.zPosition        = 1.0;
    //  lixeira.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"lixeira" ] size: lixeira.size ];
    //lixeira.physicsBody.affectedByGravity = NO;
    //   lixeira.physicsBody.allowsRotation    = NO;
    //lixeira.physicsBody.linearDamping     = 0.8;
    
    SKAction *trashCanAnimation     = [ SKAction animateWithTextures: trashCanTextures timePerFrame: 0.01 ];
    SKAction *trashCanRepeatForever = [ SKAction repeatActionForever: trashCanAnimation ];
    [ self.img runAction: trashCanRepeatForever ];
    [ self.img setScale:0.45 ];
    
    
    SKAction *horizontalAnimation = [SKAction sequence: @[
                                                                 //[SKAction waitForDuration: 1.0],
                                                                 [SKAction moveToX: 880 duration: 5.0],
                                                                 //aas[SKAction waitForDuration: 1.0],
                                                                 [SKAction moveToX: 140 duration: 5.0]
                                                         ]
                                    ];
    
    SKAction *verticalAnimation = [SKAction sequence:@[
                                                              [SKAction waitForDuration:0.0],
                                                              [SKAction moveToY:230 duration:0.8],
                                                              [SKAction moveToY:190 duration:0.8]
                                                       ]
                                   ];
    
    [ self.img runAction: [SKAction repeatActionForever: horizontalAnimation] ];
    [ self.img runAction: [SKAction repeatActionForever: verticalAnimation] ];
    
    return self;
}
//------------------------------------------------------------------------------------
@end
