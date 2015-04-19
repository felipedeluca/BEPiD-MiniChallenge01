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

@interface ObjectsController : NSObject

@property ( nonatomic ) int maxObjectsInTheAir;
@property ( nonatomic ) int objectsInTheAir;

-(void)throwObject:(SKScene *)scene object:(RWBasicObject *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse;
-(void)destroyObjectsOffScreen:(SKScene *)scene;

@end
