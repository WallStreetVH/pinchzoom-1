//
//  Config.h
//  pinchzoom
//
//  Created by Casey Broich on 5/10/10.
//  Copyright 2010 Pagex. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Config : NSObject 
{	
	int maxTiles;
	int mapTileWidth;
	int mapTileHeight;
	
	int maxGids;
	int tilesetWidth;
	int tilesetHeight;
	
	int screenWidth, screenHeight, maxWidth, maxHeight;
	int tweenSpeed;
}

@property (nonatomic, readonly) int maxTiles;
@property (nonatomic, readonly) int mapTileWidth;
@property (nonatomic, readonly) int mapTileHeight;

@property (nonatomic, readonly) int maxGids;
@property (nonatomic, readonly) int tilesetWidth;
@property (nonatomic, readonly) int tilesetHeight;

@property (nonatomic, readonly) int screenWidth, screenHeight, maxWidth, maxHeight;

@property (nonatomic, readonly) int tweenSpeed;

+ (Config *) getInstance;

@end
