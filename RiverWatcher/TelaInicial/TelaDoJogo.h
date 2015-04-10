//
//  TelaDoJogo.h
//  TelaInicial
//
//  Created by Gabriela  Gomes Pires on 07/04/15.
//  Copyright (c) 2015 Gabriela  Gomes Pires. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TelaDoJogo : SKScene

@property (nonatomic, strong) SKLabelNode *pontuacao;
@property (nonatomic, strong) SKLabelNode *textoRecorde;
@property (nonatomic, getter = isPaused) BOOL pausarJogo;

@end
