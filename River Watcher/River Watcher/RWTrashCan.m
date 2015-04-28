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
    
    if ( self = [super init]){

        SKTexture *trashCanSpriteA = [ SKTexture textureWithImageNamed: @"lixeira" ];
        SKTexture *trashCanSpriteB = [ SKTexture textureWithImageNamed: @"lixeira2" ];
        SKTexture *trashCanSpriteC = [ SKTexture textureWithImageNamed: @"lixeira3" ];
        
        NSArray *trashCanTextures = @[ trashCanSpriteA,trashCanSpriteB,trashCanSpriteC ];
        self = [ RWTrashCan spriteNodeWithTexture: trashCanSpriteC ];
        self.position         = CGPointMake( 200, 130);
        self.zPosition        = 20.0;
        
        SKAction *trashCanAnimation     = [ SKAction animateWithTextures: trashCanTextures timePerFrame: 0.01 ];
        SKAction *trashCanRepeatForever = [ SKAction repeatActionForever: trashCanAnimation ];
        [ self runAction: trashCanRepeatForever ];
        [ self setScale:0.3 ];
        
        
        SKAction *horizontalAnimation = [SKAction sequence: @[
                                                              //[SKAction waitForDuration: 1.0],
                                                              [SKAction moveToX: 880 duration: 5.0],
                                                              //aas[SKAction waitForDuration: 1.0],
                                                              [SKAction moveToX: 140 duration: 5.0]
                                                              ]
                                         ];
        
        SKAction *verticalAnimation = [SKAction sequence:@[
                                                           [SKAction waitForDuration:0.0],
                                                           [SKAction moveToY:240 duration:0.8],
                                                           [SKAction moveToY:210 duration:0.8]
                                                           ]
                                       ];
        
        [ self runAction: [SKAction repeatActionForever: horizontalAnimation] ];
        [ self runAction: [SKAction repeatActionForever: verticalAnimation] ];
    
        return self;
    }
    
    return nil;
}
//------------------------------------------------------------------------------------
@end
