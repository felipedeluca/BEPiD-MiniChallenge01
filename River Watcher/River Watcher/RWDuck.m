//
//  RWDuck.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/23/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWDuck.h"
#import "ObjectsController.h"

@implementation RWDuck
//----------------------------------------------------------
-(instancetype)initWithImageNamed:(NSString *)name{
    
    if ( self = [super init]){
        
        self = [ RWDuck spriteNodeWithImageNamed: @"pato3" ];
        self.objTexture = [ SKTexture textureWithImageNamed: @"pato3" ];
        
        // Animação de voo
        SKTexture *flyingFrame1 = [ SKTexture textureWithImageNamed: @"pato1" ];
        SKTexture *flyingFrame2 = [ SKTexture textureWithImageNamed: @"pato2" ];
        SKTexture *flyingFrame3 = [ SKTexture textureWithImageNamed: @"pato3" ];
        self.flyingAnimation = [ [NSArray alloc] initWithObjects: flyingFrame1, flyingFrame2, flyingFrame3, nil ];
        
        [ self loopAnimateWings ];
        
        // Animação de queda
        SKTexture *fallingFrame1 = [ SKTexture textureWithImageNamed: @"pato5" ];
        SKTexture *fallingFrame2 = [ SKTexture textureWithImageNamed: @"pato6" ];
        SKTexture *fallingFrame3 = [ SKTexture textureWithImageNamed: @"pato7" ];
        self.fallingAnimation = [ [NSArray alloc] initWithObjects: fallingFrame1, fallingFrame2, fallingFrame3, nil ];
        
        // Animação do pato surpreso
        SKTexture *surprisedFrame1 = [ SKTexture textureWithImageNamed: @"pato4" ];
        self.surprisedAnimation = [ [NSArray alloc] initWithObjects: surprisedFrame1, nil ];
        
        // Animação do nadando
        SKTexture *swimmingFrame1 = [ SKTexture textureWithImageNamed: @"pato" ];
        self.swimmingAnimation = [ [NSArray alloc] initWithObjects: swimmingFrame1, nil ];

        [ self setScale: 0.08 ];
        self.zPosition = 22.0;
        self.isMoving  = NO;
        
        [ self setDuckPhysics ];
        
        self.name = name;
        
        self.flightDirection = -1; // Negativo = direita->esquerda / Positivo = esquerda->direita
        self.isInTheWater = NO;
        self.scoreValue = 40; // Perde 40% do total de pontos
        self.isInTheAir = YES;
        self.isFalling  = NO;
        self.rescued    = NO;
        self.alreadyFloating = NO;
        //        NSLog(@"OBJ: %@    MASS: %f", self.name, self.physicsBody.mass);
    }
    
    return self;
}
//----------------------------------------------------------
-(void)setDuckPhysics {

    self.physicsBody = [ SKPhysicsBody bodyWithTexture: self.objTexture size: self.size ];
    self.physicsBody.dynamic           = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.linearDamping     = 1.0;
    self.physicsBody.angularDamping    = 1.0;
    self.physicsBody.restitution       = 0.01;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.contactTestBitMask = garbageContactCategory | waterContactCategory;
    self.physicsBody.collisionBitMask   = garbageContactCategory | waterContactCategory;
    self.physicsBody.categoryBitMask    = duckContactCategory;
    
}
//----------------------------------------------------------
-(void)loopAnimateWings {
    
    SKAction *flyingAction        = [ SKAction animateWithTextures: self.flyingAnimation timePerFrame: 0.1 ];
    SKAction *flyingRepeatForever = [ SKAction repeatActionForever: flyingAction ];
    
    SKAction *verticalAnimation = [SKAction sequence:@[
                                                       [SKAction waitForDuration:0.0],
                                                       [SKAction moveByX: 0.0  y: -90 duration:0.9],
                                                       [SKAction moveByX: 0.0  y: 90 duration:0.9]
                                                       ]
                                   ];
    

    [ self runAction: flyingRepeatForever ];
    [ self runAction: [SKAction repeatActionForever: verticalAnimation] ];
    
}
//----------------------------------------------------------
@end
