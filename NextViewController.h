//
//  NextViewController.h
//  MMPaperPanFlip
//
//  Created by mukesh mandora on 18/12/14.
//  Copyright (c) 2014 madaboutapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextViewController : UIViewController<UIWebViewDelegate>
- (IBAction)dismiss:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
