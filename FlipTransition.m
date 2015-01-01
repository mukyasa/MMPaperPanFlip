//
//  FlipTransition.m
//  MMPaperPanFlip
//
//  Created by mukesh mandora on 18/12/14.
//  Copyright (c) 2014 madaboutapps. All rights reserved.
//

#import "FlipTransition.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "NextViewController.h"
@implementation FlipTransition


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.8f;
}

- (void)animationEnded:(BOOL) transitionCompleted{
    
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    // Add the toView to the container
    
   
    if (AppDelegateAccessor.isPresenting) {
      
        [self dismiss:transitionContext];
    }
    else{
        [self present:transitionContext];
    
    }
   
    
}

-(void)present:(id <UIViewControllerContextTransitioning>)transitionContext{
    ViewController *fromVC =(ViewController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NextViewController *toVC = (NextViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.arcflip;
    
    
    //    if(AppDelegateAccessor.isPresenting){
    //
    //    }
    //    else{
    //                NSLog(@"dismiss allocated");
    //        if (AppDelegateAccessor.settingsInteractionController) {
    //            [AppDelegateAccessor.settingsInteractionController wireToViewController:toVC forOperation:CEInteractionOperationDismiss];
    //        }
    //    }
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    // Add a perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    [containerView.layer setSublayerTransform:transform];
    
    // Give both VCs the same start frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame =  CGRectMake(fromVC.view.center.x-130, fromVC.view.center.y, 260, 260);
    toView.frame =  initialFrame;
    
    
    
    // create two-part snapshots of both the from- and to- views
    NSArray* toViewSnapshots = [self createSnapshots:toView afterScreenUpdates:YES];
    UIView* flippedSectionOfToView = toViewSnapshots[AppDelegateAccessor.isPresenting ? 0 : 1];
    
    // customise
    CGRect snapshotRegion = CGRectMake(fromVC.view.center.x-130, fromVC.view.center.y, 260, 260);
    UIView *leftHandView = [fromVC.view resizableSnapshotViewFromRect:snapshotRegion   afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame = snapshotRegion;
    [containerView addSubview:leftHandView];
    
    
    //    NSArray* fromViewSnapshots = [self createSnapshots:fromView afterScreenUpdates:NO];
    NSArray* fromViewSnapshots = @[leftHandView];
    
    UIView* flippedSectionOfFromView = fromViewSnapshots[AppDelegateAccessor.isPresenting ? 1 : 0];
    
    //    // replace the from- and to- views with container views that include gradients
    //    flippedSectionOfFromView = [self addShadowToView:flippedSectionOfFromView reverse:!AppDelegateAccessor.isPresenting];
    //    UIView* flippedSectionOfFromViewShadow = flippedSectionOfFromView.subviews[1];
    //    flippedSectionOfFromViewShadow.alpha = 0.0;
    //
    //    flippedSectionOfToView = [self addShadowToView:flippedSectionOfToView reverse:AppDelegateAccessor.isPresenting];
    //    UIView* flippedSectionOfToViewShadow = flippedSectionOfToView.subviews[1];
    //    flippedSectionOfToViewShadow.alpha = 1.0;
    
    
    NSLog(@"BOOL %d",isPresenting);
    // change the anchor point so that the view rotate around the correct edge
    [self updateAnchorPointAndOffset:CGPointMake(0.5,AppDelegateAccessor.isPresenting ? 1.0 : 0.0) view:flippedSectionOfFromView];
    [self updateAnchorPointAndOffset:CGPointMake(0.5,AppDelegateAccessor.isPresenting ? 0.0 : 1.0) view:flippedSectionOfToView];
    
    // rotate the to- view by 90 degrees, hiding it
    flippedSectionOfToView.layer.transform = [self rotate:AppDelegateAccessor.isPresenting ? M_PI_2 : -M_PI_2];
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    
                                                                    
                                                                    // rotate the from- view to 90 degrees
                                                                    flippedSectionOfFromView.layer.transform = [self rotate:AppDelegateAccessor.isPresenting? -M_PI_2 : M_PI_2];
                                                                    //                                                                    flippedSectionOfFromViewShadow.alpha = 1.0;
                                                                    
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.5
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    // rotate the to- view to 0 degrees
                                                                    
                                                                    
                                                                    
                                                                    flippedSectionOfToView.layer.transform = [self rotate:AppDelegateAccessor.isPresenting ? 0.001 : -0.001];
                                                                    //                                                                    flippedSectionOfToViewShadow.alpha = 0.0;
                                                                    flippedSectionOfToView.frame=CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height/2);
                                                                    
                                                                    
                                                                    
                                                                    ((UIView *)toViewSnapshots[0]).frame=CGRectMake(0, toVC.view.frame.size.height/2, toVC.view.frame.size.width, toVC.view.frame.size.height/2);
                                                                    ((UIView *)toViewSnapshots[1]).frame=CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height/2);
                                                                    
                                                                    
                                                                }];
                                  
                                  
                                  
                              } completion:^(BOOL finished) {
                                  
                                  // remove all the temporary views
                                  if ([transitionContext transitionWasCancelled]) {
                                      [self removeOtherViews:fromView];
                                      
                                      
                                  } else {
                                      
                                      [self removeOtherViews:toView];
                                      if (AppDelegateAccessor.settingsInteractionController) {
                                          [AppDelegateAccessor.settingsInteractionController wireToViewController:toVC forOperation:CEInteractionOperationDismiss];
                                      }
                                  }
                                 

                                  // inform the context of completion
                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                  
                              }];
    
    
    

}

