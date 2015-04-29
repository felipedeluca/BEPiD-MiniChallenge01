//
//  GameScene.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/9/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "TelaInicio.h"
#import "TelaJogo.h"
#import <AVFoundation/AVFoundation.h>

@interface TelaInicio ()
{
    AVAudioPlayer *audioPlayer;
}

@end

@implementation TelaInicio
//--------------------------------------------------------------------
-(void)didMoveToView:(SKView *)view {
    
    // Inicia a tela e as animações
    [ self ativaTela ];
    
}
//--------------------------------------------------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch   = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node     = [self nodeAtPoint:location];
    
    // ao clicar no botão irá ocorrer a transição para a tela do jogo(classe TelaDoJogo)
    if ( [node.name isEqualToString:@"botaoJogar"] ) {
        NSLog( @"botão jogar pressionado" );
        
       
         [node runAction: [SKAction playSoundFileNamed:@"Grab object.wav" waitForCompletion:YES]];

        
        SKScene *telaJogo     = [ [TelaJogo alloc] initWithSize:self.size ];
        SKTransition *transition = [ SKTransition flipVerticalWithDuration:0.1 ];
       
        telaJogo.scaleMode = SKSceneScaleModeAspectFit;
        //telaJogo.physicsWorld. = 1.0;
        
        [ self.view presentScene: telaJogo transition: transition ];
    }
}
//--------------------------------------------------------------------
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}
//--------------------------------------------------------------------
-(void)ativaTela{
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Enjoy The Life - TI.wav", [[NSBundle mainBundle] resourcePath]]];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    audioPlayer.volume = 0.5;
    
    [audioPlayer play];
    
    
    self.view.multipleTouchEnabled = NO;
    
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
    [onda runAction: [SKAction repeatActionForever: movimentoVerticalOnda]];

    //areia da tela inicial
    SKSpriteNode *areia = [SKSpriteNode spriteNodeWithImageNamed:@"areia1.png"];
    areia.position = CGPointMake((self.size.width/2)-30, (self.size.height/2) - 345);
    [areia setScale:0.57];
    areia.zPosition = 2.0;

    //logo da tela
    SKSpriteNode *logo = [SKSpriteNode spriteNodeWithImageNamed:@"logo2.png"];
    logo.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMidY(self.frame)+155);
    [logo setScale:0.45];
    logo.zPosition = 2.0;
    
    //animação do peixe dourado da tela inicial
    SKTexture * pd1 = [ SKTexture textureWithImageNamed: @"peixe-dourado1" ];
    SKTexture * pd2 = [ SKTexture textureWithImageNamed: @"peixe-dourado2" ];
    SKTexture * pd3 = [ SKTexture textureWithImageNamed: @"peixe-dourado3" ];
    SKTexture * pd4 = [ SKTexture textureWithImageNamed: @"peixe-dourado4" ];
    SKTexture * pd5 = [ SKTexture textureWithImageNamed: @"peixe-dourado5" ];
    SKTexture * pd6 = [ SKTexture textureWithImageNamed: @"peixe-dourado6" ];
    SKTexture * pd7 = [ SKTexture textureWithImageNamed: @"peixe-dourado7" ];
    SKTexture * pd8 = [ SKTexture textureWithImageNamed: @"peixe-dourado8" ];
    
    NSArray *texturesDourado   = @[ pd1, pd2, pd3, pd4, pd5, pd6, pd7, pd8 ];
    SKSpriteNode *peixeDourado = [ SKSpriteNode spriteNodeWithTexture:pd8 ];
    peixeDourado.zPosition = 1.0;
    
    [ peixeDourado setScale:0.22 ];
    peixeDourado.position = CGPointMake(180, 297);

    SKAction *movimento = [ SKAction animateWithTextures:texturesDourado timePerFrame:.20 ];
    SKAction *repeat    = [ SKAction repeatActionForever:movimento ];
    [peixeDourado runAction:repeat];
    
    //animacao da primeira alga
    SKTexture *alga1 = [ SKTexture textureWithImageNamed: @"alga1.png" ];
    SKTexture *alga2 = [ SKTexture textureWithImageNamed: @"alga2.png" ];
    SKTexture *alga3 = [ SKTexture textureWithImageNamed: @"alga3.png" ];
    SKTexture *alga4 = [ SKTexture textureWithImageNamed: @"alga4.png" ];
    SKTexture *alga5 = [ SKTexture textureWithImageNamed: @"alga5.png" ];
    SKTexture *alga6 = [ SKTexture textureWithImageNamed: @"alga6.png" ];
    SKTexture *alga7 = [ SKTexture textureWithImageNamed: @"alga7.png" ];
    SKTexture *alga8 = [ SKTexture textureWithImageNamed: @"alga8.png" ];
    SKTexture *alga9 = [ SKTexture textureWithImageNamed: @"alga9.png" ];
    
    NSArray *texturesAlga1 = @[ alga1, alga2, alga3, alga4, alga5, alga6, alga7, alga8, alga9 ];
    SKSpriteNode *alga01   = [SKSpriteNode spriteNodeWithTexture:alga8];
    alga01.zPosition       = 1.5;
    alga01.position        = CGPointMake(350, 149);
    
    SKAction *movimentoAlga = [SKAction animateWithTextures:texturesAlga1 timePerFrame:0.15];
    SKAction *repeatAlga    = [SKAction repeatActionForever:movimentoAlga];
    [alga01 runAction:repeatAlga];
    [alga01 setScale:0.3];
    
    //animacao da segunda alga
    SKTexture *alg1 = [ SKTexture textureWithImageNamed: @"n_alga1.png" ];
    SKTexture *alg2 = [ SKTexture textureWithImageNamed: @"n_alga2.png" ];
    SKTexture *alg3 = [ SKTexture textureWithImageNamed: @"n_alga3.png" ];
    SKTexture *alg4 = [ SKTexture textureWithImageNamed: @"n_alga4.png" ];
    SKTexture *alg5 = [ SKTexture textureWithImageNamed: @"n_alga5.png" ];
    SKTexture *alg6 = [ SKTexture textureWithImageNamed: @"n_alga6.png" ];
    SKTexture *alg7 = [ SKTexture textureWithImageNamed: @"n_alga7.png" ];
    SKTexture *alg8 = [ SKTexture textureWithImageNamed: @"n_alga8.png" ];
    SKTexture *alg9 = [ SKTexture textureWithImageNamed: @"n_alga9.png" ];
    
    NSArray *texturesAlga2 = @[ alg1, alg2, alg3, alg4, alg5, alg6, alg7, alg8, alg9 ];
    SKSpriteNode *alga02   = [SKSpriteNode spriteNodeWithTexture:alg9];
    alga02.zPosition       = 1.5;
    alga02.position        = CGPointMake(800, 195);
    
    SKAction *movimentoAlga2 = [SKAction animateWithTextures:texturesAlga2 timePerFrame:0.15];
    SKAction *repeatAlga2    = [SKAction repeatActionForever:movimentoAlga2];
    [alga02 runAction:repeatAlga2];
    [alga02 setScale:0.5];
    
    
    //botao jogar
    SKSpriteNode *botaoJogar = [SKSpriteNode spriteNodeWithImageNamed:@"jogar.png"];
    [botaoJogar setScale:0.4];
    
    botaoJogar.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame)-100);
    botaoJogar.name = @"botaoJogar";
    
//    //botao ranking
//    SKSpriteNode *botaoRanking = [SKSpriteNode spriteNodeWithImageNamed:@"bot8.png"];
//    [botaoRanking setScale:0.5];
//    botaoRanking.position = CGPointMake(CGRectGetMidX(self.frame),
//                                        CGRectGetMidY(self.frame)-10);
//    botaoRanking.name = @"botaoRanking";
    
    //adicionando os nodes na tela
    [self addChild:telaInicial];
    [self addChild:onda];
    [self addChild:alga01];
    [self addChild:alga02];
    [self addChild:areia];
    [self addChild:peixeDourado];
    [self addChild:botaoJogar];
    [self addChild:logo];
    //[self addChild:botaoRanking];


}

-(void)willMoveFromView:(SKView *)view {
    
    [audioPlayer stop];
    
}



//--------------------------------------------------------------------

@end
