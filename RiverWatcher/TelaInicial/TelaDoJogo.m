//  TelaDoJogo.m
//  TelaInicial
//
//  Created by Gabriela  Gomes Pires on 07/04/15.
//  Copyright (c) 2015 Gabriela  Gomes Pires. All rights reserved.
//

#import "TelaDoJogo.h"

@implementation TelaDoJogo{
    SKSpriteNode* buttonPause;
    BOOL paused;
    SKSpriteNode *buttonAudio;
    BOOL audioPaused;
    UITouch *touch;
    CGPoint location;
    SKNode *node;
}

-(void)viewWillLayoutSubviews
{
    SKView * skView = (SKView *)self.view;
    UIView *pauseMenu = [[UIView alloc] initWithFrame:buttonPause.frame];
    [skView addSubview:pauseMenu];

}


-(void)didMoveToView:(SKView *)view {

    paused = YES;
    //imagem de fundo da tela do jogo.
    SKSpriteNode *telaInicial = [SKSpriteNode spriteNodeWithImageNamed:@"telajogo.png"];
    telaInicial.position = CGPointMake(self.size.width/2, self.size.height/2);
    [telaInicial setScale:0.50];
    
    //imagem da agua clara na tela do jogo.
    SKSpriteNode *agua = [SKSpriteNode spriteNodeWithImageNamed:@"agua1.png"];
    agua.position = CGPointMake(self.size.width/2, 10);
    [agua setScale:0.5];
    
    //imagem da agua escura na tela do jogo.
    SKSpriteNode *agua2 = [SKSpriteNode spriteNodeWithImageNamed:@"agua2.png"];
    agua2.position = CGPointMake(self.size.width/2, 10);
    [agua2 setScale:0.5];
    
    //imagem do guardreio na tela do jogo.
    SKSpriteNode *guardreio = [SKSpriteNode spriteNodeWithImageNamed:@"guardreio.png"];
    guardreio.position = CGPointMake((self.size.width/2)+1, 100);
    [guardreio setScale:0.55];
    
    
    //animacao da lixeira
    SKTextureAtlas *atlasLixeira = [SKTextureAtlas atlasNamed:@"lixeira"];
    SKTexture *lixeira1 = [atlasLixeira textureNamed:@"lixeira.png"];
    SKTexture *lixeira2 = [atlasLixeira textureNamed:@"lixeira2.png"];
    SKTexture *lixeira3 = [atlasLixeira textureNamed:@"lixeira3.png"];
    
    NSArray *texturesLixeira = @[lixeira1,lixeira2,lixeira3];
    SKSpriteNode *lixeira = [SKSpriteNode spriteNodeWithTexture:lixeira1];
    lixeira.position = CGPointMake(140, 330);
    SKAction *movimentoLixeira = [SKAction animateWithTextures:texturesLixeira timePerFrame:.01];
    SKAction *repeatLixeira = [SKAction repeatActionForever:movimentoLixeira];
    [lixeira runAction:repeatLixeira];
    [lixeira setScale:0.45];
    
    
    SKAction *movimentoHorizontalLixeira = [SKAction sequence: @[
                                             [SKAction waitForDuration: 2.0],
                                             [SKAction moveToX: 880 duration: 5.0],
                                             [SKAction waitForDuration: 2.0],
                                             [SKAction moveToX: 140 duration: 5.0]
                                             ]
                       ];
    SKAction *movimentoVerticalLixeira = [SKAction sequence:@[
                                                              [SKAction waitForDuration:0.0],
                                                              [SKAction moveToY:370 duration:0.8],
                                                              [SKAction moveToY:330 duration:0.8]]];
    
    [lixeira runAction: [SKAction repeatActionForever: movimentoHorizontalLixeira]];
    [lixeira runAction: [SKAction repeatActionForever:movimentoVerticalLixeira]];
    
    
    //animacao do esgoto na tela do jogo.
    SKTextureAtlas * atlasEsgoto = [SKTextureAtlas atlasNamed:@"esgoto"];
    SKTexture *esgoto1 = [atlasEsgoto textureNamed:@"esgoto1.png"];
    SKTexture *esgoto2 = [atlasEsgoto textureNamed:@"esgoto2.png"];
    SKTexture *esgoto3 = [atlasEsgoto textureNamed:@"esgoto3.png"];
    
    NSArray *texturesEsgoto = @[esgoto1, esgoto2, esgoto3];
    SKSpriteNode *esg1 = [SKSpriteNode spriteNodeWithTexture:esgoto1];
    esg1.position = CGPointMake(90, 100);
    SKAction *movimento = [SKAction animateWithTextures:texturesEsgoto timePerFrame:.35];
    SKAction *repeat = [SKAction repeatActionForever:movimento];
    [esg1 runAction:repeat];
    [esg1 setScale:0.5];
    SKSpriteNode *esg2 = [SKSpriteNode spriteNodeWithTexture:esgoto1];
    esg2.position = CGPointMake(CGRectGetMidX(self.frame), 100);
    SKAction *movimento2 = [SKAction animateWithTextures:texturesEsgoto timePerFrame:.35];
    SKAction *repeat2 = [SKAction repeatActionForever:movimento2];
    [esg2 runAction:repeat2];
    [esg2 setScale:0.5];
    SKSpriteNode *esg3 = [SKSpriteNode spriteNodeWithTexture:esgoto1];
    esg3.position = CGPointMake(890, 100);
    SKAction *movimento3 = [SKAction animateWithTextures:texturesEsgoto timePerFrame:.35];
    SKAction *repeat3 = [SKAction repeatActionForever:movimento3];
    [esg3 runAction:repeat3];
    [esg3 setScale:0.5];
    
    //caixa da pontuação e recorde.
    SKSpriteNode *recorde = [SKSpriteNode spriteNodeWithImageNamed:@"bot9.png"];
    recorde.position = CGPointMake(CGRectGetMidX(self.frame), 720);
    [recorde setScale:0.50];
    
    //barras de vida
    SKSpriteNode *vida =  [SKSpriteNode spriteNodeWithImageNamed:@"bot10.png"];
    SKSpriteNode *vida2 = [SKSpriteNode spriteNodeWithImageNamed:@"bot10.png"];
    SKSpriteNode *vida3 = [SKSpriteNode spriteNodeWithImageNamed:@"bot10.png"];
    SKSpriteNode *vida4 = [SKSpriteNode spriteNodeWithImageNamed:@"bot10.png"];
    SKSpriteNode *vida5 = [SKSpriteNode spriteNodeWithImageNamed:@"bot10.png"];
    vida.position = CGPointMake(40, 730);
    vida2.position = CGPointMake(80, 730);
    vida3.position = CGPointMake(120, 730);
    vida4.position = CGPointMake(160, 730);
    vida5.position = CGPointMake(200, 730);
    [vida setScale:0.5];
    [vida2 setScale:0.5];
    [vida3 setScale:0.5];
    [vida4 setScale:0.5];
    [vida5 setScale:0.5];
    
    //botao de pause e play
    buttonPause = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"bot4.png"]];
    [buttonPause setScale:0.5];
    buttonPause.position = CGPointMake(960, 720);
    buttonPause.name = @"botaoPause";
    
    //botao do audio
    buttonAudio = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"bot1.png"]];
    [buttonAudio setScale:0.5];
    buttonAudio.position = CGPointMake(865, 720);
    buttonAudio.name = @"botaoAudio";
    
    //texto da pontuação
    self.pontuacao = [SKLabelNode labelNodeWithFontNamed:@"PressStart2P"];
    self.pontuacao.text = @"0";
    self.pontuacao.fontColor = [SKColor redColor];
    self.pontuacao.fontSize = 25;
    self.pontuacao.position = CGPointMake(CGRectGetMidX(self.frame), 720);
    
    //texto do recorde
    self.textoRecorde = [SKLabelNode labelNodeWithFontNamed:@"PressStart2P"];
    self.textoRecorde.text = @"Recorde: ";
    self.textoRecorde.fontColor = [SKColor redColor];
    self.textoRecorde.fontSize = 15;
    self.textoRecorde.position = CGPointMake((CGRectGetMidX(self.frame) - 35), 695);
    
    //adicionando os nodes na tela
    SKNode *gui = [[SKNode alloc] init];
    [gui setName:@"gui"];
    SKNode *game = [[SKNode alloc] init];
    [game setName:@"game"];
    
    [game addChild:telaInicial];
    [game addChild:guardreio];
    [game addChild:esg1];
    [game addChild:esg2];
    [game addChild:esg3];
    [game addChild:agua];
    [game addChild:agua2];
    [game addChild:recorde];
    [game addChild:vida];
    [game addChild:vida2];
    [game addChild:vida3];
    [game addChild:vida4];
    [game addChild:vida5];
    [gui addChild:buttonPause];
    [gui addChild:buttonAudio];
    [game addChild:lixeira];
    [gui addChild:self.pontuacao];
    [gui addChild:self.textoRecorde];
    [self addChild:game];
    [self addChild:gui];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touch = [touches anyObject];
    location = [touch locationInNode:self];
    node = [self nodeAtPoint:location];
    
    // ao clicar no botão irá alterar a imagem (Botão de pause/play)
    if ([node.name isEqualToString:@"botaoPause"]) {
        NSLog(@"botão pause pressionado");
        if(paused == YES){
         [buttonPause setTexture:[SKTexture textureWithImageNamed:@"bot3.png"]];
         //   paused = NO;
            buttonPause.zPosition = 2;
            
        }
    }
    
    //ao clicar no botão irá alterar a imagem (Com som/sem som)
    if ([node.name isEqualToString:@"botaoAudio"]) {
        NSLog(@"botão audio pressionado");
        if(audioPaused == YES){
            [buttonAudio setTexture:[SKTexture textureWithImageNamed:@"bot1.png"]];
            audioPaused = NO;
            buttonAudio.zPosition = 2;
        
        }
        else{
            [buttonAudio setTexture:[SKTexture textureWithImageNamed:@"bot2.png"]];
            audioPaused = YES;
            buttonAudio.zPosition = 2;
          
        }
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([node.name isEqualToString:@"botaoPause"]) {
        NSLog(@"botão pause pressionado");
        if(paused == YES){
            [self childNodeWithName:@"game"].paused = YES;
            //self.scene.view.paused = YES;
            paused = NO;
            buttonPause.zPosition = 2;
        }
        else{
            [self childNodeWithName:@"game"].paused = NO;
            //self.scene.view.paused = NO;
            paused = YES;
            [buttonPause setTexture:[SKTexture textureWithImageNamed:@"bot4.png"]];
            buttonPause.zPosition = 2;
        }
        
    }
    
}

@end
