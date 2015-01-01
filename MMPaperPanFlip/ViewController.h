//
//  ViewController.h
//  MMPaperPanFlip
//
//  Created by mukesh mandora on 18/12/14.
//  Copyright (c) 2014 madaboutapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipView.h"
@interface ViewController : UIViewController<UIViewControllerTransitioningDelegate>
{
    BOOL isPresenting;
    
}
@property (weak, nonatomic) IBOutlet UIView *flipView;
@property (weak, nonatomic) IBOutlet UIView *flipView2;
@property(strong,nonatomic) FlipView *arcflip;

@end

