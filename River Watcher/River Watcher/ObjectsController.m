//
//  ObjetosController.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "ObjectsController.h"
#import "Random.h"

@interface ObjectsController()

@property ( nonatomic ) Random *rGenerator;

@end

@implementation ObjectsController
//----------------------------------------------------------
+(instancetype) InitObjController {
    static ObjectsController *objController;
    
    if ( !objController ){
        objController = [ [self alloc] initPrivate ];
    }
    
    return objController;
}
//----------------------------------------------------------
-(instancetype)init {
    return nil;
}
//----------------------------------------------------------
-(instancetype)initPrivate {
    
    self = [ super init ];
    self.rGenerator = [ [Random alloc] init ];
    self.maxObjectsFlying = 3;
    self.numObjectsFlying = 0;
    
    return self;
}
//----------------------------------------------------------
-(void)destroyObjectsOffScreen:(SKScene *)scene {
    
    for ( RWBasicObject *obj in [scene children] ){
        if ( (obj.position.x < 0 || obj.position.x > scene.size.width) && (obj.position.y < (scene.size.height - (scene.size.height / 2.00)))){
            if ( [obj isKindOfClass: [RWLixo class]] ){
                NSLog(@"### Removing object: %@", obj.name);
                [ obj removeFromParent ];
            }
        }
    }
}
//----------------------------------------------------------
-(void)throwObject:(SKScene *)scene object:(RWBasicObject *)obj parent:(RWAutomobile *)parentNode impulse:(CGFloat)throwImpulse {
  //  NSLog( @" Throwing: %@", obj );
    [ obj setPosition: CGPointMake( parentNode.position.x, parentNode.position.y + 50 ) ];
    obj.physicsBody.velocity = parentNode.physicsBody.velocity;
    
    CGFloat objThrowDirectionX = -1.00;

    if ( obj.position.x <= (scene.size.width / 2.00) )
        objThrowDirectionX = 1;

    CGFloat massDivider = [ self.rGenerator floatRand: 0.8 high: 2.0 ];
    
    obj.physicsBody.mass = [ self.rGenerator floatRand: 0.2 high: 4.0 ];
    CGFloat dx = throwImpulse * 500 * objThrowDirectionX * ( obj.physicsBody.mass / 1.00 );
    CGFloat dy = (throwImpulse * 1000 * ( obj.physicsBody.mass / massDivider )) - (obj.physicsBody.mass * 10);
    
    obj.physicsBody.angularDamping = 4.00 / obj.physicsBody.mass; // Menor a massa, mais o objeto gira no ar
    
//    NSLog(@"OBJ: %@   Body Mass: %f   Força: %f", obj.name, obj.physicsBody.mass, dy );
    [ obj.physicsBody applyAngularImpulse: ((dx + (obj.physicsBody.mass * 10.0) ) / 100000000) * (-1) ];
    [ obj.physicsBody applyForce: CGVectorMake( dx, dy) ];

    SKAction *scaleObject = [ SKAction scaleTo: 0.3 duration: dy / 100000 ];
    [ obj runAction: scaleObject ];

}
//--------------------------------------------------------------
-(void)animateHeart:(SKScene *)scene object:(RWBasicObject *)obj {
    
    RWHeart *newHeart = [ [RWHeart alloc] init ];
    [ newHeart setPosition: CGPointMake( obj.position.x , obj.position.y + 10.0) ];
    [ scene addChild: newHeart ];
    [ newHeart animateHeart ];
    
}
//--------------------------------------------------------------
-(void)animatePoow:(SKScene *)scene object:(RWBasicObject *)obj {
    
    RWPoow *newPoow = [ [RWPoow alloc] init ];
    [ newPoow setPosition: obj.position ];
    [ scene addChild: newPoow ];
    [ newPoow animatePoow ];
    
}
//--------------------------------------------------------------
-(void)animateScore:(SKScene *)scene object:(RWBasicObject *)obj score:(int)s {

    NSLog(@"ANIMATED SCORE: %d", s);
    
    SKLabelNode *labelScore;
    labelScore = [[SKLabelNode alloc] initWithFontNamed:@"Floraless"];
    
    if ( s <= 0 ){
        labelScore.fontColor = [ SKColor brownColor ];
        labelScore.text = [NSString stringWithFormat:@"%d", s];
    }
    else{
        labelScore.fontColor = [ SKColor orangeColor ];
        labelScore.text = [NSString stringWithFormat:@"+%d", s];
    }
    
    [labelScore setFontSize: 35];
    labelScore.position = obj.position;
    labelScore.zPosition = 30;

    SKAction *labelAction = [ SKAction sequence: @[
                                                   [SKAction scaleBy: 1.2 duration: 2.0],
                                                   ]];
    
    SKAction *verticalAction = [ SKAction moveBy: CGVectorMake(0.0, 200.0) duration: 2.0 ];
    
    SKAction *delayBeforeAction = [ SKAction waitForDuration: 0.0 ];
    SKAction *fadeOut = [ SKAction sequence: @[
                                               [SKAction waitForDuration: 1.0 ],
                                               [SKAction fadeAlphaTo: 0.0 duration: 2.0]
                                               ]];
    
    [ scene addChild: labelScore ];
    
    [ labelScore runAction: delayBeforeAction
          completion:^{
              [ labelScore runAction: fadeOut ];
              [ labelScore runAction: verticalAction ];
              [ labelScore runAction: labelAction
                    completion:^{
                        [ labelScore removeAllActions ];
                        [ labelScore removeFromParent ];
                    }];
          }];
    
    
}
//--------------------------------------------------------------
@end
