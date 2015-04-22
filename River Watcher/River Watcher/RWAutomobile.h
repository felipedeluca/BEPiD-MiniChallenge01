//
//  WLCarro1.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
//#import "RWBasicObject.h"

@interface RWAutomobile : SKSpriteNode

//@property ( nonatomic ) SKSpriteNode * img;
@property ( nonatomic ) BOOL atirouObjeto;
@property ( nonatomic ) BOOL didPlayAnySound;
@property ( nonatomic ) CGFloat positionOffset;
@property ( nonatomic ) SKTexture * objTexture;
@property ( nonatomic ) CGFloat animDuration; // Duração do movimento do carro para ir de um ponto a outro
@property ( nonatomic ) CGFloat animWaitTime; // Duração do movimento do carro para ir de um ponto a outro
@property ( nonatomic ) CGFloat animWaitForDuration; // Duração do movimento do carro para ir de um ponto a outro

@end
