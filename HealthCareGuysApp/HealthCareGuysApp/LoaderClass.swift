//
//  LoaderClass.swift
//  HealthCareGuysApp
//
//  Created by Thaneerath on 09/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import Foundation
class LoaderClass:ViewController,NSURLSessionDelegate{
    var data:NSURLResponse!
    let urlString :String = "https://read.netspective.com/api/index.php"

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    func login_request()
    {
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
    func getFeed_request()
    {
        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        let params:[String: AnyObject] = ["op" : "getFeeds",
                                          "cat_id " : "-4",
                                          "unread_only" : "false" ,"limit" : "" , "offset" : "" , "includeNested" : ""]
        
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
    

    
    
    
}
