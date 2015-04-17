//
//  AutomoveisController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "RWAutomobile.h"
#import "RWGlassBottle.h"
#import "ObjectsController.h"
#import "RWLata.h"
#import "RWLixo.h"

@interface AutomobileController : NSObject

@property ( nonatomic, strong ) NSMutableArray *arrayCars;

-(void)createNewCars:(SKScene *)scene amount:(int)n;
//-(void)throwObject   :(SKSpriteNode *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse;
-(void)animateCars:(SKScene *)scene;

@end
