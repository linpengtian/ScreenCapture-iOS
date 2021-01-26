//
//  ViewController.h
//  ScreenCapture
//
//  Created by bigstar on 1/14/21.
//

#import <UIKit/UIKit.h>

#import "BackgroundTask.h"


@interface ViewController : UIViewController
@property (strong, nonatomic) BackgroundTask * bgTask;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)onStart:(id)sender;

@end

