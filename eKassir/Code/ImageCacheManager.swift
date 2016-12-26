//
//  ImageCacheManager.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 22/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

fileprivate struct CacheModel {
    let fileName: String
    let frostDate: Date
}

class ImageCacheManager: CacheManagement {
    
    fileprivate typealias SaveToFilePack = (model: CacheModel, binary: Data)
    
    private enum ImageType {
        case JPG, PNG
    }
    
    private enum CacherError: Error {
        case ImageTypeRecognition
    }
    
    private let cacherPath = NSTemporaryDirectory()
    private let cacheCleanPeriod: TimeInterval = 10 * 60  //  10 min
    private let cacheCleanCheckPeriod: TimeInterval = 60  //  1 min
    private let maxCachedObjects = 20
    private var timer: Timer? {
        didSet {
            guard let _timer = timer else { return }
            let runLoop = RunLoop.current
            runLoop.add(_timer, forMode: .defaultRunLoopMode)
        }
    }
    private var library = [String: CacheModel]()
    
    //MARK: - Life cycle
    
    deinit {
        timer?.invalidate()
        library.forEach { (key, _) in
            dropCached(by: key)
        }
    }
    
    //MARK: - Public
    
    func activate() {
        timer = Timer(timeInterval: cacheCleanCheckPeriod, target: self, selector: #selector(handleTimerCycle), userInfo: nil, repeats: true)
    }
    
    func put(_ object: AnyObject, byIdentifier identifier: String) {
        guard library.count < maxCachedObjects else { return }
        guard let source = object as? UIImage else { return }
        guard let imageType = try? detectImageType(fromFileName: identifier) else { return }
        
        var prepackBinary: Data?
        
        switch imageType {
        case .PNG:
            prepackBinary = UIImagePNGRepresentation(source)
        case .JPG:
            prepackBinary = UIImageJPEGRepresentation(source, 1)
        }
        
        guard let prepacked = prepackBinary else { return }
        
        let archiveObject = CacheModel(fileName: identifier, frostDate: Date())
        
        library[identifier] = archiveObject
        saveToDisk((archiveObject, prepacked))
    }
    
    func fetch(by identifier: String) -> AnyObject? {
        guard let toDefrost = library[identifier] else { return nil }
        guard let toDefrostBinary = loadFromDisk(fileName: toDefrost.fileName) else { return nil }
        
        return UIImage(data: toDefrostBinary)
    }
    
    //MARK: - Private
    
    private func detectImageType(fromFileName identifier: String) throws -> ImageType {
        let _identifier = identifier.lowercased()
        
        if _identifier.hasSuffix("png") {
            return .PNG
        } else if _identifier.hasSuffix("jpeg") || _identifier.hasSuffix("jpg") {
            return .JPG
        }
        throw CacherError.ImageTypeRecognition
    }
    
    @objc private func handleTimerCycle() {
        let killPointDate = Date(timeInterval: -cacheCleanPeriod, since: Date())
        
        let toKill = library.filter { (_, object) -> Bool in
            object.frostDate <= killPointDate
        }
        
        toKill.forEach { [unowned self] (key, _) in
            self.dropCached(by: key)
        }
    }
    
    fileprivate func saveToDisk(_ prepack: SaveToFilePack) {
        let path = cacherPath.appending(prepack.model.fileName)
        
        guard FileManager.default.createFile(atPath: path, contents: prepack.binary, attributes: nil) else {
            return
        }
    }
    
    private func loadFromDisk(fileName: String) -> Data? {
        var url = URL(fileURLWithPath: cacherPath)
        url.appendPathComponent(fileName)
        
        guard FileManager.default.fileExists(atPath: url.absoluteString) else { return nil }
        guard let loadedData = try? Data(contentsOf: url) else { return nil }
        return loadedData
    }
    
    private func dropCached(by identifier: String) {
        var url = URL(fileURLWithPath: cacherPath)
        url.appendPathComponent(identifier)
        guard ((try? FileManager.default.removeItem(at: url)) != nil) else { return }
        
        library[identifier] = nil
    }
}