-(void)dismiss:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.arcflip;
    UIView *fromView = fromVC.view;
    
    
    //    if(AppDelegateAccessor.isPresenting){
    //
    //    }
    //    else{
    //                NSLog(@"dismiss allocated");
    //        if (AppDelegateAccessor.settingsInteractionController) {
    //            [AppDelegateAccessor.settingsInteractionController wireToViewController:toVC forOperation:CEInteractionOperationDismiss];
    //        }
    //    }
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    // Add a perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    [containerView.layer setSublayerTransform:transform];
    
    // Give both VCs the same start frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame =  CGRectMake(toVC.view.center.x-130, toVC.view.center.y, 260, 260);
    fromView.frame =  initialFrame;
    
    
        // customise
        CGRect snapshotRegion = CGRectMake(toVC.view.center.x-130, toVC.view.center.y, 260, 260);
        UIView *leftHandView = [toVC.view resizableSnapshotViewFromRect:snapshotRegion   afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        leftHandView.frame = snapshotRegion;
        [containerView addSubview:leftHandView];

    // create two-part snapshots of both the from- and to- views
    NSArray* toViewSnapshots = @[leftHandView];
    UIView* flippedSectionOfToView = toViewSnapshots[0];
    //    NSArray* fromViewSnapshots = @[leftHandView];
    
    
    NSArray* fromViewSnapshots = [self createSnapshots:fromView afterScreenUpdates:NO];

    
    UIView* flippedSectionOfFromView = fromViewSnapshots[AppDelegateAccessor.isPresenting ? 1 : 0];
    
    //    // replace the from- and to- views with container views that include gradients
    //    flippedSectionOfFromView = [self addShadowToView:flippedSectionOfFromView reverse:!AppDelegateAccessor.isPresenting];
    //    UIView* flippedSectionOfFromViewShadow = flippedSectionOfFromView.subviews[1];
    //    flippedSectionOfFromViewShadow.alpha = 0.0;
    //
    //    flippedSectionOfToView = [self addShadowToView:flippedSectionOfToView reverse:AppDelegateAccessor.isPresenting];
    //    UIView* flippedSectionOfToViewShadow = flippedSectionOfToView.subviews[1];
    //    flippedSectionOfToViewShadow.alpha = 1.0;
    
    
    NSLog(@"BOOL %d",isPresenting);
    // change the anchor point so that the view rotate around the correct edge
    [self updateAnchorPointAndOffset:CGPointMake(0.5,AppDelegateAccessor.isPresenting ? 1.0 : 0.0) view:flippedSectionOfFromView];
    [self updateAnchorPointAndOffset:CGPointMake(0.5,AppDelegateAccessor.isPresenting ? 0.0 : 1.0) view:flippedSectionOfToView];
    
    // rotate the to- view by 90 degrees, hiding it
    flippedSectionOfToView.layer.transform = [self rotate:AppDelegateAccessor.isPresenting ? M_PI_2 : -M_PI_2];
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    // rotate the from- view to 90 degrees
                                                                    flippedSectionOfFromView.layer.transform = [self rotate:AppDelegateAccessor.isPresenting? -M_PI_2 : M_PI_2];
                                                                    //                                                                    flippedSectionOfFromViewShadow.alpha = 1.0;
                                                                    flippedSectionOfToView.frame=CGRectMake(toVC.view.center.x-130, toVC.view.center.y, 260, 260);
                                                                    
                                                                    ((UIView *)fromViewSnapshots[0]).frame=CGRectMake(fromVC.view.center.x-130, fromVC.view.center.y, 260, 260);
                                                                    
                                                                    ((UIView *)fromViewSnapshots[1]).frame=CGRectMake(fromVC.view.center.x-130, 0, 260, fromVC.view.frame.size.height/2);
                                                                    
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.5
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    // rotate the to- view to 0 degrees
                                                                    
                                                                    
                                                                    
                                                                    flippedSectionOfToView.layer.transform = [self rotate:AppDelegateAccessor.isPresenting ? 0.001 : -0.001];
                                                                    //                                                                    flippedSectionOfToViewShadow.alpha = 0.0;
                                             
                                                                }];
                                  
                                  
                                  
                              } completion:^(BOOL finished) {
                                  //                                  if(AppDelegateAccessor.isPresenting){
                                  //                                      NSLog(@"Present allocated");
                                  //                                      if (AppDelegateAccessor.settingsInteractionController) {
                                  //                                          [AppDelegateAccessor.settingsInteractionController wireToViewController:toVC forOperation:CEInteractionOperationPresent];
                                  //                                      }
                                  //                                  }else{
                                  //
                                  //                                  }
                                  
                                  
                                  // remove all the temporary views
                                  if ([transitionContext transitionWasCancelled]) {
                                      [self removeOtherViews:fromView];
                                      
                                      
                                  } else {
                                      
                                      [self removeOtherViews:toView];
                                      if (AppDelegateAccessor.settingsInteractionController) {
                                          //        [AppDelegateAccessor.settingsInteractionController wireToViewController:self forOperation:CEInteractionOperationPresent];
                                          [AppDelegateAccessor.settingsInteractionController wireToViewController:toVC withView:toVC.arcflip forOperation:CEInteractionOperationPresent];
                                          
                                      }
                                  }
                                  
                                  // inform the context of completion
                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                  
                              }];
    
    
    
    
}

