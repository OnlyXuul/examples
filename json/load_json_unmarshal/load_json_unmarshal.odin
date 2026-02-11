package load_json_unmarshal

import "core:os"
import "core:fmt"
import "core:encoding/json"

Game_Settings :: struct {
	window_width: i32,
	window_height: i32,
	window_title: string,
	rendering_api: string,
	renderer_settings: struct{
		msaa: bool,
		depth_testing: bool,
	},
}

main :: proc(){
	// Load in your json file!
	data, read_err := os.read_entire_file("game_settings.json", context.allocator)
	if read_err != nil {
		fmt.eprintfln("Failed to load the file: %v", read_err)
		return
	}
	defer delete(data) // Free the memory at the end

	// Load data from the json bytes directly to the struct
	settings: Game_Settings
	unmarshal_err := json.unmarshal(data, &settings)
	if unmarshal_err != nil {
		fmt.eprintln("Failed to unmarshal the file!")
		return
	}
	fmt.eprintf("Result %v\n", settings)

	// Clear allocated strings
	delete(settings.window_title)
	delete(settings.rendering_api)
}
