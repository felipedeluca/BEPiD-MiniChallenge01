//
//  TelaFinal.m
//  River Watcher
//
//  Created by Gabriela  Gomes Pires on 16/04/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "TelaFinal.h"
#import "TelaJogo.h"
#import "WaterController.h"
#import <AVFoundation/AVFoundation.h>

@interface TelaFinal ()
{
    AVAudioPlayer *audioPlayer;
}

@end
@implementation TelaFinal

-(void)didMoveToView:(SKView *)view {
    
    //play song
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Smalltalk - End.wav", [[NSBundle mainBundle] resourcePath]]];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    audioPlayer.volume = 0.5;

    [audioPlayer play];
    
    
    /* Setup your scene here */
    //imagem de fundo da tela perdeu.
    SKSpriteNode *telaPerdeu = [SKSpriteNode spriteNodeWithImageNamed:@"tela3.png"];
    telaPerdeu.position = CGPointMake(self.size.width/2, (self.size.height/2));
    [telaPerdeu setScale:0.50];
    
    //imagem areia da tela perdeu.
    SKSpriteNode *areiaFinal = [SKSpriteNode spriteNodeWithImageNamed:@"areia2.png"];
    areiaFinal.position = CGPointMake(self.size.width/2, 45);
    [areiaFinal setScale:0.5];
    areiaFinal.zPosition = 2.0;
    
    //imagem pneu da tela perdeu
    SKSpriteNode *pneu = [SKSpriteNode spriteNodeWithImageNamed:@"lixo2.png"];
    pneu.position = CGPointMake((self.size.width/2)+90, 80);
    [pneu setScale:0.5];
    
    //animação do peixe mutante da tela inicial
    SKTexture * pm1 = [SKTexture textureWithImageNamed:@"peixe-mutante1"];
    SKTexture * pm2 = [SKTexture textureWithImageNamed:@"peixe-mutante2"];
    SKTexture * pm3 = [SKTexture textureWithImageNamed:@"peixe-mutante3"];
    SKTexture * pm4 = [SKTexture textureWithImageNamed:@"peixe-mutante4"];
    SKTexture * pm5 = [SKTexture textureWithImageNamed:@"peixe-mutante5"];
    SKTexture * pm6 = [SKTexture textureWithImageNamed:@"peixe-mutante6"];
    SKTexture * pm7 = [SKTexture textureWithImageNamed:@"peixe-mutante7"];
    SKTexture * pm8 = [SKTexture textureWithImageNamed:@"peixe-mutante8"];
    
    NSArray *texturesMutante = @[pm1, pm2, pm3, pm4, pm5, pm6, pm7, pm8];
    SKSpriteNode *peixeMutante = [SKSpriteNode spriteNodeWithTexture:pm1];
    peixeMutante.position = CGPointMake(180, 297);
    SKAction *movimentoMutante = [SKAction animateWithTextures:texturesMutante timePerFrame:.20];
    SKAction *repeatMutante = [SKAction repeatActionForever:movimentoMutante];
    [peixeMutante runAction:repeatMutante];
    [peixeMutante setScale:0.22];
    peixeMutante.zPosition = 1.0;
    
    //animacao da primeira alga
    SKTexture *alga1 = [SKTexture textureWithImageNamed:@"m_alga1.png"];
    SKTexture *alga2 = [SKTexture textureWithImageNamed:@"m_alga2.png"];
    SKTexture *alga3 = [SKTexture textureWithImageNamed:@"m_alga3.png"];
    SKTexture *alga4 = [SKTexture textureWithImageNamed:@"m_alga4.png"];
    SKTexture *alga5 = [SKTexture textureWithImageNamed:@"m_alga5.png"];
    SKTexture *alga6 = [SKTexture textureWithImageNamed:@"m_alga6.png"];
    SKTexture *alga7 = [SKTexture textureWithImageNamed:@"m_alga7.png"];
    SKTexture *alga8 = [SKTexture textureWithImageNamed:@"m_alga8.png"];
    SKTexture *alga9 = [SKTexture textureWithImageNamed:@"m_alga9.png"];
    
    NSArray *texturesAlga1 = @[alga1, alga2, alga3, alga4, alga5, alga6, alga7, alga8, alga9];
    SKSpriteNode *alga01 = [SKSpriteNode spriteNodeWithTexture:alga1];
    alga01.position = CGPointMake(350, 149);
    SKAction *movimentoAlga = [SKAction animateWithTextures:texturesAlga1 timePerFrame:0.15];
    SKAction *repeatAlga = [SKAction repeatActionForever:movimentoAlga];
    [alga01 runAction:repeatAlga];
    [alga01 setScale:0.3];
    alga01.zPosition = 1.0;
    
    //animacao da segunda alga
    SKTexture *alg1 = [SKTexture textureWithImageNamed:@"z_alga1.png"];
    SKTexture *alg2 = [SKTexture textureWithImageNamed:@"z_alga2.png"];
    SKTexture *alg3 = [SKTexture textureWithImageNamed:@"z_alga3.png"];
    SKTexture *alg4 = [SKTexture textureWithImageNamed:@"z_alga4.png"];
    SKTexture *alg5 = [SKTexture textureWithImageNamed:@"z_alga5.png"];
    SKTexture *alg6 = [SKTexture textureWithImageNamed:@"z_alga6.png"];
    SKTexture *alg7 = [SKTexture textureWithImageNamed:@"z_alga7.png"];
    SKTexture *alg8 = [SKTexture textureWithImageNamed:@"z_alga8.png"];
    SKTexture *alg9 = [SKTexture textureWithImageNamed:@"z_alga9.png"];
    
    NSArray *texturesAlga2 = @[alg1, alg2, alg3, alg4, alg5, alg6, alg7, alg8, alg9];
    SKSpriteNode *alga02 = [SKSpriteNode spriteNodeWithTexture:alg1];
    alga02.position = CGPointMake(800, 195);
    SKAction *movimentoAlga2 = [SKAction animateWithTextures:texturesAlga2 timePerFrame:0.15];
    SKAction *repeatAlga2 = [SKAction repeatActionForever:movimentoAlga2];
    [alga02 runAction:repeatAlga2];
    [alga02 setScale:0.5];
    alga02.zPosition = 1.0;
    
    //onda da tela final
    
    SKAction *movimentoHorizontalOndaFinal = [ SKAction sequence: @[
                                                               [SKAction waitForDuration: 0.0],
                                                               [SKAction moveToX: (self.size.width/2)+25 duration: 1.0],
                                                               [SKAction waitForDuration: 0.0],
                                                               [SKAction moveToX: (self.size.width/2)-25 duration: 1.0]
                                                               ]
                                         ];

    
    SKSpriteNode *ondaFinal = [SKSpriteNode spriteNodeWithImageNamed:@"movimento2.png"];
    ondaFinal.position = CGPointMake(self.size.width/2, self.size.height/2);
    [ondaFinal setScale:0.55];
    SKAction *movimentoVerticalOndaFinal = [SKAction sequence:@[
                                                           [SKAction waitForDuration:0.0],
                                                           [SKAction moveToY:self.size.height/2+25 duration:1.0],
                                                           [SKAction moveToY:(self.size.height/2)duration:1.0]]];
    
    [ondaFinal runAction: [SKAction repeatActionForever: movimentoHorizontalOndaFinal]];
    [ondaFinal runAction: [SKAction repeatActionForever: movimentoVerticalOndaFinal]];

    
    //caixa da pontuação e recorde.
    SKSpriteNode *recorde = [SKSpriteNode spriteNodeWithImageNamed:@"bot9.png"];
    recorde.position = CGPointMake(CGRectGetMidX(self.frame), 720);
    [recorde setScale:0.50];
    
    self.vigilante = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
    self.vigilante.text = @"Vigilante";
    self.vigilante.fontColor = [SKColor whiteColor];
    self.vigilante.fontSize = 30;
    self.vigilante.position = CGPointMake(CGRectGetMidX(self.frame), 620);
    self.vigilante.zPosition = 3.0;
    
    self.vigilante2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
    self.vigilante2.text = @"Você deixou o rio ser poluído!";
    self.vigilante2.fontColor = [SKColor whiteColor];
    self.vigilante2.fontSize = 30;
    self.vigilante2.position = CGPointMake(CGRectGetMidX(self.frame), 580);
    self.vigilante2.zPosition = 3.0;
    
    int random = arc4random() % 10;
    
    switch (random) {
        case 1:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que uma garrafa de plástico";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 400 anos";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
        case 2:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que uma folha de papel";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva de 3 a 6 meses";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
        case 3:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que um palito de madeira";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 6 meses";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
        case 4:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que uma bituca de cigarro";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 20 meses";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
        case 5:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que o chiclete";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 5 anos";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
        case 6:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que o nylon";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 30 anos";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
        case 7:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que um copo de vidro";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 4.000 anos";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
        case 8:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que um pneu";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 600 anos";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
        case 9:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que uma lata de alumínio";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 200 a 500 anos";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
            
            
        default:
            self.texto1 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto1.text = @"Você sabia que uma caixa de papelão";
            self.texto1.fontColor = [SKColor whiteColor];
            self.texto1.fontSize = 30;
            self.texto1.position = CGPointMake(CGRectGetMidX(self.frame), 500);
            self.texto2 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
            self.texto2.text = @"leva cerca de 2 meses";
            self.texto2.fontColor = [SKColor whiteColor];
            self.texto2.fontSize = 30;
            self.texto2.position = CGPointMake(CGRectGetMidX(self.frame), 460);
            break;
    }


    
    self.texto3 = [SKLabelNode labelNodeWithFontNamed:@"Floraless"];
    self.texto3.text = @"para se decompor?";
    self.texto3.fontColor = [SKColor whiteColor];
    self.texto3.fontSize = 30;
    self.texto3.position = CGPointMake(CGRectGetMidX(self.frame), 420);
    
    self.texto1.zPosition = 3.0;
    self.texto2.zPosition = 3.0;
    self.texto3.zPosition = 3.0;
    
    
    
    SKSpriteNode *botaoVoltarProJogo = [SKSpriteNode spriteNodeWithImageNamed:@"bot6.png"];
    [botaoVoltarProJogo setScale:0.5];
    
    botaoVoltarProJogo.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame)-25);
    botaoVoltarProJogo.name = @"botaoVoltar";
    