// adds a gradient to an image by creating a containing UIView with both the given view
// and the gradient as subviews
- (UIView*)addShadowToView:(UIView*)view reverse:(BOOL)reverse {
    
    UIView* containerView = view.superview;
    
    // create a view with the same frame
    UIView* viewWithShadow = [[UIView alloc] initWithFrame:view.frame];
    
    // replace the view that we are adding a shadow to
    [containerView insertSubview:viewWithShadow aboveSubview:view];
    [view removeFromSuperview];
    
    // create a shadow
    UIView* shadowView = [[UIView alloc] initWithFrame:viewWithShadow.bounds];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = shadowView.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor];
    gradient.startPoint = CGPointMake(reverse ? 0.0 : 0.0, 0.0);
    gradient.endPoint = CGPointMake(reverse ? 1.0 : 1.0, 0.0);
    [shadowView.layer insertSublayer:gradient atIndex:1];
    
    // add the original view into our new view
    view.frame = view.bounds;
    [viewWithShadow addSubview:view];
    
    // place the shadow on top
    [viewWithShadow addSubview:shadowView];
    
    return viewWithShadow;
}

- (CATransform3D) rotate:(CGFloat) angle {
    return  CATransform3DMakeRotation(angle, 1.0, 0.0, 0.0);
}

/// creates a pair of snapshots from the given view
- (NSArray*)createSnapshots:(UIView*)view afterScreenUpdates:(BOOL) afterUpdates{
    UIView* containerView = view.superview;
    CGRect snapshotRegion;
    // snapshot the left-hand side of the view
    if(AppDelegateAccessor.isPresenting){
         snapshotRegion = CGRectMake(0,view.center.y,view.frame.size.width , view.frame.size.height/2);
    }
    else{
       snapshotRegion = CGRectMake(view.center.x-130,view.center.y,  260 , 260);
    }
    
    
    //issue in iPhone 6
    UIView *leftHandView = [view resizableSnapshotViewFromRect:CGRectMake(0,view.frame.size.height/2,view.frame.size.width,view.frame.size.height/2)  afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame = snapshotRegion;
    [containerView addSubview:leftHandView];
    
    // snapshot the right-hand side of the view
    if(AppDelegateAccessor.isPresenting){
        snapshotRegion = CGRectMake(0,0,view.frame.size.width , view.frame.size.height/2);
    }
    else{
        snapshotRegion = CGRectMake(view.center.x-130,0,  260 , view.frame.size.height/2);
    }
    
    UIView *rightHandView = [view resizableSnapshotViewFromRect:CGRectMake(0, 0,view.frame.size.width,view.frame.size.height/2)  afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
    rightHandView.frame = snapshotRegion;
    [containerView addSubview:rightHandView];
    
    
    
    // send the view that was snapshotted to the back
    [containerView sendSubviewToBack:view];
    
    return @[leftHandView, rightHandView];
}

// removes all the views other than the given view from the superview
- (void)removeOtherViews:(UIView*)viewToKeep {
    UIView* containerView = viewToKeep.superview;
    for (UIView* view in containerView.subviews) {
        if (view != viewToKeep) {
            [view removeFromSuperview];
        }
    }
}

// updates the anchor point for the given view, offseting the frame to compensate for the resulting movement
- (void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView*)view {
    
     NSLog(@"anchor %f %f",anchorPoint.x,anchorPoint.y);
    view.layer.anchorPoint = anchorPoint;
    float xOffset =  anchorPoint.y - 0.5;
    
    if(!isPresenting){
       
    }
    else{
        
//       xOffset=-1*(xOffset);
    }

    view.frame = CGRectOffset(view.frame, 0, xOffset * view.frame.size.height);
//    NSLog(@"%f",xOffset);
    
  
}



- (CATransform3D) makeRotationAndPerspectiveTransform:(CGFloat) angle {
    CATransform3D transform = CATransform3DMakeRotation(angle, 1.0f, 0.0f, 0.0f);
    transform.m34 = 1.0 / -500;
    return transform;
}

@end
