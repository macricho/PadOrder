//
//  PORequestFromWebConnectionDeleagte.m
//  PadOrder!
//
//  Created by TING-JUI CHO on 2011/2/11.
//  Copyright 2011 逢甲大學資訊工程學系. All rights reserved.
//

#import "PORequestFromWebConnectionDeleagte.h"
#import "padOrderAppDelegate.h"

@implementation PORequestFromWebConnectionDeleagte
@synthesize data;
@synthesize objectURL;
@synthesize fileManager;

- (id) initWitURL:(NSURL *)url{
	self = [super init];
	if (self) {
		self.data = [[NSMutableData data] retain];
		//self.objectURL = 
		self.fileManager = [NSFileManager defaultManager];
        [self downloadAchieveFromURL:url];
	}
	return self;
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[self.data setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)incomingdata{
	[self.data appendData:incomingdata];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    //NSLog(@"%@",self.objectURL);
    //NSLog(@"????");
    NSURL *dirURL = nil;
	//NSURL *dirURL = [self.objectURL URLByDeletingLastPathComponent];
	ZipArchive* za = [[ZipArchive alloc] init];
	if ([self.data writeToURL:self.objectURL atomically:YES]) {
		if([za UnzipOpenFile:[self.objectURL path]]){
			if ([za UnzipFileTo:[dirURL path] overWrite:YES]) {
				//封存所有主題視圖
				[self archivingThemeViews];
				UIAlertView *remain = [[UIAlertView alloc] initWithTitle:@"即將關閉應用程式" message:@"PadOrder需要重新啟動，以啟用您所設定的主題佈景。" delegate:self cancelButtonTitle:@"重新啟動" otherButtonTitles:nil];
				[remain show];
				[remain release];
			}			
			[za UnzipCloseFile];
			
		}
		else {
			UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"解壓縮失敗" message:@"解壓縮開啟檔案失敗！請聯絡系統管理員！" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil];
			[errorAlert show];
			[errorAlert release];
		}

        [za release];
	}
	else{
		UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"下載失敗" message:@"檔案下載失敗！請聯絡系統管理員！" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil];
		[errorAlert show];
		[errorAlert release];
	}
	
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	
}

- (void) archivingThemeViews{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSURL *currentThemeDirectory = [defaults URLForKey:@"currentThemeDirectory"];
	NSString *rootPlistPath = [NSBundle pathForResource:@"Info" ofType:@"poli" inDirectory:[currentThemeDirectory path]];
	NSDictionary *rootDictionary = [NSDictionary dictionaryWithContentsOfFile:rootPlistPath];
	NSDictionary *viewsDictionary = [rootDictionary objectForKey:@"Views"];
	for (NSString *key in [viewsDictionary allKeys]) {
		NSDictionary *keyDictionary = [viewsDictionary objectForKey:key];
		//NSURL *dirURL = [currentThemeDirectory URLByAppendingPathComponent:[keyDictionary objectForKey:@"dir"]];
		[self performSelector:@selector(starterView)];
		//NSLog(@"%@",[self viewKeyToSelector:key]);
	}
}

- (SEL) viewKeyToSelector:(NSString *)key{
	SEL selector;
	if ([key isEqualToString:@"Starter"]) {
		return @selector(starterView);
	}
	return selector;
}

- (NSKeyedArchiver *) starterView{
	NSLog(@"%@",@"111111");
	return nil;
}

- (NSURL *) downloadAchieveFromURL:(NSURL *)url{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *httpURL = [[NSURL alloc] initWithScheme:@"http" host:[url host] path:[url relativePath]];
	//建立httpRequest
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:httpURL 
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad //設定下載行為
                                              timeoutInterval:60.0];
	padOrderAppDelegate *appDelegate = (padOrderAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.objectURL = [[appDelegate applicationDocumentsDirectory] URLByAppendingPathComponent:@"Themes"];
	objectURL = [objectURL URLByAppendingPathComponent:[httpURL lastPathComponent]];
	
	if ([fileManager fileExistsAtPath:[objectURL path]]) {
		[fileManager removeItemAtPath:[objectURL path] error:nil];
	}
	//實體化：處理從網頁連結過來的Connection委派物件
	//PORequestFromWebConnectionDeleagte *connectionDeleagte = [[PORequestFromWebConnectionDeleagte alloc] initWitURL:objectURL];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	//啟動網頁Connection，執行下載
	[connection start];
    return  objectURL;
}



- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 0) {
		//UIApplicationMain(<#int argc#>, <#char [] *argv#>, <#NSString *principalClassName#>, <#NSString *delegateClassName#>)
		//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"padorder://localhost/"]];
		exit(0);
	}
}

@end
