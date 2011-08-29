//
//  AppDelegate.m
//  pinchzoom
//
//  Created by Casey Broich on 7/12/10.
//  Copyright Pagex 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "cocos2d.h"
#import "WorldMap.h"
#import "TutorialScene.h"

@implementation AppDelegate

@synthesize window, navigationController;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	CC_DIRECTOR_INIT();
	
	CCDirector *director = [CCDirector sharedDirector];
	
//	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
	
	[director setDisplayFPS:YES];
	
	EAGLView *view = [director openGLView];
	
	[view setMultipleTouchEnabled:YES];
	
	[CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];
	
	[[CCDirector sharedDirector] runWithScene: [Tutorial scene]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[CCDirector sharedDirector] end];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
