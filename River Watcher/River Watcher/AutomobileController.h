//
//  AutomoveisController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "RWCar1.h"
#import "RWCar2.h"
#import "RWCar3.h"
#import "RWCar4.h"
#import "RWCar5.h"
#import "RWCar6.h"
#import "RWAutomobile.h"
#import "RWGlassBottle.h"
#import "ObjectsController.h"

@interface AutomobileController : NSObject

@property ( nonatomic, strong ) RWCar1 *carro1;//
@property (nonatomic, strong) RWCar2 *carro2;
@property (nonatomic, strong) RWCar3 *carro3;
@property (nonatomic, strong) RWCar4 *carro4;
@property (nonatomic, strong) RWCar5 *carro5;
@property (nonatomic, strong) RWCar5 *carro6;

-(void)criaAutomoveis:(SKScene *)scene;
//-(void)throwObject   :(SKSpriteNode *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse;
-(void)animaAutomovel:(SKScene *)scene autoMovel:(RWAutomobile *)automovel;

@end
