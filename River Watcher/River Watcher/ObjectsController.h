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

@interface ObjectsController : NSObject

-(void)throwObject:(RWBasicObject *)obj parent:(RWBasicObject *)parentNode impulse:(CGFloat)throwImpulse;

@end
