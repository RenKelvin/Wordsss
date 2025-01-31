//
//  UserDataManager.m
//  Wordsss
//
//  Created by RenKelvin on 11-10-2.
//  Copyright 2011年 Ren Inc. All rights reserved.
//

#import "UserDataManager.h"

static UserDataManager* sharedUserDataManager;

@implementation UserDataManager

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (UserDataManager*)userdataManager
{
    if (!sharedUserDataManager) {
        sharedUserDataManager = [[UserDataManager alloc] init];
    }
    
    return sharedUserDataManager;
}

#pragma mark - Instance method

- (User*)createUser
{
    User* user = nil;
    
    //
    user = [User insertUser:nil inManagedObjectContext:__managedObjectContext];
    
    //
    user.status = [Status insertEntity:nil inManagedObjectContext:__managedObjectContext];
    user.defult = [Defult insertEntity:nil inManagedObjectContext:__managedObjectContext];
    user.profile = [Profile insertEntity:nil inManagedObjectContext:__managedObjectContext];
    
    user.memdata = [MemData insertEntity:nil inManagedObjectContext:__managedObjectContext];
    user.hisdata = [HisData insertEntity:nil inManagedObjectContext:__managedObjectContext];
    
    return user;
}

- (User*)createUser:(NSDictionary*)dict
{
    return nil;
}

- (WordRecord*)createWordRecord:(Word*)word forUser:(User*)user
{
    WordRecord* wordRecord = nil;
    
    wordRecord = [WordRecord insertWordRecord:word user:user inManagedObjectContext:__managedObjectContext];
    
    return wordRecord;
}

- (SearchHis*)createSearchHis:(Word*)word forUser:(User*)user
{
    SearchHis* searchHis = nil;
    
    searchHis = [SearchHis insertSearchHis:word user:user inManagedObjectContext:__managedObjectContext];
    
    return searchHis;
}

- (HisRecord*)createHisRecord:(WordRecord*)wordRecord forUser:(User*)user
{
    if ([wordRecord.dlc intValue] == 0) {
        return nil;
    }
    
    HisRecord* hisRecord = nil;
    
    hisRecord = [HisRecord insertHisRecord:wordRecord user:user inManagedObjectContext:__managedObjectContext];
    
    return hisRecord;
}

- (StaRecord*)createStaRecord:(User*)user
{
    StaRecord* staRecord = nil;
    
    staRecord = [StaRecord insertStaRecord:user inManagedObjectContext:__managedObjectContext];
    
    return staRecord;
}

- (NSArray*)getSearchHis
{
    NSArray* array = [NSArray array];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"SearchHis"];
    [request setFetchLimit:10];
    NSSortDescriptor* sortDesc = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDesc]];
    array = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    return array;
}

- (void)resetAll
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSArray* array = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    User* user = [array lastObject];
    
    if (user.memdata) {
        [self.managedObjectContext deleteObject:user.memdata];
    }
    if (user.hisdata) {
        [self.managedObjectContext deleteObject:user.hisdata];
    }
    if (user.status) {
        [self.managedObjectContext deleteObject:user.status];
    }
    
    HisData* hisData = [NSEntityDescription insertNewObjectForEntityForName:@"HisData" inManagedObjectContext:self.managedObjectContext];
    MemData* memData = [NSEntityDescription insertNewObjectForEntityForName:@"MemData" inManagedObjectContext:self.managedObjectContext];
    Status* status = [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:self.managedObjectContext];
    
    user.hisdata = hisData;
    user.memdata = memData;
    user.status = status;
}

#pragma mark - Core Data

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Wordsss" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Wordsss.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Clear

- (void)clear
{
    // Delete duplicates
    [self deleteDuplicates];
}

- (void)deleteDuplicates
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"WordRecord"];
    NSSortDescriptor* descri = [[NSSortDescriptor alloc] initWithKey:@"word_id" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:descri]];
    
    NSArray* result = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    int word_id = -1;
    for (WordRecord* wr in result) {
        if ([wr.word_id intValue] == word_id) {
            NSLog(@"Duplicate! word_id: %@", wr.word_id);
            [self.managedObjectContext deleteObject:wr];
        }
        word_id = [wr.word_id intValue];
    }
}

#pragma mark -

- (void)doDebug
{
    [self clear];
}

@end
