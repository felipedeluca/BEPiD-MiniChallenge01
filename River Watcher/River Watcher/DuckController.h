//
//  DuckController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/23/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
//#import "RWBasicObject.h"
#import "RWDuck.h"

@interface DuckController : NSObject

@property ( nonatomic ) SKScene * parentScene;

-(void)animateDuck;
-(void)newDuck;
-(void)animateFall:(RWDuck *)duck;
-(void)rescueTheDuck:(RWDuck *)duck;
-(void)duckOnWater:(RWDuck *)duck;

@end
