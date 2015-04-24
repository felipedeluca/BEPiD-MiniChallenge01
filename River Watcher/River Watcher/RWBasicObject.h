//
//  RWBasicObject.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/13/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface RWBasicObject : SKSpriteNode

@property ( nonatomic ) BOOL isInTheWater;
@property ( nonatomic ) BOOL hold; // Objeto está sendo segurado
@property ( nonatomic ) BOOL isInTheAir;
//@property ( nonatomic ) SKSpriteNode * img;
@property ( nonatomic ) SKTexture * objTexture;
@property ( nonatomic ) int scoreValue;

@end
