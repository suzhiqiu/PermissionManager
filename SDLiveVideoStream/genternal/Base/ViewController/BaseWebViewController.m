//
//  BaseWebViewController.m
//  SDLiveVideoStream
//
//  Created by suzq on 2017/8/31.
//  Copyright © 2017年 suzq. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.scrollView.clipsToBounds = NO;
    self.webView.delegate = self;
    self.webView.tag = 5000;
    
    self.webView.scalesPageToFit=YES;
    
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
     //  make.edges.mas_equalTo(self.view);
        make.edges.mas_equalTo(self.view.safeAreaInsets);
    }];
    
    self.view.backgroundColor =[UIColor redColor];
    self.webView.backgroundColor = [UIColor blueColor];
    
    //self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    
    [self loadWebViewRequest];
    
    
   // [self performSelector:@selector(loadWebViewRequest) withObject:nil afterDelay:3];
    
}


- (void)loadWebViewRequest {
    
    NSString *urlStr=@"https://credit.szfw.org/CX20170822035555080792.html";
    
    urlStr=@"https://www.qq.com";
    NSURL *requestUrl = [NSURL URLWithString:urlStr];
    if (requestUrl) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:requestUrl]];
    }
    
    
}





- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlStr = request.URL.absoluteString;
    
    NSLog(@"urlStr:%@", urlStr);
    
    
    return YES;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"url--finish");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"url--error");
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

@end
