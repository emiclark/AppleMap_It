//
//  WebViewInterfaceController.h
//  Map
//
//  Created by Aditya Narayan on 4/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <Foundation/Foundation.h>

@interface WebViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>
@property (retain, nonatomic) NSURL *myWebURL;

@end
