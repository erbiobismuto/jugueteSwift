import tinyptc
import Foundation


struct RenderSystem {
    private var screen: [Int]
    let width: Int32
    let height: Int32
    
    init?(_ w: Int32, _ h: Int32) {
        guard w > 0 && h > 0 else { return nil }
        width = w
        height = h
        screen = Array(repeating: 0, count: Int(width * height))
        guard ptc_open("window", width, height) != 0 else { return nil }
    }
    
    mutating func clear(withColor backgroundColor: Int) {
        screen = Array(repeating: backgroundColor, count: Int(width * height))
    }
    
    mutating func renderSprite(_ sprite: [Int], at point: (x: UInt32, y: UInt32), size: (width: UInt32, height: UInt32)) {
        let screenBuffer = screen.withUnsafeMutableBufferPointer { buffer in
            return buffer
        }
    
        let spriteBuffer = sprite.withUnsafeBufferPointer { buffer in
            return buffer
        }
    
        guard let baseScreenPtr = screenBuffer.baseAddress,
        let baseSpritePtr = spriteBuffer.baseAddress else { return  }
    
        var pscr = baseScreenPtr + (Int(point.y) * Int(width) + Int(point.x))
        var psp = baseSpritePtr
    
        for _ in 0..<Int(size.height) {
            // Copy a full row of pixels
            for _ in 0..<Int(size.width) {
                pscr.pointee = psp.pointee
                pscr += 1
                psp += 1
            }
        
            pscr += Int(width) - Int(size.width)
        }
    }
    
    mutating func render(entities: [Entity]) {
        for entity in entities {
            renderSprite(
                entity.sprite, 
                at: (x: entity.x, y: entity.y), 
                size: (width: entity.width, height: entity.height)
            )
        }
    }

   // New method to update the screen buffer
    mutating func display() {
        _ = screen.withUnsafeMutableBytes { buffer in
            ptc_update(buffer.baseAddress)
        }
    }
    
    func cleanup() {
        ptc_close()
    }
}

