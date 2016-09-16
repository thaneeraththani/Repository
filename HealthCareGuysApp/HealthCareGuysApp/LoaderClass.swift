//
//  LoaderClass.swift
//  HealthCareGuysApp
//
//  Created by Thaneerath on 09/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import Foundation
import CoreData
class HeadLines : NSManagedObject {
    var headline: NSString = NSString()
    var newsDetails : NSString = NSString()
    var comment: NSString = NSString()
    var commentedDate: NSString = NSString()
    var id:Int = Int()

    
}

class LoaderClass:ViewController,NSURLSessionDelegate {
    var data:NSURLResponse!
    var newsToSave = [NSManagedObject]()
    let urlString :String = "https://read.netspective.com/api/index.php"
    var list : Array<HeadLines> = []
    var id = NSMutableArray()
    var headLine = NSMutableArray()
    var commentTime = NSMutableArray()
    var category = NSMutableArray()
    var dictionary :Dictionary<String,String> = [:]
    var firstData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func login_request() {
        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        let params:[String: AnyObject] = ["op" : "login",
                                          "user" : "thaneerath.th@citrusinformatics.com",
                                          "password" : "qwerty123?" ]
        
        do{
            let request = NSMutableURLRequest(URL: url)
            
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            //"op":"login","user":"you","password":"xxx"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPMethod = "POST"
            var err: NSError?
            try
                request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
            
            let task = session.dataTaskWithRequest(request) {
                (
                let data, let response, let error) in
                
                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                    print("error")
                    return
                }
                
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(dataString)
                
                
            }
            
            task.resume()
            
        }catch{
            
        }
    }
    
    
    func getHeadlines_request() {
        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        let params:[String: AnyObject] = ["op" : "getHeadlines","sid" : "hf5b27ugb2bgl1qg0gekio2i51",
                                          "feed_id" : "-4",
                                          "limit" : "100" ,"skip" : "0", "view_mode" : "all_articles" , "is_cat" : "1","include_attachments" : "1", "show_content" : "1"]
        
        do{
            let request = NSMutableURLRequest(URL: url)
            
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            //"op":"login","user":"you","password":"xxx"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPMethod = "POST"
            var err: NSError?
            try
                request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
            
            let task = session.dataTaskWithRequest(request) {
                (
                let data, let response, let error) in
                
                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                    print("error\(error)")
                    return
                }
                
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(dataString)
                
                let dataR = dataString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(dataR, options: []) as! [String: AnyObject]
                    self.parse(json)
                    print("HeadLines structure data\(self.headLine)")
                    self.saveName()
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
            
            task.resume()
            
        }catch{
            
        }
    }
    
    
    func parse(anyObj:AnyObject) {
        var list:Array<HeadLines> = []
      //  print("full content iss\(anyObj["content"])")
        if  anyObj["content"] is Array<AnyObject> {
            
           
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            let b = NSEntityDescription.insertNewObjectForEntityForName("News", inManagedObjectContext: managedContext) as! HeadLines
            for json in anyObj["content"] as! [[String:AnyObject]] {
              
                b.id = (json["id"] as AnyObject? as? Int) ?? 0
                b.comment = (json["updated"] as AnyObject? as? String) ?? ""
                b.headline = (json["title"] as AnyObject? as? String) ?? ""
                b.newsDetails  =  (json["content"]  as AnyObject? as? String) ?? ""
                id.addObject(b.id)
               headLine.addObject(b.headline)
                commentTime.addObject(b.comment)
                 // print("VALUES: \(headLine)")
            }// for
            
        } // if
        
       
    }
    
    
    func saveName() {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("News",
                                                        inManagedObjectContext:managedContext)
        
        let news = NSManagedObject(entity: entity!,
                                   insertIntoManagedObjectContext: managedContext)
        let countOf = id.count
        print("count iss \(countOf)")
        for i in 0...countOf - 1 {
                       //3
            news.setValue(headLine.objectAtIndex(i), forKey: "headLine")
            

          // news.setValue(list.newsDetails, forKey: "newsDetails")
            news.setValue(commentTime, forKey: "comment")
            

            // news.setValue(list.commentedDate, forKey: "commentedTime")
            news.setValue(id.objectAtIndex(i), forKey: "id")
                           //4
            do {
                try managedContext.save()
                //5
                newsToSave.append(news as NSManagedObject)
                //print("helloo\(newsToSave)")
                } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    
    func getData() -> Dictionary<String,String>{
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        let request = NSFetchRequest(entityName: "News")
        do{
            let entities = try managedContext.executeFetchRequest(request) as! [HeadLines]
           // print("entities array\(entities)")
            for item in entities{
                for key in item.entity.attributesByName.keys{
                    let value: AnyObject? = item.valueForKey(key)
                    print("\(key) = \(value)")
                    if key != "id"{
                        
                     
                    }
                }
               //  print("list items\(list)")
                
            }
            
             print("list items outside\(dictionary)")
            
      
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return dictionary
    }
}