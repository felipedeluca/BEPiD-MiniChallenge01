//
//  ObjetosController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "WLAutomovel.h"

@interface ObjetosController : NSObject

-(void)throwObject:(SKSpriteNode *)obj parent:(WLAutomovel *)parentNode impulse:(CGFloat)throwImpulse;

@end
