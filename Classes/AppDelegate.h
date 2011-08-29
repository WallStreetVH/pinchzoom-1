//
//  AppDelegate.h
//  pinchzoom
//
//  Created by Casey Broich on 7/12/10.
//  Copyright Pagex 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	UINavigationController *navigationController;
	
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


@end
