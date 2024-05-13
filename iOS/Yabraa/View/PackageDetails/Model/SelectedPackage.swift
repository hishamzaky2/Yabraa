//
//  SelectedPackage.swift
//  Yabraa
//
//  Created by Hamada Ragab on 22/06/2023.
//

import Foundation
class SelectedPackage {
    static let shared = SelectedPackage()
    
    private init() {}
    var packages = [Packages]()
    var lat = ""
    var lng = ""
    var users: [UserFamliy] = []
    var serviceImage = ""
    var serviceTitle = ""
    var serviceType: ServicesType?
    func addPackage(package: Packages) {
        packages.append(package)
    }
    func emptySelectedPackages() {
        packages = []
        lat = ""
        lng = ""
        users = []
        serviceType = nil
    }
    func removePackage(package: Packages) {
        if let removedPackageIndex = self.packages.firstIndex(where: {savedpackages  in
            savedpackages.packageId == package.packageId
        }) {
            self.packages.remove(at: removedPackageIndex)
        }
    }
    func updatePackage(package: Packages) {
        if let updatedPackageIndex = self.packages.firstIndex(where: {savedpackages  in
            savedpackages.packageId == package.packageId
        }) {
            self.packages[updatedPackageIndex] = package
        }
    }
    func removeAllSavedPackage() {
        packages.removeAll()
    }
    func isPackagedAddedBefore(package: Packages)-> Bool {
        return packages.contains { savedpackage in
            savedpackage.packageId == package.packageId
        }
    }
}