//    SKSpriteNode *botaoRanking = [SKSpriteNode spriteNodeWithImageNamed:@"bot5.png"];
//    [botaoRanking setScale:0.5];
    
//    botaoRanking.position = CGPointMake(CGRectGetMidX(self.frame)-50,
//                                        CGRectGetMidY(self.frame)-25);
//    botaoRanking.name = @"botaoRanking";
    
    
    SKLabelNode *textoFinal;
    
    textoFinal = [[SKLabelNode alloc] initWithFontNamed:@"Floraless"];
    textoFinal.text      = [NSString stringWithFormat:@"Recorde: %li", highScore];
    textoFinal.fontColor = [SKColor redColor];
    [textoFinal setFontSize:15];
    textoFinal.position  = CGPointMake(CGRectGetMidX(self.frame), 695);
    textoFinal.zPosition = 2;
    
    SKLabelNode *pontuacao;
    
    pontuacao = [[SKLabelNode alloc] initWithFontNamed:@"Floraless"];
    pontuacao.text      = [NSString stringWithFormat:@"%i", pontos];
    pontuacao.fontColor = [SKColor redColor];
    [pontuacao setFontSize:25];
    pontuacao.position  = CGPointMake(CGRectGetMidX(self.frame), 720);
    pontuacao.zPosition = 2;
    
    
    
    

    
    //adicionando na tela
    [self addChild:telaPerdeu];
    [self addChild:pneu];
    [self addChild:alga01];
    [self addChild:alga02];
    [self addChild:areiaFinal];
    [self addChild:ondaFinal];
    [self addChild:peixeMutante];
    [self addChild:recorde];
    [self addChild:self.vigilante];
    [self addChild:self.vigilante2];
    [self addChild:self.texto1];
    [self addChild:self.texto2];
    [self addChild:self.texto3];
    [self addChild:botaoVoltarProJogo];
//    [self addChild:botaoRanking];
    [self addChild:textoFinal];
    [self addChild:pontuacao];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch   = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node     = [self nodeAtPoint:location];
    
    // ao clicar no botão irá ocorrer a transição para a tela do jogo(classe TelaDoJogo)
    if ( [node.name isEqualToString:@"botaoVoltar"] ) {
        NSLog( @"botão voltar pressionado" );
        SKScene *telaJogo     = [ [TelaJogo alloc] initWithSize:self.size ];
        SKTransition *transition = [ SKTransition flipVerticalWithDuration:0.1 ];
        
        telaJogo.scaleMode = SKSceneScaleModeAspectFit;
        //telaJogo.physicsWorld. = 1.0;
        [ self.view presentScene: telaJogo transition: transition ];
    }
}

-(void)willMoveFromView:(SKView *)view {
    
    [audioPlayer stop];
    
}


@end
