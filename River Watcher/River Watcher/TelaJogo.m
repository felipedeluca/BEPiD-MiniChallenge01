//
//  TelaJogo.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "TelaJogo.h"
#import "WLWater1.h"
#import "WLWater2.h"
#import "SpaceShip.h"
#import "WLGarrafaVidro.h"
#import "WLAutomovel.h"
#import "WLCarro1.h"
#import "AutomoveisController.h"
#import "ObjetosController.h"
#import "WaterController.h"

// Configuração da água
#define VISCOSITY 6.0 //Increase to make the water "thicker/stickier," creating more friction.
#define BUOYANCY 0.4 //Slightly increase to make the object "float up faster," more buoyant.
#define OFFSET 70.0 //Increase to make the object float to the surface higher.

@interface TelaJogo()

@property BOOL contentCreated;
@property ( nonatomic, strong ) SKSpriteNode *waterPhys; // simulação de física da água
@property ( nonatomic, strong ) WLWater1 *waterTile1A; // p/ scrolling infinito da água
@property ( nonatomic, strong ) WLWater1 *waterTile1B; // p/ scrolling infinito da água
@property ( nonatomic, strong ) WLWater2 *waterTile2A; // p/ scrolling infinito da água
@property ( nonatomic, strong ) WLWater2 *waterTile2B; // p/ scrolling infinito da água

@property ( nonatomic ) ObjetosController *objController;
@property ( nonatomic ) AutomoveisController *autoController;
@property ( nonatomic ) WaterController *waterController;

@end
//-----------------------------------------------------------------------
@implementation TelaJogo {
    
    SKSpriteNode* buttonPause;
    BOOL paused;
    SKSpriteNode *buttonAudio;
    BOOL audioPaused;
    UITouch *touch, *touchFinger;
    CGPoint location, locObj;
    SKNode *node;
    SKNode *gui;
    SKNode *game;
}
//-----------------------------------------------------------------------
-(void)viewWillLayoutSubviews
{
    SKView * skView   = (SKView *)self.view;
    UIView *pauseMenu = [[UIView alloc] initWithFrame:buttonPause.frame];
    
    [skView addSubview:pauseMenu];
}
//-----------------------------------------------------------------------
-(void)didMoveToView:(SKView *)view {
    
    if ( !self.contentCreated ){
        
        [ self createSceneContents ];
        self.contentCreated = YES;
        
        gui = [[SKNode alloc] init];
        [gui setName:@"gui"];
        game = [[SKNode alloc] init];
        [game setName:@"game"];
    }
}
//----------------------------------------------------------------------------------------
-(void)createSceneContents{
    
    [ self criaCenario ];
    [ self.waterController criaAgua: self ];
    
}
//--------------------------------------------------------------

