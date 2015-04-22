//
//  AutomoveisController.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "AutomobileController.h"

@interface AutomobileController()

@property ( nonatomic ) ObjectsController *objController;
@property ( nonatomic ) Random *rGenerator;
@property ( nonatomic ) int fpsCounter;

@end

@implementation AutomobileController

//--------------------------------------------------------------
-(instancetype)init {

    self.objController    = [ [ObjectsController alloc] init ];
    self.rGenerator       = [ [Random alloc] init ];
    self.arrayCars        = [ [NSMutableArray alloc] init ];
    self.fpsCounter       = 1;
    self.currentGameDifficult = 30;
    self.maxGameDifficult     = 100;
    return self;
}
//--------------------------------------------------------------
-(void)createNewCars:(SKScene *)scene amount:(int)n {
    
    CGFloat positionY = CGRectGetMidY(scene.frame) - 65;

    for ( int i = 0; i < n; i++ ){
        RWAutomobile *newCar = [ [RWAutomobile alloc] init ];
        
        int startingDirection = (int)([ self.rGenerator floatRand: -10 high: 1 ]) % 2;
        if ( startingDirection == 0 )
            startingDirection = 1;
        
        NSLog(@"Starting direction: %d", startingDirection);
        
        int textureNumber = ( arc4random() % 6 ) + 1; // numeros entre 1 e 6
        NSLog(@"Texture loaded: %d", textureNumber);
        
        SKTexture *newTexture = [ SKTexture textureWithImageNamed: [NSString stringWithFormat: @"carro%d", textureNumber] ];
        
        newCar.position = CGPointMake( CGRectGetMidX(scene.frame) + (700 * startingDirection), positionY );
        [ newCar setTexture: newTexture ];
        newCar.zPosition = 0.0;
        newCar.animDuration = [ self.rGenerator floatRand: 3 high: 10 ] ;
        newCar.animWaitTime = [ self.rGenerator floatRand: 2 high: 5 ];
        newCar.animWaitForDuration = [ self.rGenerator floatRand: 1 high: 4 ];
        
        NSLog(@"Car created...");
        [ self.arrayCars addObject: newCar ];
        [ scene addChild: [self.arrayCars lastObject] ];
    }
    
}
//----------------------------------------------------------------------------------------
-(void)animateCars:(SKScene *)scene {
    
    [ self.objController destroyObjectsOffScreen: scene ];
    for ( RWAutomobile *car in self.arrayCars ){
        //NSLog(@"Animating car: %@", car);
        
        self.fpsCounter += 1;
        if ( self.fpsCounter >= 21 )
            self.fpsCounter = 1;
        
        CGFloat willingToThrow      = ([ self.rGenerator floatRand: 0.0 high: 10000.0 ] / 10000); // Desejo de jogar o lixo
        CGFloat throwingProbability = ( (self.currentGameDifficult - log10(self.currentGameDifficult)) / self.maxGameDifficult ) / 2; // Fator de impedimento: maior o número, mais chances de jogar
        
        CGFloat courageToThrow = (willingToThrow * throwingProbability) * (self.fpsCounter / 20); // Probabilidade por frame a cada 1/3 de segundo.
        
        CGFloat throwOportunity = ([ self.rGenerator floatRand: 0.0 high: 10000.0] / 10000.0 );
        
        CGFloat minOportunity   = throwOportunity - ( throwingProbability / self.maxGameDifficult );
        CGFloat maxOportunity   = throwOportunity + ( throwingProbability / self.maxGameDifficult );
        
        BOOL throwObject = FALSE;

<<<<<<< HEAD
        int throwingChance = [ self.rGenerator floatRand: 0 high: 10 ];
//        
//        if (car.position.x >= intervaloMinPosX && car.position.x <= intervaloMaxPosX && car.atirouObjeto == FALSE && throwingChance >= (9 - maxDiffRatio)) {
=======
        if ( (courageToThrow >= minOportunity) && (courageToThrow <= maxOportunity) )
            throwObject = TRUE;
        
        
//        if (car.position.x >= 0 && car.position.x <= scene.size.width && throwingChance == 1.0) {
>>>>>>> 43e25d94b53bb9d75d064559c45fed7e86818b89
//            [car runAction:[SKAction playSoundFileNamed:@"CarHorn.wav" waitForCompletion:YES]];
//        }
        
        // atira objetos se o automóvel estiver em movimento
        if ( [car hasActions] ){
            // Intervalo de posição permitido
            
<<<<<<< HEAD
            if ( car.position.x >= intervaloMinPosX && car.position.x <= intervaloMaxPosX && car.atirouObjeto == FALSE && throwingChance >= (9 - maxDiffRatio) ){
                
                [car runAction:[SKAction playSoundFileNamed:@"throw object.wav" waitForCompletion:YES]];
                
=======
            if ( car.position.x >= 0.0 && car.position.x <= scene.size.width && throwObject && self.objController.objectsInTheAir <= self.objController.maxObjectsInTheAir ){
//                self.objController.objectsInTheAir += 1;
                
                NSLog(@"--Arremessou! Chances: %.3f   DIFICULDADE: %.3f   MIN: %.3f  CORAGEM: %.3f   MAX: %.3f", throwingProbability * 100, self.currentGameDifficult, minOportunity, courageToThrow, maxOportunity );
 
>>>>>>> 43e25d94b53bb9d75d064559c45fed7e86818b89
                int imgNumber = [ self.rGenerator floatRand: 1 high: 6 ];
                
                NSString *imgName = [ NSString stringWithFormat: @"lixo%d", imgNumber ];
                RWLixo   *lixo    = [ [RWLixo alloc] initWithImageNamed: imgName ];
                                
                CGFloat impulseForce = [ self.rGenerator floatRand: 145.0 high: 150.0 ];
                
                [ scene addChild: lixo ];
                [ self.objController throwObject: scene object: lixo parent: car impulse: impulseForce ];
                car.atirouObjeto = TRUE;
            }
        }
        else {
        
            car.atirouObjeto = FALSE;
        
            CGFloat leftToRightStartX = -130;
            CGFloat rightToLeftStartX = scene.frame.size.width + car.size.width + 30;
            CGFloat imageFlip         = 1.0; // aponta o carro para o sentido do movimento
            CGFloat startPosition     = leftToRightStartX;
            CGFloat endPosition       = rightToLeftStartX;
        
            if ( car.position.x < 0 ){
                startPosition = leftToRightStartX - car.positionOffset;
                endPosition   = rightToLeftStartX + car.positionOffset;
                //imageFlip     = 1.0;
            
            }
            else if ( car.position.x >= 0 ){
                startPosition = rightToLeftStartX + car.positionOffset;
                endPosition   = leftToRightStartX - car.positionOffset;
                imageFlip     = -1.0;
            }
        
            SKAction *movimentoAutomovel = [SKAction sequence:@[
                                                                [ SKAction waitForDuration: car.animWaitTime ],
                                                                [ SKAction moveToX: startPosition duration: car.animWaitTime ],
                                                                [ SKAction moveToX: endPosition   duration: car.animDuration]
                                                                ]
                                            ];
            [ car setXScale: imageFlip ];
            [ car runAction: movimentoAutomovel ];
            
        }
    }
    
    //  NSLog( @"Pos X: %.2f", automovel.img.position.x );
    
}
//--------------------------------------------------------------


@end
