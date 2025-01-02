//
//  IoC.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 06/12/24.
//

import Foundation
import Swinject

class IoC {
    
    enum ContainerType {
        case shared

        var container: Container {
            return IoC.SharedContainer
        }
    }

    static let SharedContainer = Container()

    static func reset(container type: ContainerType) {
        type.container.removeAll()
    }
    
    static func registerInstance<Service>(_ serviceType: Service.Type, instance: Service, into containerType: ContainerType = .shared) {
        containerType.container.register(serviceType) { _ in
            return instance
        }.inObjectScope(.graph)
    }

    static func resolve<Service>(_ serviceType: Service.Type, from containerType: ContainerType = .shared) -> Service? {
        return containerType.container.resolve(serviceType)
    }
}
