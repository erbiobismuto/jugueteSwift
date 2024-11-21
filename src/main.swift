import tinyptc
import pico

let width: Int32 = 640
let height: Int32 = 360

    // Color constants
let colors = (
    red: 0x00FF0000,
    green: 0x0000FF00,
    blue: 0x000000FF,
    alpha: 0xFF000000
)
    
// Create entity manager
var entityManager = EntityManager()
entityManager.createEntity(
    x:  100, 
    y: 10, 
    width: 50, 
    height: 50, 
    color: [colors.green, colors.blue, colors.alpha]
)

let entityData = (0..<10).map { i in
    (
       x: UInt32(i * 20), 
       y: UInt32(i * 20), 
       width: UInt32(16), 
       height: UInt32(16), 
       color: [colors.green, colors.blue, colors.alpha]
    )
}
    
entityManager.createEntities(entityData)

var renderSys = RenderSystem(width, height)!
defer {
    renderSys.cleanup()
}

while ptc_process_events() == 0 {
    renderSys.clear(withColor: colors.red)
    renderSys.render(entities: entityManager.entities)
    renderSys.display()  // Update screen once per frame
}


