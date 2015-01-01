//
//  NextViewController.m
//  MMPaperPanFlip
//
//  Created by mukesh mandora on 18/12/14.
//  Copyright (c) 2014 madaboutapps. All rights reserved.
//

#import "NextViewController.h"
#import "ViewController.h"
@interface NextViewController (){
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    activityIndicator.alpha = 1.0;
//    activityIndicator.color=[UIColor grayColor];
//    activityIndicator.center = CGPointMake(160, 240);
//    activityIndicator.hidesWhenStopped = YES;
//    [self.view addSubview:activityIndicator];
//    [activityIndicator startAnimating];
//    // Do any additional setup after loading the view.
//    self.webView.delegate = self;
//    self.webView.scalesPageToFit = YES;
//    NSURL* url = [NSURL URLWithString:@"http://marvel.com/movies/movie/193/avengers_age_of_ultron"];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];

//    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"next.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [activityIndicator stopAnimating];
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
