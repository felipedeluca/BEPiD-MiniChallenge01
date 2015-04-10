//
//  ShipScene.m
//  touch n drag
//
//  Created by Kalim on 07/04/15.
//  Copyright (c) 2015 Kalim. All rights reserved.
//

#import "ShipScene.h"
#import "Pneu.h"
#import "Bottle.h"

@interface ShipScene()

@property BOOL contentCreated;

@end


@implementation ShipScene 


-(void)didMoveToView:(SKView * )view {
    
    if ( !self.contentCreated ){
        
        [ self createSceneContents ];
        self.contentCreated = YES;
    }
}

-(void)viewWillLayoutSubviews
{
   // [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    UIView *pauseMenu = [[UIView alloc] initWithFrame:pneu.frame]; // This should be the pause menu with the pause button
    
    [skView addSubview:pauseMenu];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    
    pneu.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"Pneu" ] size: pneu.size ];
    pneu.physicsBody.dynamic = NO;
    
    bottle.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"Pneu" ] size: bottle.size ];
    bottle.physicsBody.dynamic = NO;

    UITouch *touch = [ touches anyObject ];
    CGPoint location = [ touch locationInNode: self];
    node = [ self nodeAtPoint: location ];
    
    if ( [node.name isEqualToString: @"Pneu" ] ){
         NSLog( @"pegou pneu!" );
       
        
        
        
        [node runAction:[SKAction playSoundFileNamed:@"grabObject.wav" waitForCompletion:YES]];
    }
    
    if ( [node.name isEqualToString: @"Bottle" ] ){
        NSLog( @"pegou garrafa!" );
        self.scene.view.paused = NO;
        
        [node runAction:[SKAction playSoundFileNamed:@"grabObject.wav" waitForCompletion:YES]];
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    pneu.physicsBody = [ SKPhysicsBody bodyWithTexture: [ SKTexture textureWithImageNamed: @"Pneu" ] size: pneu.size ];
    pneu.physicsBody.dynamic = NO;
    UITouch *touch = [ touches anyObject ];
    CGPoint location = [ touch locationInNode: self];
    node = [ self nodeAtPoint: location ];
    
    if ( [node.name isEqualToString: @"Pneu" ] ){
        
        pneu.position = location;
    }
    
     if ( [node.name isEqualToString: @"Bottle" ] ){
        
        bottle.position = location;
    }


}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if((CGRectContainsPoint(pneu.frame, bottle.position))){
        
        [bottle removeFromParent];
        
        [self runAction: [SKAction playSoundFileNamed:@"destroy1.wav" waitForCompletion:YES]];
        
        bottle = nil;
    }
    
    NSLog( @"soltou objeto");
    
}


-(void)createSceneContents {
    
    [self runAction: [SKAction repeatActionForever:[SKAction playSoundFileNamed:@"inGame.wav" waitForCompletion:YES]]];
    
    pneu = [ [Pneu alloc] init ];
//    if (pneu != nil){
//        [ pneu runAction:[SKAction repeatActionForever:[SKAction playSoundFileNamed:@"inGame.wav" waitForCompletion:YES]]];
//      
//
//    }
    bottle = [ [Bottle alloc] init];
    
    pneu.position = CGPointMake( CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150 );
    bottle.position = CGPointMake( CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 150 );
    
    [ self addChild: pneu ];
    [ self addChild:bottle];
    
   
        
    
    
    
    
    self.backgroundColor = [ SKColor blackColor ];
    self.scaleMode       = SKSceneScaleModeAspectFit;
}

@end