//
//  DuckController.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/23/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "DuckController.h"
#import "ObjectsController.h"
#import "Random.h"

@interface DuckController()

@property ( nonatomic ) NSMutableArray * duckArray;
@property ( nonatomic ) ObjectsController * objController;
@property ( nonatomic ) Random * rGenerator;
@property ( nonatomic ) int fpsCounter;

@end

@implementation DuckController
//----------------------------------------------------------
-(instancetype)init {
    
    self.objController    = [ ObjectsController InitObjController ];
    self.rGenerator       = [ [Random alloc] init ];
    self.duckArray        = [ [NSMutableArray alloc] init ];
    self.fpsCounter       = 1;
    return self;
}
//----------------------------------------------------------
-(void)duckOnWater:(RWDuck *)duck {
    NSLog(@"##### Pato na água!!!");
    
    duck.physicsBody.dynamic            = NO;
    duck.physicsBody.affectedByGravity  = NO;
    duck.physicsBody.collisionBitMask   = 0;
    duck.physicsBody.contactTestBitMask = 0;
    duck.physicsBody = nil;
    duck.rescued     = NO;
    duck.isMoving    = NO;
    duck.isFalling   = NO;
    duck.alreadyFloating = YES;
    
    [duck removeAllActions];
    SKAction *rotateAction = [ SKAction rotateToAngle: 0.0 duration: 0 ];
    [ duck runAction: rotateAction ];
    
    SKAction *duckOnWaterAction = [ SKAction animateWithTextures: duck.swimmingAnimation timePerFrame: 0.3 ];
    [ duck runAction: duckOnWaterAction ];
    
}
//----------------------------------------------------------
-(void)rescueTheDuck:(RWDuck *)duck {

    NSLog(@"##### Salvou o pato!!");
    [ self.objController animateHeart: self.parentScene object: duck ];
    [duck removeAllActions];
    [duck runAction: [SKAction playSoundFileNamed:@"duck hit.wav" waitForCompletion:YES]];
    duck.physicsBody.dynamic           = NO;
    duck.physicsBody.affectedByGravity = NO;
    duck.physicsBody = nil;
    duck.rescued     = YES;
    duck.isMoving    = NO;
    duck.isFalling   = NO;
    
    SKAction *rotateAction = [ SKAction rotateToAngle: 0.0 duration: 0 ];
    [ duck runAction: rotateAction ];
    
    [ duck setTexture: duck.objTexture ];
    [ duck loopAnimateWings ];
}
//----------------------------------------------------------
-(void)animateFall:(RWDuck *)duck {

    [ duck removeAllActions ];
    duck.isFalling = YES;
   
    SKAction *surpriseAction        = [ SKAction animateWithTextures: duck.surprisedAnimation timePerFrame: 0.3 ];
    SKAction *fallingAction1        = [ SKAction animateWithTextures: duck.fallingAnimation timePerFrame: 0.2 ];
    SKAction *fallingRepeatForever  = [ SKAction repeatActionForever: fallingAction1 ];
    
    [ duck runAction: surpriseAction
          completion:^{ [duck runAction: fallingRepeatForever]; }];
}
//----------------------------------------------------------
-(void)newDuck{
    
    SKScene *scene = self.parentScene;
    
    CGFloat positionY = CGRectGetMidY(scene.frame) + 170 + [ self.rGenerator floatRand: -20 high: 20 ];
    
    int startingDirection = (int)([ self.rGenerator floatRand: -20 high: 1 ]) % 2;
    if ( startingDirection == 0 )
        startingDirection = 1;
        
    NSLog(@"DUCK Starting direction: %d", startingDirection);
        
    //int textureNumber = ( arc4random() % 6 ) + 1; // numeros entre 1 e 6
    
//    SKTexture *newTexture = [ SKTexture textureWithImageNamed: [NSString stringWithFormat: @"carro%d", textureNumber] ];
    NSLog(@"DUCK Texture loaded");
    
    RWDuck *newDuck = [ [RWDuck alloc] initWithImageNamed: [NSString stringWithFormat: @"pato1"] ];

    newDuck.position = CGPointMake( CGRectGetMidX(scene.frame) + (700 * startingDirection), positionY );
//    [ newDuck setTexture: newTexture ];
//        newduck.zPosition = 0.0;
    newDuck.animDuration = [ self.rGenerator floatRand: 3 high: 10 ] ;
    newDuck.animWaitTime = [ self.rGenerator floatRand: 2 high: 8 ];
   // newDuck.animWaitForDuration = [ self.rGenerator floatRand: 1 high: 4 ];
        
    NSLog(@"Duck created...");
    [ self.duckArray addObject: newDuck ];
    [ scene addChild: [self.duckArray lastObject] ];
    
}
//----------------------------------------------------------
-(void)removeDuck:(RWDuck *)duck {
    
    [ duck removeFromParent ];
    [ self.duckArray removeObject: duck ];
    [ self newDuck ];
}
//----------------------------------------------------------
-(void)animateDuck {
    
    SKScene *scene = self.parentScene;
    int willPlayDuck            = [ self.rGenerator floatRand: 0 high: 200 ];

    for ( RWDuck *duck in self.duckArray ){

        if ( ((int)willPlayDuck % 50 == 0) && !duck.didPlayAnySound && duck.position.x >= 0.0 && duck.position.x <= scene.size.width){
            NSLog(@"Will play horn: %d", willPlayDuck);
            duck.didPlayAnySound = YES;
            [duck runAction:[SKAction playSoundFileNamed:@"duck flying.wav" waitForCompletion:YES]];
        }
        
        if ( duck.isInTheWater && !duck.alreadyFloating ){
            [ self duckOnWater: duck ];            
            int tempScore = (pontos * duck.scoreValue) / 100;
            
            if ( pontos - tempScore > 0 )
                pontos = pontos - tempScore;
            else
                pontos = 0;
            
            [ self.objController animateScore: scene object: duck score: -tempScore ];
        }

        if ( duck.isMoving == NO ){
            
            // restaura a orientação original
            if ( duck.xScale < 0 )
                duck.xScale = -duck.xScale;
            
            CGFloat leftToRightStartX = -130;
            CGFloat rightToLeftStartX = scene.frame.size.width + duck.size.width + 30;
            CGFloat imageFlip         = duck.xScale; // aponta o pato para o sentido do movimento
            
            CGFloat startPosition     = leftToRightStartX;
            CGFloat endPosition       = rightToLeftStartX;
            
            if ( duck.position.x <= 0 ){
                
                startPosition = leftToRightStartX - duck.positionOffset;
                endPosition   = rightToLeftStartX + duck.positionOffset;
                
                if ( duck.isFalling) // sai da tela caindo
                    [ self removeDuck: duck ];
            }
            else if ( duck.position.x >= 0 ){
                
                startPosition = rightToLeftStartX + duck.positionOffset;
                endPosition   = leftToRightStartX - duck.positionOffset;
                imageFlip     = -duck.xScale;
                
                if ( duck.position.x >= self.parentScene.size.width && duck.isFalling )
                    [ self removeDuck: duck ];
            }
            
            duck.flightDirection = imageFlip;
            duck.didPlayAnySound = NO;
            SKAction *flightPathAnimation = [SKAction sequence:@[
                                                                 [SKAction waitForDuration: duck.animWaitTime],
                                                                 [SKAction moveToX: endPosition   duration: duck.animDuration],
                                                                 ]];
            
            [ duck setXScale: imageFlip ];
            [ duck runAction: flightPathAnimation
                  completion:^{
                      duck.isMoving = NO;

                      NSLog(@"********** DUCK X POS: %.2f", duck.position.x );
                      if ( duck.isInTheWater || duck.rescued || duck.isFalling ){
                          [ self removeDuck: duck ];
                      }
                  }];
            
            duck.isMoving = YES;
        }
    }
}
//----------------------------------------------------------
@end
