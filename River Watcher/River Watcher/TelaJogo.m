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

@property ( nonatomic, strong ) WLCarro1 *carro1;//

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
        
        
}
    
}
//----------------------------------------------------------------------------------------
-(void)createSceneContents{

    [ self criaCenario ];
    [ self criaAgua ];
    [ self criaNave ];
    [ self criaAutomoveis ];
}
//--------------------------------------------------------------
-(void)criaAutomoveis {
    
    CGFloat positionY = CGRectGetMidY(self.frame) - 40;
    
    
    if ( self.carro1.img == nil ){
        self.carro1 = [ [WLCarro1 alloc] init ];
        self.carro1.img.position = CGPointMake( CGRectGetMidX(self.frame) + 600, positionY );
        self.carro1.img.zPosition = 0.0;
        
        [ self addChild: self.carro1.img ];
    }
    
}
//--------------------------------------------------------------
-(void)animaAutomovel:(WLAutomovel *)automovel {

    CGFloat intervaloMinPosX = 300; // intervalo de espaço onde é permitido arremessar os objetos
    CGFloat intervaloMaxPosX = 600; // intervalo de espaço onde é permitido arremessar os objetos
    
    // atira objetos se o automóvel estiver em movimento
    if ( [automovel.img hasActions] ){
        // Intervalo de posição permitido
        if ( automovel.img.position.x >= intervaloMinPosX && automovel.img.position.x <= intervaloMaxPosX && automovel.atirouObjeto == FALSE ){
            NSLog(@"Arremessou!!");
            WLGarrafaVidro *garrafaVidro = [ [WLGarrafaVidro alloc] init ];
            garrafaVidro.img.name = @"garrafaVidro";
            
            [ self addChild: garrafaVidro.img ];
            [ self throwObject: garrafaVidro.img parent: automovel impulse: 50.0 ];
            automovel.atirouObjeto = TRUE;
        }

        return;
    }
    
    automovel.atirouObjeto = FALSE;
    
    CGFloat leftToRightStartX = -100;
    CGFloat rightToLeftStartX = self.frame.size.width + automovel.img.size.width;
    CGFloat duracaoMovimento  = 5.0;
    CGFloat imageFlip         = 1.0; // aponta o carro para o sentido do movimento
    CGFloat startPosition     = leftToRightStartX;
    CGFloat endPosition       = rightToLeftStartX;
    
    if ( automovel.img.position.x < 0 ){
        startPosition = leftToRightStartX;
        endPosition   = rightToLeftStartX;
        //imageFlip     = 1.0;
        
    }
    else if ( automovel.img.position.x >= 0 ){
        startPosition = rightToLeftStartX;
        endPosition   = leftToRightStartX;
        imageFlip     = -1.0;
    }
    
    SKAction *movimentoAutomovel = [SKAction sequence:@[
                                                        [ SKAction waitForDuration: 0.0 ],
                                                        [ SKAction moveToX: startPosition duration: duracaoMovimento ],
                                                        [ SKAction moveToX: endPosition   duration: duracaoMovimento ]
                                                        ]
                                    ];
 
    
    [ automovel.img setXScale: imageFlip ];
    [ automovel.img runAction: movimentoAutomovel ];
  //  NSLog( @"Pos X: %.2f", automovel.img.position.x );

    
}
//--------------------------------------------------------------

-(void)criaCenario {

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
-(void)criaNave {

//    SKSpriteNode *spaceShip = [ [SpaceShip alloc] init ];
//    spaceShip.position = CGPointMake( CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) );
//    spaceShip.zPosition = 0.1;
//    
//    [ self addChild: spaceShip ];
//    
}
//--------------------------------------------------------------
-(void)criaAgua {
    
    CGFloat offset = - 20.0;

    self.waterTile2A = [ [WLWater2 alloc] init ];
    self.waterTile2B = [ [WLWater2 alloc] init ];
    self.waterTile2A.img.position = CGPointMake( 0, - (self.size.height / 2.0) + 50 + offset );
    self.waterTile2B.img.position = CGPointMake( self.waterTile2A.img.position.x + self.waterTile2B.img.size.width, self.waterTile2A.img.position.y );
    
//    self.waterTile2A.img.zPosition = 1.0;
//    self.waterTile2B.img.zPosition = 1.5;

    [ self addChild: self.waterTile2A.img ];
    [ self addChild: self.waterTile2B.img ];
    
    self.waterTile1A = [ [WLWater1 alloc] init ];
    self.waterTile1B = [ [WLWater1 alloc] init ];
    self.waterTile1A.img.position = CGPointMake( 0, - (self.size.height / 2.0) + 53 + offset );
    self.waterTile1B.img.position = CGPointMake( self.waterTile1A.img.position.x + self.waterTile1B.img.size.width, self.waterTile1A.img.position.y );

//    self.waterTile1A.img.zPosition = 2.0;
//    self.waterTile1B.img.zPosition = 2.5;
    
    [ self addChild: self.waterTile1A.img ];
    [ self addChild: self.waterTile1B.img ];
    
    self.waterPhys = [ [SKSpriteNode alloc] init ];
    self.waterPhys = [[SKSpriteNode alloc] initWithColor:[UIColor cyanColor] size:CGSizeMake(self.size.width, 200)];
    self.waterPhys.zPosition = 1.0;

    self.waterPhys.position = CGPointMake( (self.size.width / 2.0), + 20 + offset);
    self.waterPhys.alpha = 0.0;
    
    [ self addChild: self.waterPhys ];
    
}
//--------------------------------------------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    

    touch    = [ touches anyObject ];
    location = [ touch locationInNode: self ];
    node     = [ self nodeAtPoint: location ];
    
    //pegar objeto

   // img.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"garrafaVidro" ] size: self.size ];
    //NSLog(@"-----OBJETO: %@", node);
    
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
    
    
    
    if ( [node.name isEqualToString: @"garrafaVidro" ] ){
        touchFinger = [ touches anyObject ];
        locObj = [ touch locationInNode: self];
        node = [ self nodeAtPoint: locObj ];

        garrafa.position = locObj;
    }
    
   
    
    
}



