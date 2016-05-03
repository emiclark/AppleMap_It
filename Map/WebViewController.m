//
//  WebViewInterfaceController.m
//  Map
//
//  Created by Aditya Narayan on 4/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"

@interface UIViewController ()
@property (retain, nonatomic) WKWebView *myWebView;

@end

@implementation WebViewController



#pragma mark View Methods
-(void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize webkit viewcontroller
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds] configuration:theConfiguration];
    self.webView.navigationDelegate = self;
    NSURL *nsurl = [NSURL URLWithString:self.displayURL];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:nsrequest];
    [self.view addSubview:self.webView];
}

#pragma mark Misc Methods
-(void)didReceiveMemoryWarning {
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

-(void)dealloc {
}
@end



