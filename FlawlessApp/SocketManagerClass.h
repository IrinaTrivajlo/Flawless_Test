//
//  SocketManagerClass.h
//  FlawlessApp
//
//  Created by Ирина on 23.07.18.
//  Copyright © 2018 trivajlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SocketIO/SocketIO-Swift.h>

@interface SocketManagerClass : NSObject

@property (nonatomic, retain) SocketIOClient *socetClient;

- (void) initializeSocket;
+ (SocketManagerClass*) sharedInstance;

@end
