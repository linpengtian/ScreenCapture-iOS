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
    
    if (!self.bgTask) {
        self.bgTask = [[BackgroundTask alloc] init];
    }
    
    [self.bgTask startBackgroundTasks:5 target:self selector:@selector(syncData:)];
}


-(void) syncData:(NSTimer*)timer {
    NSLog(@"=======capture start=========");
//    extern UIImage *_UICreateScreenUIImage();
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//
//        UIImage *screenshot = _UICreateScreenUIImage();
//        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil);
//    });
    
   
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
     
    // grab reference to our window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
     
    // transfer content into our context
    [window.layer renderInContext:ctx];
    UIImage *screengrab = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(screengrab, nil, nil, nil);
    UIGraphicsEndImageContext();
    NSLog(@"=======capture end=========");
}

- (IBAction)onStart:(id)sender {
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
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
