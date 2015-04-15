//
//  WaterController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/10/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWWater1.h"
#import "WLWater2.h"
#import "RWBasicObject.h"
#import "RWGlassBottle.h"

@interface WaterController : NSObject

-(void)criaAgua:(SKScene *)scene;
-(void)infiniteScrollingWater:(SKScene *)scene;
-(void)waterSimulation:(SKScene *)scene;

@end