//
//  Animal.m
//  Tabitha
//
//  Created by John DiGiorgio on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Animal.h"

@implementation Animal
@synthesize nameit, nameit2,description, imageURL, movieURL, written, category;
@synthesize serial,tileLocX, tileLocY, chronOrder, used, fileName;

-(id)nameit:(NSString *)n {
	self.nameit = n;
//	self.description = d;
//	self.imageURL = u;
//	self.movieURL = m;
//	self.written = w;
//	self.category = c;
	return self;
}
-(id)nameit2:(NSString *)n serial:(NSString *)s description:(NSString *)d tileLocX:(NSInteger *)x tileLocY:(NSInteger *)y chronOrder:(NSString *)g used:(NSString *)u fileName:(NSString *)f{
	
	
	self.nameit2 = n;
	self.serial = s;
	self.description = d;
	self.tileLocX = x;
	self.tileLocY = y;
	self.chronOrder = g;
	self.used = u;
	self.fileName = f;
	return self;
}
@end
