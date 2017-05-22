//
//  ViewController.m
//  PhoneImages
//
//  Created by Rushan on 2017-05-22.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (nonatomic) NSArray *iPhoneImages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iPhoneImages = @[@"http://i.imgur.com/bktnImE.png",  @"http://imgur.com/y9MIaCS.png",  @"http://imgur.com/zdwdenZ.png", @"http://imgur.com/CoQ8aNl.png", @"http://imgur.com/2vQtZBb.png"];
    //The following line replaced with the content of the button method
    //NSURL *url = [NSURL URLWithString: @"http://imgur.com/y9MIaCS.png"];
}

- (void)downloadImage:(NSURL*)imgURL
{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    //The completion handler takes 3 parameters:
    //location: The location of a file we just downloaded on the device.
    //response: Response metadata such as HTTP headers and status codes.
    //error: An NSError that indicates why the request failed, or nil when the request is successful.
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:imgURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);  //error handler
            return;
        }
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.iPhoneImageView.image = image; //run on the main queue
        }];
        
    }];
    
    [downloadTask resume];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RandomizeIphone:(UIButton *)sender {
    int rand = arc4random_uniform(self.iPhoneImages.count);
    NSString *string = self.iPhoneImages[rand];
    NSLog(@"imgur url = %@", string);
   
    
    [self downloadImage:[self returnURL:string]];
}

-(NSURL *)returnURL:(NSString *)string{
    NSURL *url = [NSURL URLWithString:string];
    return url;
}


@end
