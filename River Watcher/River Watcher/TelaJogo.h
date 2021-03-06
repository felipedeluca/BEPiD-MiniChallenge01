//
//  TelaJogo.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "Config.h"

@interface TelaJogo : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, getter = isPaused) BOOL pausarJogo;
@property (nonatomic, strong) SKLabelNode *pontuacao;
@property (nonatomic, strong) SKLabelNode *textoRecorde;


@end

SKSpriteNode *vida1, *vida2, *vida3, *vida4, *vida5;
NSArray *vidas;

long highScore;
unsigned int pontos;
