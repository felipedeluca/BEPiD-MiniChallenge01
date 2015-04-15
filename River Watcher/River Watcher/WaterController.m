//
//  WaterController.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "WaterController.h"

// Configuração da água
#define VISCOSITY 6.0 //Increase to make the water "thicker/stickier," creating more friction.
#define BUOYANCY 0.4 //Slightly increase to make the object "float up faster," more buoyant.
#define OFFSET 70.0 //Increase to make the object float to the surface higher.

@interface WaterController()

@property ( nonatomic, strong ) SKSpriteNode *waterPhys; // simulação de física da água
@property ( nonatomic, strong ) RWWater1 *waterTile1A; // p/ scrolling infinito da água
@property ( nonatomic, strong ) RWWater1 *waterTile1B; // p/ scrolling infinito da água
@property ( nonatomic, strong ) WLWater2 *waterTile2A; // p/ scrolling infinito da água
@property ( nonatomic, strong ) WLWater2 *waterTile2B; // p/ scrolling infinito da água

@end

@implementation WaterController
//----------------------------------------------------------------------------------------------
-(void)criaAgua:(SKScene *)scene {
    
    CGFloat offset = - 20.0;
    
    self.waterTile2A = [ [WLWater2 alloc] init ];
    self.waterTile2B = [ [WLWater2 alloc] init ];
    self.waterTile2A.img.position = CGPointMake( 0, - (scene.size.height / 2.0) + 50 + offset );
    self.waterTile2B.img.position = CGPointMake( self.waterTile2A.img.position.x + self.waterTile2B.img.size.width, self.waterTile2A.img.position.y );
    
    //    self.waterTile2A.img.zPosition = 1.0;
    //    self.waterTile2B.img.zPosition = 1.5;
    
    [ scene addChild: self.waterTile2A.img ];
    [ scene addChild: self.waterTile2B.img ];
    
    self.waterTile1A = [ [RWWater1 alloc] init ];
    self.waterTile1B = [ [RWWater1 alloc] init ];
    self.waterTile1A.img.position = CGPointMake( 0, - (scene.size.height / 2.0) + 53 + offset );
    self.waterTile1B.img.position = CGPointMake( self.waterTile1A.img.position.x + self.waterTile1B.img.size.width, self.waterTile1A.img.position.y );
    
    //    self.waterTile1A.img.zPosition = 2.0;
    //    self.waterTile1B.img.zPosition = 2.5;
    
    [ scene addChild: self.waterTile1A.img ];
    [ scene addChild: self.waterTile1B.img ];
    
    self.waterPhys = [ [SKSpriteNode alloc] init ];
    self.waterPhys = [ [SKSpriteNode alloc] initWithColor:[UIColor cyanColor] size:CGSizeMake(scene.size.width, 200) ];
    self.waterPhys.zPosition = 1.0;
    
    self.waterPhys.position = CGPointMake( (scene.size.width / 2.0), + 20 + offset);
    self.waterPhys.alpha = 1.0;
    
    [ scene addChild: self.waterPhys ];
    
}
//--------------------------------------------------------------
-(void)infiniteScrollingWater:(SKScene *)scene{
    // scrolling infinito para a água
    
    CGFloat x1, x2, x3, x4;
    
    CGFloat sceneWidth = scene.size.width + self.waterTile2A.img.size.width;
    
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
-(void)waterSimulation:(SKScene *)scene{

    //Créditos para o código abaixo: Epic Byte
    // fonte: http://stackoverflow.com/questions/25344808/simulate-water-make-sprite-float-on-water-in-spritekit
    // Executa a simulação de água
    for ( RWBasicObject *n in [ scene children ] ){
        if ( CGRectContainsPoint(self.waterPhys.frame, CGPointMake(n.position.x, n.position.y - n.size.height/2.0)) ) {
            if ( [n isKindOfClass: [RWBasicObject class] ] ){
                if ( !n.inWater ){
                    NSLog(@"OBJ POS:%@", [n class] );
                    n.inWater = YES;
                }
                
            }
            
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
