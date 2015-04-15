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

@end

@implementation AutomobileController

//--------------------------------------------------------------
-(instancetype)init {

    self.objController = [[ObjectsController alloc] init];
    return self;
}
//--------------------------------------------------------------
-(void)criaAutomoveis:(SKScene *)scene {
    
    CGFloat positionY = CGRectGetMidY(scene.frame) - 40;
        
    if ( self.carro1 == nil ){
        self.carro1 = [ [RWCar1 alloc] init ];
        self.carro1.position = CGPointMake( CGRectGetMidX(scene.frame) + 600, positionY );
        self.carro1.zPosition = 0.0;
        
        [ scene addChild: self.carro1 ];
    }
    
    if ( self.carro2 == nil ){
        self.carro2 = [ [RWCar2 alloc] init ];
        self.carro2.position = CGPointMake( CGRectGetMidX(scene.frame) + 700, positionY );
        self.carro2.zPosition = 0.0;
        
        [ scene addChild: self.carro2 ];
    }
    
    if ( self.carro3 == nil ){
        self.carro3 = [ [RWCar3 alloc] init ];
        self.carro3.position = CGPointMake( CGRectGetMidX(scene.frame) + 700, positionY );
        self.carro3.zPosition = 0.0;
        
        [scene addChild: self.carro3];
    }
    
    if (self.carro4 == nil){
        self.carro4 = [ [RWCar4 alloc] init ];
        self.carro4.position = CGPointMake( CGRectGetMidX(scene.frame) + 700, positionY );
        self.carro4.zPosition = 0.0;
        
        [scene addChild: self.carro4];
    }
    
    if ( self.carro5 == nil ){
        self.carro5 = [[RWCar5 alloc] init];
        self.carro5.position = CGPointMake( CGRectGetMidX(scene.frame) + 700, positionY );
        self.carro5.zPosition = 0.0;
        [scene addChild: self.carro5];
    }
    
    if ( self.carro6 == nil ){
        self.carro6 = [[RWCar6 alloc] init];
        self.carro6.position = CGPointMake( CGRectGetMidX(scene.frame) + 700, positionY );
        self.carro6.zPosition = 0.0;
        [scene addChild: self.carro6];
    }
}
//----------------------------------------------------------------------------------------
-(void)animaAutomovel:(SKScene *)scene autoMovel:(RWAutomobile *)automovel {
    
    CGFloat intervaloMinPosX = 300; // intervalo de espaço onde é permitido arremessar os objetos
    CGFloat intervaloMaxPosX = 600; // intervalo de espaço onde é permitido arremessar os objetos
    
    // atira objetos se o automóvel estiver em movimento
    if ( [automovel hasActions] ){
        // Intervalo de posição permitido
        if ( automovel.position.x >= intervaloMinPosX && automovel.position.x <= intervaloMaxPosX && automovel.atirouObjeto == FALSE ){
            NSLog(@"Arremessou!!");
            RWGlassBottle *garrafaVidro = [ [RWGlassBottle alloc] init ];
            garrafaVidro.name = @"garrafaVidro";
 
            [ scene addChild: garrafaVidro ];
            [ self.objController throwObject: garrafaVidro parent: automovel impulse: 40.0 ];
            automovel.atirouObjeto = TRUE;
        }
        
        return;
    }
    
    automovel.atirouObjeto = FALSE;
    
    CGFloat leftToRightStartX = -100;
    CGFloat rightToLeftStartX = scene.frame.size.width + automovel.size.width;
    CGFloat duracaoMovimento  = 5.0;
    CGFloat imageFlip         = 1.0; // aponta o carro para o sentido do movimento
    CGFloat startPosition     = leftToRightStartX;
    CGFloat endPosition       = rightToLeftStartX;
    
    if ( automovel.position.x < 0 ){
        startPosition = leftToRightStartX;
        endPosition   = rightToLeftStartX;
        //imageFlip     = 1.0;
        
    }
    else if ( automovel.position.x >= 0 ){
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
    [ automovel setXScale: imageFlip ];
    [ automovel runAction: movimentoAutomovel ];
    //  NSLog( @"Pos X: %.2f", automovel.img.position.x );
    
}
//--------------------------------------------------------------


@end
