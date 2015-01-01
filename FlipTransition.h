//
//  FlipTransition.h
//  MMPaperPanFlip
//
//  Created by mukesh mandora on 18/12/14.
//  Copyright (c) 2014 madaboutapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "NextViewController.h"
#import "CEVerticalSwipeInteractionController.h"
@interface FlipTransition : CEVerticalSwipeInteractionController<UIViewControllerAnimatedTransitioning>
{
    BOOL isPresenting;
   
}

@end
