
struct EntityManager {
    private(set) var entities: [Entity] = []

    @discardableResult
    mutating func createEntity(x: UInt32 = 0, y: UInt32 = 0, width: UInt32 = 0, height: UInt32 = 0, color: [Int] = []) -> Entity {
        let newEntity = Entity(x: x, y: y, width: width, height: height, color: color)
        entities.append(newEntity)
        return newEntity
    }

    // Bulk entity creation with efficiency in mind
    mutating func createEntities(_ entityData: [(x: UInt32, y: UInt32, width: UInt32, height: UInt32, color: [Int])]) {
        // Transform and append in one go
        let newEntities = entityData.map { data in
            Entity(x: data.x, y: data.y, width: data.width, height: data.height, color: data.color)
        }

        // Append multiple entities efficiently
        entities.append(contentsOf: newEntities)
    }

    // Add more idiomatic Swift methods
    mutating func removeAll() {
        entities.removeAll()
    }

    // Add subscript for direct entity access
    subscript(index: Int) -> Entity? {
        guard index >= 0 && index < entities.count else { return nil }
        return entities[index]
    }
} 
