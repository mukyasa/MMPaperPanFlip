//
//  ViewController.m
//  MMPaperPanFlip
//
//  Created by mukesh mandora on 18/12/14.
//  Copyright (c) 2014 madaboutapps. All rights reserved.
//
#import "ViewController.h"
#import "FlipTransition.h"
#import "NextViewController.h"
#import "AppDelegate.h"
#import "CEVerticalSwipeInteractionController.h"
@interface ViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) FlipTransition *transitionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setup{
    
    //TransitionManager class implements the UIViewControllerAnimatedTransitioning protocol
    //Its instance is responsible to mange transitions in this controller.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(allocNextVC:)
                                                 name:@"alloc"
                                               object:nil];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"2.png"]];
    
    
    _arcflip=[[FlipView alloc] init];
    _arcflip.frame=CGRectMake(self.view.center.x-130, self.view.center.y, 260, 260);
    //    _arc.image=[UIImage imageNamed:@"arc.jpg"];
    //    _arc.contentMode=UIViewContentModeScaleAspectFill;
    //    [self.view addSubview:_arc];
    //    [self.view bringSubviewToFront:_arc];
    [self.view addSubview:_arcflip];
    [self.view bringSubviewToFront:_arcflip];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animatePaperFlip:)];
    tapGesture.delegate=self;
    [_arcflip addGestureRecognizer:tapGesture];
    
    
    self.transitionManager = [[FlipTransition alloc]init];
    AppDelegateAccessor.settingsInteractionController=[[CEVerticalSwipeInteractionController alloc] init];
    if (AppDelegateAccessor.settingsInteractionController) {
        //        [AppDelegateAccessor.settingsInteractionController wireToViewController:self forOperation:CEInteractionOperationPresent];
        [AppDelegateAccessor.settingsInteractionController wireToViewController:self withView:_arcflip forOperation:CEInteractionOperationPresent];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}
-(void)allocNextVC:(NSNotification*)sender{
    NextViewController *modal = [self.storyboard instantiateViewControllerWithIdentifier:@"next"];
    modal.transitioningDelegate = self;
    //    modal.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:modal animated:YES completion:^{
    }];
    
}
-(void)animatePaperFlip:(UITapGestureRecognizer*)sender{
    NextViewController *modal = [self.storyboard instantiateViewControllerWithIdentifier:@"next"];
    modal.transitioningDelegate = self;
    //    modal.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:modal animated:YES completion:^{
    }];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NextViewController *next=segue.destinationViewController;
    next.transitioningDelegate=self;
   
   
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
       AppDelegateAccessor.isPresenting=NO;
    return self.transitionManager;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    AppDelegateAccessor.isPresenting=YES;
    return self.transitionManager;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return AppDelegateAccessor.settingsInteractionController && AppDelegateAccessor.settingsInteractionController.interactionInProgress ? AppDelegateAccessor.settingsInteractionController : nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return AppDelegateAccessor.settingsInteractionController && AppDelegateAccessor.settingsInteractionController.interactionInProgress ? AppDelegateAccessor.settingsInteractionController : nil;
}
@end
