//
//  RWDuck.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/23/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWBasicObject.h"

@interface RWDuck : RWBasicObject

@property ( nonatomic ) BOOL isFalling;
@property ( nonatomic ) BOOL didPlayAnySound;
@property ( nonatomic ) BOOL isMoving;
@property ( nonatomic ) BOOL rescued; // Foi salvo pelo usuário
@property ( nonatomic ) BOOL alreadyFloating;
@property ( nonatomic ) int flightDirection;
@property ( nonatomic ) CGFloat positionOffset;
//@property ( nonatomic ) SKTexture * objTexture;
@property ( nonatomic ) CGFloat animDuration; // Duração do movimento do carro para ir de um ponto a outro
@property ( nonatomic ) CGFloat animWaitTime; // Duração do movimento do carro para ir de um ponto a outro
@property ( nonatomic ) CGFloat animWaitForDuration; // Duração do movimento do carro para ir de um ponto a outro
@property ( nonatomic ) NSArray * flyingAnimation;
@property ( nonatomic ) NSArray * fallingAnimation;
@property ( nonatomic ) NSArray * surprisedAnimation; // Desenho do pato quando fica surpreso
@property ( nonatomic ) NSArray * swimmingAnimation; // Desenho do pato nadando

-(void)loopAnimateWings;
-(void)setDuckPhysics;

@end
