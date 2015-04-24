//
//  ObjetosController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "RWAutomobile.h"
#import "RWBasicObject.h"
#import "RWLixo.h"
#import "RWDuck.h"

static const uint32_t garbageContactCategory =  0x1 << 0;
static const uint32_t waterContactCategory   =  0x1 << 1;
static const uint32_t duckContactCategory    =  0x1 << 2;

@interface ObjectsController : NSObject

@property ( nonatomic ) int maxObjectsFlying;
@property ( nonatomic ) int numObjectsFlying;

-(void)throwObject:(SKScene *)scene object:(RWBasicObject *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse;
-(void)destroyObjectsOffScreen:(SKScene *)scene;
+(instancetype)InitObjController;
@end
