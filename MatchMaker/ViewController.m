//
//  ViewController.m
//  MatchMaker
//
//  Created by Johnson Ejezie on 3/7/15.
//  Copyright (c) 2015 Johnson Ejezie. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Firebase/Firebase.h>


// The Firebase you want to use for this app
// You must setup Simple Login for the various authentication providers in Forge
static NSString * const kFirebaseURL = @"https://match-maker.firebaseio.com";


@interface ViewController ()

// A dialog that is displayed while logging in
@property (nonatomic, strong) UIAlertView *loginProgressAlert;

// The Firebase object
@property (nonatomic, strong) Firebase *ref;

@property (nonatomic, strong) NSDictionary* currentUser;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends"]];
    loginView.delegate = self;
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), (self.view.center.y - (loginView.frame.size.height / 2)));
    
    [self.view addSubview:loginView];
    // Do any additional setup after loading the view, typically from a nib.
    
    // create the simple login instance
    self.ref = [[Firebase alloc] initWithUrl:kFirebaseURL];
    
    NSLog(@"current user %@", _currentUser);
}

// Call method when user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    NSLog(@"user data %@", user);
    
    NSDictionary* userDetails = @{
                                  @"email" : user[@"email"],
                                  @"name" : user[@"name"],
                                  @"gender" : user[@"gender"],
                                  @"link" : user[@"link"],
                                  @"id" : user[@"id"],
                                  @"first_name": user[@"first_name"],
                                  @"last_name": user[@"last_name"]
                                  };

    
    self.ref = [[Firebase alloc] initWithUrl:kFirebaseURL];
    
    Firebase *usersRef = [_ref childByAppendingPath: @"users"];
    Firebase *currentUserRef = [usersRef childByAppendingPath: user[@"id"]];
    [currentUserRef setValue:userDetails];
    
    _currentUser = userDetails;
    
}

@end
