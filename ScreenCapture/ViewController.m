//
//  ViewController.m
//  ScreenCapture
//
//  Created by bigstar on 1/14/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)onStart:(id)sender {
    
    CGSize screenSize = [[UIScreen mainScreen] applicationFrame].size;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(nil, screenSize.width, screenSize.height, 8, 4*(int)screenSize.width, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(ctx, 0.0, screenSize.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);

    [(CALayer*)self.view.layer renderInContext:ctx];

    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    self.imageView.image = image;
    CGImageRelease(cgImage);
    CGContextRelease(ctx);
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:@"screen.jpg" atomically:NO];
    
}
@end
