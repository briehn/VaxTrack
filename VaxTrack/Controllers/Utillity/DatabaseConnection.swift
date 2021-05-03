//
//  DatabaseConnection.swift
//  Capstone Project iOS
//
//  Created by Patrick on 4/29/21.
//

import Foundation

//protocol DatabaseConnectionProtocol: NSObjectProtocol {
//    func dataDownloaded(type: String, obj: NSObject?)
//}

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (data, response, error)
    }
}

class DatabaseConnection: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: DatabaseConnectionProtocol!
    
    static let urlPath = "http://hftsoft.hopto.org:8341/api.php"

    static func fetchData(_ type:String, _ data:NSDictionary?) -> NSObject? {
        var theUrl = urlPath + "?type=\(type)"
        // add parameters from data for each type to the url. will be given in excel
        switch type {
        case "login":
            theUrl += "&login=\(data?["login"] ?? "")&password=\(data?["password"] ?? "")"
        case "u_profile":
            theUrl += "&uid=\(data?["uid"] ?? 0)"
        default:
            print("invalid type");
        }

        let url: URL = URL(string: theUrl)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        // here we use synchronous fetch
        var outdata: Data?
        var response: URLResponse?
        var error: Error?
        var obj: NSObject?
        (outdata, response, error) = defaultSession.synchronousDataTask(with: url)
        if error != nil {
            print("Failed to download data")
        } else {
            print("Data downloaded")
            //print(outdata!)
            obj = self.parseJSON(type, outdata!)
        }
        return obj
    }
    
    static func parseJSON(_ type:String, _ data:Data) -> NSObject? {
        
        var jsonResult = NSDictionary()
           
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        } catch let error as NSError {
            print(error)
        }
        
        print(jsonResult)
        var obj:NSObject? = nil

        if let code = jsonResult["code"] as? Int {
            if code < 0 {
                print("api failed")
            } else {
                if let datas = jsonResult["data"] as? NSArray {
                    switch type {
                    case "login":
                        obj = JSONParser.parseLogin(datas);
                    case "u_profile":
                        obj = JSONParser.parsePatient(datas);
                    default:
                        print("invalid type");
                    }
                }
            }
        }

        //DispatchQueue.main.async(execute: { () -> Void in
        //    self.delegate.dataDownloaded(type: type, obj: obj)
        //})
        return obj
    }

}