-(void)criaCenario {

    self.autoController  = [[ AutomoveisController alloc ] init];
    self.waterController = [[ WaterController alloc ] init];
    
    paused = YES;
    audioPaused = YES;
    [self runAction: [SKAction repeatActionForever:[SKAction playSoundFileNamed:@"Enjoy The Life - In Game.wav" waitForCompletion:YES]]];
    
    //imagem de fundo da tela do jogo.
    SKSpriteNode *telaInicial = [ SKSpriteNode spriteNodeWithImageNamed: @"telajogo" ];
    telaInicial.position      = CGPointMake( self.size.width / 2, self.size.height / 2 );
    //    telaInicial.zPosition     = 1.0;
    [ telaInicial setScale: 0.50 ];
    
    //imagem do guardreio na tela do jogo.
    SKSpriteNode *guardreio = [ SKSpriteNode spriteNodeWithImageNamed: @"guardreio" ];
    guardreio.position      = CGPointMake( (self.size.width / 2) + 1, 200 );
    //    guardreio.zPosition     = 0.99;
    [ guardreio setScale: 0.55 ];
    
    //animacao da lixeira
    SKTexture *lixeira1 = [ SKTexture textureWithImageNamed: @"lixeira" ];
    SKTexture *lixeira2 = [ SKTexture textureWithImageNamed: @"lixeira2" ];
    SKTexture *lixeira3 = [ SKTexture textureWithImageNamed: @"lixeira3" ];
    
    NSArray *texturesLixeira = @[ lixeira1,lixeira2,lixeira3 ];
    lixeira    = [ SKSpriteNode spriteNodeWithTexture: lixeira1 ];
    lixeira.position         = CGPointMake( 200, 130);
    lixeira.zPosition        = 1.0;
    //  lixeira.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"lixeira" ] size: lixeira.size ];
    //lixeira.physicsBody.affectedByGravity = NO;
    //   lixeira.physicsBody.allowsRotation    = NO;
    //lixeira.physicsBody.linearDamping     = 0.8;
    
    SKAction *movimentoLixeira = [ SKAction animateWithTextures:texturesLixeira timePerFrame: 0.01 ];
    SKAction *repeatLixeira    = [ SKAction repeatActionForever:movimentoLixeira ];
    [ lixeira runAction:repeatLixeira ];
    [ lixeira setScale:0.45 ];
    
    
    SKAction *movimentoHorizontalLixeira = [SKAction sequence: @[
                                                                 [SKAction waitForDuration: 2.0],
                                                                 [SKAction moveToX: 880 duration: 5.0],
                                                                 [SKAction waitForDuration: 2.0],
                                                                 [SKAction moveToX: 140 duration: 5.0]
                                                                 ]
                                            ];
    SKAction *movimentoVerticalLixeira = [SKAction sequence:@[
                                                              [SKAction waitForDuration:0.0],
                                                              [SKAction moveToY:230 duration:0.8],
                                                              [SKAction moveToY:190 duration:0.8]]];
    
    [ lixeira runAction: [SKAction repeatActionForever: movimentoHorizontalLixeira] ];
    [ lixeira runAction: [SKAction repeatActionForever:movimentoVerticalLixeira] ];
    
    
    //animacao do esgoto na tela do jogo.
    SKTexture *esgoto1 = [ SKTexture textureWithImageNamed: @"esgoto1" ];
    SKTexture *esgoto2 = [ SKTexture textureWithImageNamed: @"esgoto2" ];
    SKTexture *esgoto3 = [ SKTexture textureWithImageNamed: @"esgoto3" ];
    
    NSArray *texturesEsgoto = @[ esgoto1, esgoto2, esgoto3 ];
    SKSpriteNode *esg1      = [ SKSpriteNode spriteNodeWithTexture:esgoto1 ];
    esg1.position           = CGPointMake( 90, 160 );
    esg1.zPosition          = 0.8;
    
    SKAction *movimento = [ SKAction animateWithTextures: texturesEsgoto timePerFrame: .35 ];
    SKAction *repeat    = [ SKAction repeatActionForever: movimento ];
    [ esg1 runAction: repeat ];
    [ esg1 setScale: 0.5 ];
    
    SKSpriteNode *esg2 = [ SKSpriteNode spriteNodeWithTexture: esgoto1 ];
    esg2.position      = CGPointMake( CGRectGetMidX( self.frame ), 160 );
    esg2.zPosition     = 0.8;
    
    SKAction *movimento2 = [ SKAction animateWithTextures: texturesEsgoto timePerFrame: .35 ];
    SKAction *repeat2    = [ SKAction repeatActionForever: movimento2 ];
    [ esg2 runAction: repeat2 ];
    [ esg2 setScale: 0.5 ];
    
    SKSpriteNode *esg3   = [ SKSpriteNode spriteNodeWithTexture: esgoto1 ];
    esg3.position        = CGPointMake( 890, 160 );
    esg3.zPosition       = 0.8;
    
    SKAction *movimento3 = [ SKAction animateWithTextures: texturesEsgoto timePerFrame: .35 ];
    SKAction *repeat3    = [ SKAction repeatActionForever: movimento3 ];
    [ esg3 runAction: repeat3 ];
    [ esg3 setScale: 0.5 ];
    
    //caixa da pontuação e recorde.
    SKSpriteNode *recorde = [SKSpriteNode spriteNodeWithImageNamed:@"bot9"];
    recorde.position = CGPointMake(CGRectGetMidX(self.frame), 720);
    [recorde setScale:0.50];
    
    //barras de vida
    SKSpriteNode *vida =  [ SKSpriteNode spriteNodeWithImageNamed: @"bot10" ];
    SKSpriteNode *vida2 = [ SKSpriteNode spriteNodeWithImageNamed: @"bot10" ];
    SKSpriteNode *vida3 = [ SKSpriteNode spriteNodeWithImageNamed: @"bot10" ];
    SKSpriteNode *vida4 = [ SKSpriteNode spriteNodeWithImageNamed: @"bot10" ];
    SKSpriteNode *vida5 = [ SKSpriteNode spriteNodeWithImageNamed: @"bot10" ];
    
    vida.position  = CGPointMake( 40, 730 );
    vida2.position = CGPointMake( 80, 730 );
    vida3.position = CGPointMake( 120, 730 );
    vida4.position = CGPointMake( 160, 730 );
    vida5.position = CGPointMake( 200, 730 );
    
    [ vida  setScale: 0.5 ];
    [ vida2 setScale: 0.5 ];
    [ vida3 setScale: 0.5 ];
    [ vida4 setScale: 0.5 ];
    [ vida5 setScale: 0.5 ];
    
    //botao de pause e play
    buttonPause = [ SKSpriteNode spriteNodeWithTexture: [SKTexture textureWithImageNamed: @"bot4"] ];
    [ buttonPause setScale: 0.5 ];
    buttonPause.position  = CGPointMake(960, 720);
    //    buttonPause.zPosition = 0.92;
    buttonPause.name      = @"botaoPause";
    
    //botao do audio
    buttonAudio = [ SKSpriteNode spriteNodeWithTexture: [SKTexture textureWithImageNamed: @"bot1"] ];
    [ buttonAudio setScale: 0.5 ];
    buttonAudio.position  = CGPointMake( 865, 720 );
    //    buttonAudio.zPosition = 0.91;
    buttonAudio.name      = @"botaoAudio";
    
    //texto da pontuação
    self.pontuacao = [ SKLabelNode labelNodeWithFontNamed: @"Arial" ];
    self.pontuacao.text      = @"0";
    self.pontuacao.fontColor = [ SKColor redColor ];
    self.pontuacao.fontSize  = 25;
    self.pontuacao.position  = CGPointMake( CGRectGetMidX(self.frame), 720 );
    //self.pontuacao.zPosition = 0.90;
    
    //texto do recorde
    _textoRecorde = [ SKLabelNode labelNodeWithFontNamed: @"Arial" ];
    _textoRecorde.text      = @"Recorde: ";
    _textoRecorde.fontColor = [ SKColor redColor ];
    _textoRecorde.fontSize  = 15;
    _textoRecorde.position  = CGPointMake( (CGRectGetMidX(self.frame) - 35), 695 );
    //self.textoRecorde.zPosition = 0.89;
    
    //adicionando os nodes na tela
    
    [ self addChild: telaInicial ];
    [ self addChild: guardreio ];
    [ self addChild: esg1 ];
    [ self addChild: esg2 ];
    [ self addChild: esg3 ];
    [ self addChild: recorde ];
    [ self addChild: vida ];
    [ self addChild: vida2 ];
    [ self addChild: vida3 ];
    [ self addChild: vida4 ];
    [ self addChild: vida5 ];
    [ self addChild: buttonPause ];
    [ self addChild: buttonAudio ];
    [ self addChild: lixeira ];
    //[ self addChild: self.pontuacao ];
    // [ self addChild: _textoRecorde ];    
    
}
//--------------------------------------------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    touch    = [ touches anyObject ];
    location = [ touch locationInNode: self ];
    node     = [ self nodeAtPoint: location ];
    //NSLog(@"Toquei em %@", node.name);
    
    
    //pegar objeto
    
    if ( [node.name isEqualToString: @"garrafaVidro" ] ){
        NSLog( @"pegou garrafa!" );
        SKNode *garrafa = node;
        [garrafa removeAllActions];
        garrafa.physicsBody.dynamic = NO;
        garrafa.physicsBody.affectedByGravity = NO;

        
        [node runAction:[SKAction playSoundFileNamed:@"Grab object.wav" waitForCompletion:YES]];
    }


    //ao clicar no botão irá alterar a imagem (Botão de pause/play)
    if ( [node.name isEqualToString:@"botaoPause"] ) {
        NSLog(@"botão pause pressionado");
        if(paused == YES){
            [buttonPause setTexture:[SKTexture textureWithImageNamed:@"bot3.png"]];
            buttonPause.zPosition = 2;
            
        }
    }
    
    //ao clicar no botão irá alterar a imagem (Com som/sem som)
    if ([node.name isEqualToString:@"botaoAudio"]) {
        NSLog(@"botão audio pressionado");
        if(audioPaused == YES){
            [buttonAudio setTexture:[SKTexture textureWithImageNamed:@"bot1.png"]];
            buttonAudio.zPosition = 2;
            
        }
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    SKNode *garrafa = node;
    
    touchFinger = [ touches anyObject ];
    locObj = [ touch locationInNode: self];
    
    if ( [node.name isEqualToString: @"garrafaVidro" ] ){
        //node = [ self nodeAtPoint: locObj ];
        
        garrafa.position = locObj;
    }
    
    
    
    
}
//--------------------------------------------------------------
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    SKNode *garrafa = node;
    
    if (node.name != nil && [node.name isEqualToString:@"garrafaVidro"]) {
        
        if((CGRectContainsPoint(lixeira.frame, garrafa.position))){
            
            [garrafa removeFromParent];
            
            [self runAction: [SKAction playSoundFileNamed:@"Destroy.wav" waitForCompletion:YES]];
            
            //garrafa = nil;
        }
        
    }
    NSLog( @"soltou objeto");
    if ([node.name isEqualToString:@"botaoPause"]) {
        NSLog(@"botão pause pressionado");
        if(paused == YES){
            self.paused = YES;
            paused = NO;
            buttonPause.zPosition = 2;
        }
        else{
            self.paused = NO;
            paused = YES;
            [buttonPause setTexture:[SKTexture textureWithImageNamed:@"bot4.png"]];
            buttonPause.zPosition = 2;
        }
        
    }
    
    if ([node.name isEqualToString:@"botaoAudio"]) {
        NSLog(@"botao audio pressionado");
        if (audioPaused == YES) {
            //self.paused = YES;
            audioPaused = NO;
            buttonAudio.zPosition = 2;
        }
        else{
            
            //self.paused = NO;
            audioPaused = YES;
            [buttonAudio setTexture:[SKTexture textureWithImageNamed:@"bot2.png"]];
            buttonAudio.zPosition = 2;
            
        }
    }
    
    
    
    
}
//----------------------------------------------------------------------------------------
-(void)update:(NSTimeInterval)currentTime {
    
    [ self.waterController waterSimulation: self ];
    [ self.waterController infiniteScrollingWater: self ];
//    [ self criaAutomoveis ];
//    [ self animaAutomovel: self.carro1 ];
    [ self.autoController criaAutomoveis: self ];
    [ self.autoController animaAutomovel: self autoMovel: self.autoController.carro1 ];
}
//--------------------------------------------------------------
@end

