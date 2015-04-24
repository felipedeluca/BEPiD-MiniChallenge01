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
#import "TelaJogo.h"
#import "TelaFinal.h"
#import "ObjectsController.h"
#import "RWDuck.h"
#import "DuckController.h"

@class TelaJogo;

int gameOVer;
CGFloat livesFactor;
int cont;

@interface WaterController : NSObject

-(void)criaAgua:(TelaJogo *)scene;
-(void)infiniteScrollingWater:(TelaJogo *)scene;
-(void)waterSimulation:(TelaJogo *)scene;
@end
