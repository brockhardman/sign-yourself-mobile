
import Foundation


/// Enum that indicates where the file will be stored
///
/// - documents: The Document directory in the applications sandbox
/// - cache: The Cache directory in the applications sandbox
/// - temp: The Temp Directgory in the applications sandbox.
public enum ApplicationSandBox {
    case documents
    case cache
    case temp
}

public extension URL {
    
    static func url(with httpServerString: String?) -> URL? {
        guard let serverString = httpServerString, serverString.count > 0 else {
            return nil
        }
        
        if serverString.subString(from: 0, to: 7) == "http://" ||
            serverString.subString(from: 0, to: 8) == "https://" {
            return URL(string: serverString)
        }
        
        return URL(string: "https://\(serverString)")
    }
    
    /// Gets the url of file in a specified directory or the url of the Directory
    ///
    /// - Parameters:
    ///   - path: File name
    ///   - directory: Directory name
    ///   - sandBox: Location of the directory or file
    /// - Returns: URL of the file or directory
    
    @discardableResult
    static func file(name path: String? = nil, in directory: String? = nil, sandBox: ApplicationSandBox) -> URL? {
        
        guard let directoryPath = self.directory(name: directory, sandBox: sandBox) else {
            return nil
        }
        
        guard let filePath = path, !filePath.isEmpty else {
            return directoryPath
        }
        
        return directoryPath.appendingPathComponent(filePath)
    }

    
    /// Writes data to the URL
    ///
    /// - Parameter data: Data that will be written to the URL
    /// - Throws: Error if data was not able to write to
    func write(data: Data) throws {
        do {
            try data.write(to: self, options: NSData.WritingOptions.atomicWrite)
        } catch let error {
            throw(error)
        }
    }
    
    // MARK: Private Methods 
    
    static func directory(name directory: String?, sandBox: ApplicationSandBox) -> URL? {
        guard var sandBoxDirectory = self.appSandboxDirectory(sandBox) else {
            return nil
        }
        
        guard let directoryName = directory else {
            return sandBoxDirectory
        }
        
        sandBoxDirectory = sandBoxDirectory.appendingPathComponent(directoryName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: sandBoxDirectory.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: sandBoxDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch let error  {
                print(error)
            }
        }
        
        return sandBoxDirectory
    }
    
    private static func appSandboxDirectory(_ sandBox: ApplicationSandBox) -> URL? {
        
        switch sandBox {
        case .documents: return self.documentDirectory()
        case .cache: return self.cacheDirectory()
        case .temp: return self.tempDirectory()
        }
    }
    
    private static func documentDirectory() -> URL? {
        
        guard let url = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last else {
            
            return nil
        }
        
        return url
    }
    
    private static func cacheDirectory() -> URL? {
        
        guard let url = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last else {
            
            return nil
        }
        
        return url
    }
    
    private static func tempDirectory() -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
}
