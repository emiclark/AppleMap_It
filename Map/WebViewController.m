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
    
    //init WKWebView
    self.myWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    NSURL *url  = self.myWebURL;
    
    //create url request
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    //send url request
    [self.myWebView loadRequest:urlRequest];
    
    //assign view to WKWebView
    self.myWebView.frame = self.view.frame;
    
    //add webview to view
    [self.view addSubview:self.myWebView];
    
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



