//
//  PORequestFromWebConnectionDeleagte.h
//  PadOrder!
//
//  Created by TING-JUI CHO on 2011/2/11.
//  Copyright 2011 逢甲大學資訊工程學系. All rights reserved.
//
//	此為處理當從網址進行下載主題時的委派類別

#import <Foundation/Foundation.h>

#import "POThirdImporter.h"

@interface PORequestFromWebConnectionDeleagte : NSObject<UIAlertViewDelegate>{
	NSMutableData *data;
	NSURL *objectURL;
	NSFileManager *fileManager;
}

@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURL *objectURL;
@property (nonatomic, retain) NSFileManager *fileManager;

- (id) initWitURL:(NSURL *)url;
- (void) archivingThemeViews;
- (SEL) viewKeyToSelector:(NSString *)key;
- (NSKeyedArchiver *) starterView;
- (NSURL *) downloadAchieveFromURL:(NSURL *)url;
@end
