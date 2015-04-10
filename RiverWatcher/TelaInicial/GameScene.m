//
//  GameScene.m
//  TelaInicial
//
//  Created by Gabriela  Gomes Pires on 07/04/15.
//  Copyright (c) 2015 Gabriela  Gomes Pires. All rights reserved.
//

#import "GameScene.h"
#import "TelaDoJogo.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    
    //cenario da tela inicial
    SKSpriteNode *telaInicial = [SKSpriteNode spriteNodeWithImageNamed:@"tela1.png"];
    telaInicial.position = CGPointMake(self.size.width/2, self.size.height/2);
    [telaInicial setScale:0.5];
    
    //onda da tela inicial
    SKSpriteNode *onda = [SKSpriteNode spriteNodeWithImageNamed:@"movimento.png"];
    onda.position = CGPointMake(self.size.width/2, self.size.height/2);
    [onda setScale:0.55];
    SKAction *movimentoHorizontalOnda = [ SKAction sequence: @[
                                                                  [SKAction waitForDuration: 0.0],
                                                                  [SKAction moveToX: (self.size.width/2)+25 duration: 1.0],
                                                                  [SKAction waitForDuration: 0.0],
                                                                  [SKAction moveToX: (self.size.width/2)-25 duration: 1.0]
                                                                  ]
                                            ];
    
    SKAction *movimentoVerticalOnda = [SKAction sequence:@[
                                                              [SKAction waitForDuration:0.0],
                                                              [SKAction moveToY:self.size.height/2+25 duration:1.0],
                                                              [SKAction moveToY:(self.size.height/2)duration:1.0]]];
    
    [onda runAction: [SKAction repeatActionForever: movimentoHorizontalOnda]];
    [onda runAction: [SKAction repeatActionForever:movimentoVerticalOnda]];

                           
    
    //areia da tela inicial
    SKSpriteNode *areia = [SKSpriteNode spriteNodeWithImageNamed:@"areia1.png"];
    areia.position = CGPointMake((self.size.width/2)-30, (self.size.height/2) - 345);
    [areia setScale:0.57];
    
    //animação do peixe dourado da tela inicial
    SKTextureAtlas * atlasDourado = [SKTextureAtlas atlasNamed:@"peixeDourado"];
    SKTexture * pd1 = [atlasDourado textureNamed:@"peixe-dourado1.png"];
    SKTexture * pd2 = [atlasDourado textureNamed:@"peixe-dourado2.png"];
    SKTexture * pd3 = [atlasDourado textureNamed:@"peixe-dourado3.png"];
    SKTexture * pd4 = [atlasDourado textureNamed:@"peixe-dourado4.png"];
    SKTexture * pd5 = [atlasDourado textureNamed:@"peixe-dourado5.png"];
    SKTexture * pd6 = [atlasDourado textureNamed:@"peixe-dourado6.png"];
    SKTexture * pd7 = [atlasDourado textureNamed:@"peixe-dourado7.png"];
    SKTexture * pd8 = [atlasDourado textureNamed:@"peixe-dourado8.png"];
    
    NSArray *texturesDourado = @[pd1, pd2, pd3, pd4, pd5, pd6, pd7, pd8];
    SKSpriteNode *peixeDourado = [SKSpriteNode spriteNodeWithTexture:pd1];
    peixeDourado.position = CGPointMake(180, 297);
    SKAction *movimento = [SKAction animateWithTextures:texturesDourado timePerFrame:.20];
    SKAction *repeat = [SKAction repeatActionForever:movimento];
    [peixeDourado runAction:repeat];
    [peixeDourado setScale:0.22];
    
    //animacao da primeira alga
    SKTextureAtlas *atlasAlga1 = [SKTextureAtlas atlasNamed:@"alga1"];
    SKTexture *alga1 = [atlasAlga1 textureNamed:@"alga1.png"];
    SKTexture *alga2 = [atlasAlga1 textureNamed:@"alga2.png"];
    SKTexture *alga3 = [atlasAlga1 textureNamed:@"alga3.png"];
    SKTexture *alga4 = [atlasAlga1 textureNamed:@"alga4.png"];
    SKTexture *alga5 = [atlasAlga1 textureNamed:@"alga5.png"];
    SKTexture *alga6 = [atlasAlga1 textureNamed:@"alga6.png"];
    SKTexture *alga7 = [atlasAlga1 textureNamed:@"alga7.png"];
    SKTexture *alga8 = [atlasAlga1 textureNamed:@"alga8.png"];
    SKTexture *alga9 = [atlasAlga1 textureNamed:@"alga9.png"];
    
    NSArray *texturesAlga1 = @[alga1, alga2, alga3, alga4, alga5, alga6, alga7, alga8, alga9];
    SKSpriteNode *alga01 = [SKSpriteNode spriteNodeWithTexture:alga1];
    alga01.position = CGPointMake(350, 149);
    SKAction *movimentoAlga = [SKAction animateWithTextures:texturesAlga1 timePerFrame:0.15];
    SKAction *repeatAlga = [SKAction repeatActionForever:movimentoAlga];
    [alga01 runAction:repeatAlga];
    [alga01 setScale:0.3];
    
    //animacao da segunda alga
    SKTextureAtlas *atlasAlga2 = [SKTextureAtlas atlasNamed:@"algas2"];
    SKTexture *alg1 = [atlasAlga2 textureNamed:@"n_alga1.png"];
    SKTexture *alg2 = [atlasAlga2 textureNamed:@"n_alga2.png"];
    SKTexture *alg3 = [atlasAlga2 textureNamed:@"n_alga3.png"];
    SKTexture *alg4 = [atlasAlga2 textureNamed:@"n_alga4.png"];
    SKTexture *alg5 = [atlasAlga2 textureNamed:@"n_alga5.png"];
    SKTexture *alg6 = [atlasAlga2 textureNamed:@"n_alga6.png"];
    SKTexture *alg7 = [atlasAlga2 textureNamed:@"n_alga7.png"];
    SKTexture *alg8 = [atlasAlga2 textureNamed:@"n_alga8.png"];
    SKTexture *alg9 = [atlasAlga2
                       textureNamed:@"n_alga9.png"];
    
    NSArray *texturesAlga2 = @[alg1, alg2, alg3, alg4, alg5, alg6, alg7, alg8, alg9];
    SKSpriteNode *alga02 = [SKSpriteNode spriteNodeWithTexture:alg1];
    alga02.position = CGPointMake(800, 195);
    SKAction *movimentoAlga2 = [SKAction animateWithTextures:texturesAlga2 timePerFrame:0.15];
    SKAction *repeatAlga2 = [SKAction repeatActionForever:movimentoAlga2];
    [alga02 runAction:repeatAlga2];
    [alga02 setScale:0.5];
    
    
    //botao jogar
    SKSpriteNode *botaoJogar = [SKSpriteNode spriteNodeWithImageNamed:@"bot7.png"];
    [botaoJogar setScale:0.5];
    
    botaoJogar.position = CGPointMake(CGRectGetMidX(self.frame),
                                  CGRectGetMidY(self.frame)+80);
    botaoJogar.name = @"botaoJogar";
    
    //botao ranking
    SKSpriteNode *botaoRanking = [SKSpriteNode spriteNodeWithImageNamed:@"bot8.png"];
    [botaoRanking setScale:0.5];
    botaoRanking.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame)-10);
    botaoRanking.name = @"botaoRanking";
    
    //adicionando os nodes na tela
    [self addChild:telaInicial];
    [self addChild:onda];
    [self addChild:alga01];
    [self addChild:alga02];
    [self addChild:areia];
    [self addChild:peixeDourado];
    [self addChild:botaoJogar];
    [self addChild:botaoRanking];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    // ao clicar no botão irá ocorrer a transição para a tela do jogo(classe TelaDoJogo)
    if ([node.name isEqualToString:@"botaoJogar"]) {
        NSLog(@"botão jogar pressionado");
        SKScene *sampleScene = [[TelaDoJogo alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition flipVerticalWithDuration:0.1];
        [self.view presentScene:sampleScene transition:transition];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
