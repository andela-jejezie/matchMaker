//
//  ViewController.h
//  MatchMaker
//
//  Created by Johnson Ejezie on 3/7/15.
//  Copyright (c) 2015 Johnson Ejezie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface ViewController : UIViewController<UIActionSheetDelegate, FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

