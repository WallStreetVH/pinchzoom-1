//
//  Config.m
//  pinchzoom
//
//  Created by Casey Broich on 5/10/10.
//  Copyright 2010 Pagex. All rights reserved.
//

#import "Config.h"

@implementation Config

@synthesize maxTiles;
@synthesize mapTileWidth;
@synthesize mapTileHeight;

@synthesize maxGids;
@synthesize tilesetWidth;
@synthesize tilesetHeight;

@synthesize screenWidth, screenHeight, maxWidth, maxHeight;

@synthesize tweenSpeed;

static Config *instance = nil;

+ (Config *) getInstance
{
    if ( instance == nil) 
	{
        instance = [ [ super allocWithZone: NULL ] init ];
		[ instance retain ];
    }
    return instance;
}

+ (id) allocWithZone: (NSZone *) zone
{
    return [ [ self instance ] retain ];	
}

- (id) copyWithZone: (NSZone *) zone
{
    return self;	
}

- (id) retain
{
	
	maxTiles = 20;
	mapTileWidth = 100;
	mapTileHeight = 100;
	
	maxGids = 74;
	tilesetWidth = 100;
	tilesetHeight = 100;
	
	screenWidth = 480;
	screenHeight = 320;
	maxWidth = 720;
	maxHeight = 480;

	tweenSpeed = 10;
	
    return self;	
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (void)release
{
    //do nothing	
}

- (id)autorelease
{
    return self;	
}

@end