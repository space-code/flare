//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class FileManagerMock: IFileManager {
    var invokedFileExists = false
    var invokedFileExistsCount = 0
    var invokedFileExistsParameters: (path: String, Void)?
    var invokedFileExistsParametersList = [(path: String, Void)]()
    var stubbedFileExistsResult: Bool! = false

    func fileExists(atPath path: String) -> Bool {
        invokedFileExists = true
        invokedFileExistsCount += 1
        invokedFileExistsParameters = (path, ())
        invokedFileExistsParametersList.append((path, ()))
        return stubbedFileExistsResult
    }
}
