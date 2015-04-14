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

    self.objController = [ [ObjectsController alloc] init ];
    return self;
}
//--------------------------------------------------------------
-(void)criaAutomoveis:(SKScene *)scene {
    
    CGFloat positionY = CGRectGetMidY(scene.frame) - 40;
        
    if ( self.carro1.img == nil ){
        self.carro1 = [ [RWCar1 alloc] init ];
        self.carro1.img.position = CGPointMake( CGRectGetMidX(scene.frame) + 600, positionY );
        self.carro1.img.zPosition = 0.0;
        
        [ scene addChild: self.carro1.img ];
    }
}
//----------------------------------------------------------------------------------------
-(void)throwObject:(SKSpriteNode *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse {
    //  NSLog( @"Parent %@!", parentNode.physicsBody.velocity );
    
    obj.position = parentNode.img.position;
    obj.physicsBody.velocity = parentNode.img.physicsBody.velocity;
    
    CGFloat dx = throwImpulse * 5;//cosf(parentNode.zRotation);
    CGFloat dy = throwImpulse * 20;//sinf(parentNode.zRotation);
    
    
    [ obj.physicsBody applyForce: CGVectorMake(dx, dy) ];
}
//--------------------------------------------------------------
-(void)animaAutomovel:(SKScene *)scene autoMovel:(RWAutomobile *)automovel {
    
    CGFloat intervaloMinPosX = 300; // intervalo de espaço onde é permitido arremessar os objetos
    CGFloat intervaloMaxPosX = 600; // intervalo de espaço onde é permitido arremessar os objetos
    
    // atira objetos se o automóvel estiver em movimento
    if ( [automovel.img hasActions] ){
        // Intervalo de posição permitido
        if ( automovel.img.position.x >= intervaloMinPosX && automovel.img.position.x <= intervaloMaxPosX && automovel.atirouObjeto == FALSE ){
            NSLog(@"Arremessou!!");
            RWGlassBottle *garrafaVidro = [ [RWGlassBottle alloc] init ];
            garrafaVidro.name = @"garrafaVidro";
 
            [ scene addChild: garrafaVidro ];
            [ self.objController throwObject: garrafaVidro parent: automovel impulse: 50.0 ];
            automovel.atirouObjeto = TRUE;
        }
        
        return;
    }
    
    automovel.atirouObjeto = FALSE;
    
    CGFloat leftToRightStartX = -100;
    CGFloat rightToLeftStartX = scene.frame.size.width + automovel.img.size.width;
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


@end
