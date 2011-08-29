//
//  Animal.h
//  Tabitha
//
//  Created by John DiGiorgio on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Animal : NSObject {
	NSString *nameit;
	NSString *nameit2;
	//NSString *english;
	NSString *description;
	NSString *imageURL;
	NSString *movieURL;
	NSString *written;
	NSString *category;
	NSString *serial;
	NSString * tileLocX;
	NSString *tileLocY;
	NSString *chronOrder;
	NSString *used;
	NSString *fileName;
}

@property (nonatomic, retain) NSString *nameit;
@property (nonatomic, retain) NSString *nameit2;
//@property (nonatomic, retain) NSString *english;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *movieURL;
@property (nonatomic, retain) NSString *written;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *serial;
@property (nonatomic, retain) NSString *tileLocX;
@property (nonatomic, retain) NSString *tileLocY;
@property (nonatomic, retain) NSString *chronOrder;
@property (nonatomic, retain) NSString *used;
@property (nonatomic, retain) NSString *fileName;


//-(id)initWithName:(NSString *)n description:(NSString *)d url:(NSString *)u url:(NSString *)m written:(NSString *)w category:(NSString *)c;
-(id)nameit:(NSString *)n;
-(id)nameit2:(NSString *)n description:(NSString *)d tileLocX:(NSInteger *)x tileLocY:(NSInteger *)y used:(NSInteger *)u fileName:(NSString *)f;
-(id)initWithName:(NSString *)n;

@end
