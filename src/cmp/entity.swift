struct Entity {
    var x: UInt32
    var y: UInt32
    var width: UInt32
    var height: UInt32
    var sprite: [Int]
    
    // Initializer with default parameters
    init(x: UInt32 = 0, y: UInt32 = 0, width: UInt32 = 0, height: UInt32 = 0, color: [Int] = []) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        // Handle empty color case
        guard !color.isEmpty, width > 0, height > 0 else {
            self.sprite = []
            return
        }
        // Create sprite by cycling through colors
        self.sprite = (0..<Int(width * height)).map { index in
            color[index % color.count]
        }
    }
}