//----------------------------------------------------------------------------------------
-(void)throwObject:(SKSpriteNode *)obj parent:(WLAutomovel *)parentNode impulse:(CGFloat)throwImpulse {
    //  NSLog( @"Parent %@!", parentNode.physicsBody.velocity );
    
    obj.position = parentNode.img.position;
    obj.physicsBody.velocity = parentNode.img.physicsBody.velocity;
    
    CGFloat dx = throwImpulse * 5;//cosf(parentNode.zRotation);
    CGFloat dy = throwImpulse * 20;//sinf(parentNode.zRotation);
    
 
    [ obj.physicsBody applyForce: CGVectorMake(dx, dy) ];
}


//--------------------------------------------------------------
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

//    if ( [node.name isEqualToString: @"Spaceship"] ){
//        WLGarrafaVidro *garrafaVidro = [ [WLGarrafaVidro alloc] init ];
//        
//        [ self addChild: garrafaVidro.img ];
//        
//        [ self throwObject: garrafaVidro.img parent: node impulse: 4.0 ];
//        
//    }

    SKNode *garrafa = node;
    if((CGRectContainsPoint(lixeira.frame, garrafa.position))){
        
        [garrafa removeFromParent];
        
        [self runAction: [SKAction playSoundFileNamed:@"destroy.wav" waitForCompletion:YES]];
        
        garrafa = nil;
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
    
    [ self waterSimulation ];
    [ self infiniteScrollingWater ];
    [ self criaAutomoveis ];
    [ self animaAutomovel: self.carro1 ];
}
//--------------------------------------------------------------
-(void)infiniteScrollingWater{
    // scrolling infinito para a água
    
    CGFloat x1, x2, x3, x4;
    
    CGFloat sceneWidth = self.size.width + self.waterTile2A.img.size.width;
    
    if ( self.waterTile2A.img.position.x + (self.waterTile2A.img.size.width / 2.0) > sceneWidth ) {
        x2 = self.waterTile2B.img.position.x + 1;
        x1 = x2 - self.waterTile2A.img.size.width;
    }
    else if ( self.waterTile2B.img.position.x + (self.waterTile2B.img.size.width / 2.0) > sceneWidth ) {
        x1 = self.waterTile2A.img.position.x + 1;
        x2 = x1 - self.waterTile2B.img.size.width;
    }
    else{
        x1 = self.waterTile2A.img.position.x;
        x2 = self.waterTile2B.img.position.x;
    }
    
    
    if ( self.waterTile1A.img.position.x + (self.waterTile1A.img.size.width / 2.0) > sceneWidth ) {
        x4 = self.waterTile1B.img.position.x;
        x3 = x4 - self.waterTile1A.img.size.width;
    }
    else if ( self.waterTile1B.img.position.x + (self.waterTile1B.img.size.width / 2.0) > sceneWidth ) {
        x3 = self.waterTile1A.img.position.x;
        x4 = x3 - self.waterTile1B.img.size.width;
    }
    else{
        x3 = self.waterTile1A.img.position.x;
        x4 = self.waterTile1B.img.position.x;
    }
    
    self.waterTile2A.img.position = CGPointMake( x1 + 1.2, self.waterTile2A.img.position.y );
    self.waterTile2B.img.position = CGPointMake( x2 + 1.2, self.waterTile2A.img.position.y );
    
    self.waterTile1A.img.position = CGPointMake( x3 + 0.6, self.waterTile1A.img.position.y );
    self.waterTile1B.img.position = CGPointMake( x4 + 0.6, self.waterTile1A.img.position.y );
}
//--------------------------------------------------------------
-(void)waterSimulation{
    //Créditos para o código abaixo: Epic Byte
    // fonte: http://stackoverflow.com/questions/25344808/simulate-water-make-sprite-float-on-water-in-spritekit
    // Executa a simulação de água
    
    for ( SKSpriteNode *n in self.children ){
        if ( CGRectContainsPoint(self.waterPhys.frame, CGPointMake(n.position.x, n.position.y - n.size.height/2.0)) ) {
            const CGFloat rate      = 0.01; //Controls rate of applied motion. You shouldn't really need to touch this.
            const CGFloat disp      = ( ((self.waterPhys.position.y + OFFSET) + self.waterPhys.size.height / 2.0) - ((n.position.y) - n.size.height / 2.0)) * BUOYANCY;
            const CGPoint targetPos = CGPointMake( n.position.x, n.position.y + disp );
            const CGPoint targetVel = CGPointMake( (targetPos.x - n.position.x) / (1.0 / 60.0), (targetPos.y - n.position.y) / (1.0 / 60.0));
            const CGVector relVel   = CGVectorMake( targetVel.x - n.physicsBody.velocity.dx * VISCOSITY, targetVel.y - n.physicsBody.velocity.dy * VISCOSITY);
            n.physicsBody.velocity  = CGVectorMake( n.physicsBody.velocity.dx + relVel.dx * rate, n.physicsBody.velocity.dy + relVel.dy * rate );
        }
    }
}
//----------------------------------------------------------------
@end

