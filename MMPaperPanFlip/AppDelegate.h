//
//  AppDelegate.h
//  MMPaperPanFlip
//
//  Created by mukesh mandora on 18/12/14.
//  Copyright (c) 2014 madaboutapps. All rights reserved.
//
#define AppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#import <UIKit/UIKit.h>
@class  CEBaseInteractionController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
  
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CEBaseInteractionController *settingsInteractionController;
@property (assign,nonatomic)  BOOL isPresenting;
@end

