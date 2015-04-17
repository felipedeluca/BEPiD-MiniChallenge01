//
//  AutomoveisController.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "AutomobileController.h"
#import "Random.h"

@interface AutomobileController()

@property ( nonatomic ) ObjectsController *objController;
@property ( nonatomic ) Random *rGenerator;

@end

@implementation AutomobileController

//--------------------------------------------------------------
-(instancetype)init {

    self.objController = [ [ObjectsController alloc] init ];
    self.rGenerator    = [ [Random alloc] init ];
    self.arrayCars     = [ [NSMutableArray alloc] init ];
    return self;
}
//--------------------------------------------------------------
-(void)createNewCars:(SKScene *)scene amount:(int)n {
    
    CGFloat positionY = CGRectGetMidY(scene.frame) - 40;

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
    
    for ( RWAutomobile *car in self.arrayCars ){
        //NSLog(@"Animating car: %@", car);
        
        CGFloat intervaloMinPosX = [ self.rGenerator floatRand: 0 high: 600 ]; // intervalo de espaço onde é permitido arremessar os objetos
        CGFloat intervaloMaxPosX = [ self.rGenerator floatRand: intervaloMinPosX + 10 high: intervaloMinPosX + 100 ]; // intervalo de espaço onde é permitido arremessar os objetos

        int throwingChance = [ self.rGenerator floatRand: 0 high: 10 ];
        
        // atira objetos se o automóvel estiver em movimento
        if ( [car hasActions] ){
            // Intervalo de posição permitido
            if ( car.position.x >= intervaloMinPosX && car.position.x <= intervaloMaxPosX && car.atirouObjeto == FALSE && throwingChance > 8 ){
                NSLog(@"Arremessou!!");
                RWLata *obj = [ [RWLata alloc] init ];
                obj.name = @"lata";
                
                CGFloat impulseForce = [ self.rGenerator floatRand: 30.0 high: 45.0 ];
                
                [ scene addChild: obj ];
                [ self.objController throwObject: obj parent: car impulse: impulseForce ];
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
