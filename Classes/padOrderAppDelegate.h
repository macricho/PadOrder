//
//  padOrderAppDelegate.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/1.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BeginViewController;
@class GStepControllerCollection;
@class padOrderSplitControllerDelegate;
@class EntityDish;
@class EntityOrderKind;
@class padOrderFacebookDelegate;
//@class PORequestFromWebConnectionDeleagte;
@interface padOrderAppDelegate : NSObject <UIApplicationDelegate,UIAlertViewDelegate> {
    UIWindow *window;
     UISplitViewController *mainSplitViewController;
    BeginViewController *beginViewController;
    padOrderFacebookDelegate *facebookDelegate;
    UINavigationController *BGNavigationController;
    GStepControllerCollection *guideStepObject;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}
@property (nonatomic ,retain) IBOutlet UISplitViewController *mainSplitViewController;
@property (nonatomic, retain) UINavigationController *BGNavigationController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) BeginViewController *beginViewController;

@property (nonatomic, retain) padOrderFacebookDelegate *facebookDelegate;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) GStepControllerCollection *guideStepObject;

- (void) windowPageTransitionAnimation:(NSInteger)type;
- (IBAction) actionToNext:(id)sender;
- (NSURL *)applicationDocumentsDirectory;
- (void) insertTempData;
- (void) setDishKind;
- (EntityOrderKind *)selectKindObjectWithSegmentType:(NSInteger)typeNo andSegmentNo:(NSInteger)segmentNo;
- (IBAction) backToIndexView:(id)sender;

@end

