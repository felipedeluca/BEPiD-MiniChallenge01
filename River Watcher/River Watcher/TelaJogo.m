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
#import "RWGlassBottle.h"
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
    unsigned int  pontos;
}

//-------------------------------------------------------------------------------------

-(void)viewWillLayoutSubviews
{
    SKView * skView   = (SKView *)self.view;
    UIView *pauseMenu = [[UIView alloc] initWithFrame:buttonPause.frame];
    
    [skView addSubview:pauseMenu];
}

//-----------------------------------------------------------------------------------------
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
    NSLog(@"****starting createNewCars...");
    [ self.autoController createNewCars: self amount: 6 ];

}
//--------------------------------------------------------------
-(void)criaCenario {
    
    self.view.multipleTouchEnabled=NO;
    
    // Initializes the object controllers
    self.autoController     = [ [AutomobileController alloc] init ];
    self.waterController    = [ [WaterController      alloc] init ];
    self.trashCanController = [ [TrashCanController   alloc] init ];
//
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
    [esg2 runAction: repeat2];
    [esg2 setScale: 0.5];
    
    SKSpriteNode *esg3   = [SKSpriteNode spriteNodeWithTexture: esgoto1];
    esg3.position        = CGPointMake( 890, 160 );
    esg3.zPosition       = 0.8;
    
    SKAction *movimento3 = [SKAction animateWithTextures: texturesEsgoto timePerFrame: .35];
    SKAction *repeat3    = [SKAction repeatActionForever: movimento3];
    [esg3 runAction: repeat3];
    [esg3 setScale: 0.5];
    
    //caixa da pontuação e recorde.
    SKSpriteNode *recorde = [SKSpriteNode spriteNodeWithImageNamed:@"bot9"];
    recorde.position = CGPointMake(CGRectGetMidX(self.frame), 720);
    [recorde setScale:0.50];
    
    //barras de vida
    SKSpriteNode *vida =  [SKSpriteNode spriteNodeWithImageNamed: @"bot10"];
    SKSpriteNode *vida2 = [SKSpriteNode spriteNodeWithImageNamed: @"bot10"];
    SKSpriteNode *vida3 = [SKSpriteNode spriteNodeWithImageNamed: @"bot10"];
    SKSpriteNode *vida4 = [SKSpriteNode spriteNodeWithImageNamed: @"bot10"];
    SKSpriteNode *vida5 = [SKSpriteNode spriteNodeWithImageNamed: @"bot10"];
    
    vida.position  = CGPointMake(40,730);
    vida2.position = CGPointMake(80,730);
    vida3.position = CGPointMake(120,730);
    vida4.position = CGPointMake(160,730);
    vida5.position = CGPointMake(200,730);
    
    [vida  setScale: 0.5];
    [vida2 setScale: 0.5];
    [vida3 setScale: 0.5];
    [vida4 setScale: 0.5];
    [vida5 setScale: 0.5];
    
    //botao de pause e play
    buttonPause = [SKSpriteNode spriteNodeWithTexture: [SKTexture textureWithImageNamed: @"bot4"]];
    [buttonPause setScale: 0.5];
    buttonPause.position  = CGPointMake(960, 720);
    //    buttonPause.zPosition = 0.92;
    buttonPause.name      = @"botaoPause";
    
    //botao do audio
    buttonAudio = [SKSpriteNode spriteNodeWithTexture: [SKTexture textureWithImageNamed: @"bot1"]];
    [buttonAudio setScale: 0.5];
    buttonAudio.position  = CGPointMake( 865, 720 );
    //    buttonAudio.zPosition = 0.91;
    buttonAudio.name      = @"botaoAudio";
    
    //texto da pontuação
    self.pontuacao = [[SKLabelNode alloc] initWithFontNamed:@"PressStart2P"];
    pontos = 0;
    self.pontuacao.text      = [NSString stringWithFormat:@"%i", pontos];
    self.pontuacao.name      = @"score";
    self.pontuacao.fontColor = [SKColor redColor];
    [self.pontuacao setFontSize:25];
    self.pontuacao.position  = CGPointMake(CGRectGetMidX(self.frame), 720);
    self.pontuacao.zPosition = 2;
    
    //texto do recorde
    self.textoRecorde = [[SKLabelNode alloc] initWithFontNamed:@"PressStart2P"];
    self.textoRecorde.text      = @"Recorde: ";
    self.textoRecorde.name      = @"Recorde: ";
    self.textoRecorde.fontColor = [SKColor redColor];
    [self.textoRecorde setFontSize:15];
    self.textoRecorde.position  = CGPointMake((CGRectGetMidX(self.frame) - 35), 695);
    self.textoRecorde.zPosition = 2;
    
    //adicionando os nodes na tela
    [self addChild: telaInicial];
    [self addChild: guardreio];
    [self addChild: esg1];
    [self addChild: esg2];
    [self addChild: esg3];
    [self addChild: recorde];
    [self addChild: vida];
    [self addChild: vida2];
    [self addChild: vida3];
    [self addChild: vida4];
    [self addChild: vida5];
    [self addChild: buttonPause];
    [self addChild: buttonAudio];
    
    [self addChild: _pontuacao];
    [self addChild: _textoRecorde];
}

//--------------------------------------------------------------

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touch    = [touches anyObject];
    location = [touch locationInNode: self];
    node     = [self nodeAtPoint: location];
    //NSLog(@"Toquei em %@", node.name);
    
    //pegar objeto
    if(paused == YES){
        if ( [node isKindOfClass: [RWBasicObject class]] ){
            NSLog( @"pegou objeto!" );
            RWBasicObject *obj = (RWBasicObject *)node;
            [obj removeAllActions];
            obj.physicsBody.dynamic = NO;
            obj.physicsBody.affectedByGravity = NO;
        
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
    
    RWBasicObject *obj = ( RWBasicObject* )node;
    
    touchFinger = [ touches anyObject ];
    locObj = [ touch locationInNode: self];

    if(paused == YES){
        if ( [node isKindOfClass: [RWBasicObject class]] && !obj.inWater ){
            obj.position = locObj;
        }
    }
}

//--------------------------------------------------------------

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    RWBasicObject *obj = (RWBasicObject *)node;
    
 //   if (node.name != nil && [node.name isEqualToString:@"garrafaVidro"]) {
      if ( node.name != nil && [node isKindOfClass: [RWBasicObject class]] ) {
    
        
        if((CGRectContainsPoint( self.trashCanController.trashCan.frame, obj.position))){
            
            [obj removeFromParent];
            
            [self runAction: [SKAction playSoundFileNamed:@"Destroy.wav" waitForCompletion:YES]];
            pontos += 10;
            self.pontuacao.text = [NSString stringWithFormat:@"%i", pontos];
           
            
        }
        else {
            obj.physicsBody.affectedByGravity = YES;
            obj.physicsBody.dynamic = YES;
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
    [ self.autoController animateCars: self ];
}

//--------------------------------------------------------------
@end

