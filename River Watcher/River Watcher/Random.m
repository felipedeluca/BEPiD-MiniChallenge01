//
//  Random.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/15/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "Random.h"

@implementation Random

//------------------------------------------------------------------
-(CGFloat) floatRand:(CGFloat)low high:(CGFloat)high{
    return ( (rand() / ( CGFloat ) RAND_MAX) * ( high - low ) ) + low;
}
//------------------------------------------------------------------
-(int) intRand:(int)low high:(int)high{
    return ( (rand() / ( int ) RAND_MAX) * ( high - low ) ) + low;
}
//------------------------------------------------------------------
@end
