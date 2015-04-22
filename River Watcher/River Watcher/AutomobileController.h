//
//  AutomoveisController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "ObjectsController.h"
#import "RWAutomobile.h"
#import "RWLixo.h"
#import "Random.h"
#import "Config.h"

@interface AutomobileController : NSObject

@property ( nonatomic, strong ) NSMutableArray *arrayCars;
@property ( nonatomic ) CGFloat currentGameDifficult;// = 10;
@property ( nonatomic ) CGFloat maxGameDifficult;//     = 100;
@property ( nonatomic ) CGFloat difficultRatio;

-(void)createNewCars:(SKScene *)scene amount:(int)n;
//-(void)throwObject   :(SKSpriteNode *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse;
-(void)animateCars:(SKScene *)scene;

@end
