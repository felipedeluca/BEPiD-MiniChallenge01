//
//  TelaJogo.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "TelaJogo.h"
#import "RWWater1.h"
#import "WLWater2.h"
#import "SpaceShip.h"
#import "RWGlassBottle.h"
#import "RWAutomobile.h"
#import "RWCar1.h"
#import "AutomobileController.h"
#import "ObjectsController.h"
#import "WaterController.h"
#import "TrashCanController.h"
#import "RWBasicObject.h"

// Configuração da água
#define VISCOSITY 6.0 //Increase to make the water "thicker/stickier," creating more friction.
#define BUOYANCY 0.4 //Slightly increase to make the object "float up faster," more buoyant.
#define OFFSET 70.0 //Increase to make the object float to the surface higher.

@interface TelaJogo()

@property BOOL contentCreated;

@property ( nonatomic ) ObjectsController    *objController;
@property ( nonatomic ) AutomobileController *autoController;
@property ( nonatomic ) WaterController      *waterController;
@property ( nonatomic ) TrashCanController   *trashCanController;

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
}
//--------------------------------------------------------------

-(void)criaCenario {
    
  
    self.view.multipleTouchEnabled=NO;
    
    // Initializes the object controllers
    self.autoController     = [ [AutomobileController alloc] init ];
    self.waterController    = [ [WaterController      alloc] init ];
    self.trashCanController = [ [TrashCanController   alloc] init ];

    [ self.waterController criaAgua: self ];
    [ self.trashCanController newTrashCan: self ];
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
//    [ self addChild: lixeira ];
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
    if(paused == YES){
        if ( [node.name isEqualToString: @"garrafaVidro" ] ){
            NSLog( @"pegou garrafa!" );
            SKNode *garrafa = node;
            [garrafa removeAllActions];
            garrafa.physicsBody.dynamic = NO;
            garrafa.physicsBody.affectedByGravity = NO;
        
            [node runAction:[SKAction playSoundFileNamed:@"Grab object.wav" waitForCompletion:YES]];
        }
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
//--------------------------------------------------------------
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    RWGlassBottle *garrafa = ( RWGlassBottle* )node;
    
    touchFinger = [ touches anyObject ];
    locObj = [ touch locationInNode: self];

    if(paused == YES){
        if ( [node isKindOfClass: [RWBasicObject class]] ){
        //RWBasicObject *obj = (RWBasicObject*) node;
            if ( [garrafa.name isEqualToString: @"garrafaVidro" ] && !garrafa.inWater ){
            //node = [ self nodeAtPoint: locObj ];
                
                garrafa.position = locObj;
        
        
            }
        }
    }
}
//--------------------------------------------------------------
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    SKNode *garrafa = node;
    
    if (node.name != nil && [node.name isEqualToString:@"garrafaVidro"]) {
        
        
        if((CGRectContainsPoint( self.trashCanController.trashCan.img.frame, garrafa.position))){
            
            [garrafa removeFromParent];
            
            [self runAction: [SKAction playSoundFileNamed:@"Destroy.wav" waitForCompletion:YES]];
            
            //garrafa = nil;
        }
        else {
            garrafa.physicsBody.affectedByGravity = YES;
            garrafa.physicsBody.dynamic = YES;
        }
    NSLog( @"soltou objeto");
    }
    
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
    [ self.autoController animaAutomovel: self autoMovel: self.autoController.carro2 ];
    [ self.autoController animaAutomovel: self autoMovel: self.autoController.carro3 ];
    [ self.autoController animaAutomovel: self autoMovel: self.autoController.carro4 ];
    [ self.autoController animaAutomovel: self autoMovel: self.autoController.carro5 ];
    [ self.autoController animaAutomovel: self autoMovel: self.autoController.carro6 ];
}
//--------------------------------------------------------------
@end

