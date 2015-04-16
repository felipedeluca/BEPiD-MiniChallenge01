//
//  TelaJogo.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TelaJogo : SKScene

@property (nonatomic, getter = isPaused) BOOL pausarJogo;
@property (nonatomic, strong) SKLabelNode *pontuacao;
@property (nonatomic, strong) SKLabelNode *textoRecorde;


@end
//
//SKSpriteNode *img;
//SKSpriteNode *lixeira;
