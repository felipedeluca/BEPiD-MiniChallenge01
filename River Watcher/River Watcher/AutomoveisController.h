//
//  AutomoveisController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "WLCarro1.h"
#import "WLAutomovel.h"
#import "WLGarrafaVidro.h"
#import "ObjetosController.h"

@interface AutomoveisController : NSObject

@property ( nonatomic, strong ) WLCarro1 *carro1;//

-(void)criaAutomoveis:(SKScene *)scene;
-(void)throwObject   :(SKSpriteNode *)obj parent:(WLAutomovel *)parentNode impulse:(CGFloat)throwImpulse;
-(void)animaAutomovel:(SKScene *)scene autoMovel:(WLAutomovel *)automovel;

@end
