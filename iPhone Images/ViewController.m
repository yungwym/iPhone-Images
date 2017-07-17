//
//  ViewController.m
//  iPhone Images
//
//  Created by Alex Wymer  on 2017-07-17.
//  Copyright © 2017 Sav Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"http://imgur.com/zdwdenZ.png"]; // 1 Create a new URL object from the iphone image url string
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; //2 AN NSURLSessionConfiguration object defines the behavior and policies to use when making a request with an NSURLSession object.
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3 Create an NSURLSession object using our seesion configuration. Any changes we want to make to our configuration object mst be done before this
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (error) { // 1.1 Error handling
            NSLog(@"error : %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *phoneImage = [UIImage imageWithData:data]; //1.2 Must convert the file binary into an NSData object, then create a UIImage from that data
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            
            self.iPhoneImageView.image = phoneImage; // 1.3 Assign the iphoneImageView to display the image and make sure its ran on the main thread as networking happens on the background thread
        }];
        
    }]; // 4 Create a task the will actually download the image from the server. The session creates and configures the task
    
    [downloadTask resume]; // 5 A task is created in a suspended state so you need to resume it. Can also suspend, resume and cancel tasks whenever we want
    
    
}




@end
