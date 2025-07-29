module claybindingsc3;
import std::io;
import raylib5;
import clay;

const uint FONT_ID_BODY_16 = 0;

fn void errorHandler(ErrorData errorData)
{
    // std::io::printfn("ERROR: \"%s\"", errorData.errorText.chars);
}

bool isDebugModeEnabled = false;

fn void main()
{
	rl::setConfigFlags(rl::FLAG_VSYNC_HINT | rl::FLAG_WINDOW_RESIZABLE | rl::FLAG_WINDOW_HIGHDPI | rl::FLAG_MSAA_4X_HINT);
    rl::initWindow(1024, 768, "Introducing Clay C3-Demo");
    defer rl::closeWindow();

    uint clayRequiredMemory = clay::minMemorySize();
    Arena clayMemory = clay::createArenaWithCapacityAndMemory(clayRequiredMemory, malloc(clayRequiredMemory));
    clay::initialize(clayMemory, { rl::getScreenWidth(), rl::getScreenHeight() }, { &errorHandler, null });

    
    clay::setMeasureTextFunction( (MeasureTextFunc) &clay::renderer::raylibMeasureText, null);
    clay::renderer::raylibFonts[FONT_ID_BODY_16] = { 
        FONT_ID_BODY_16, 
        rl::loadFontEx("resources/Lexend-Regular.ttf", 48, null, 400)
    };

    rl::setTextureFilter(
        clay::renderer::raylibFonts[FONT_ID_BODY_16].font.texture, 
        TextureFilter.BILINEAR
    );


    // =======================================
    // ===== predeclare reusable configs =====
    // =======================================
	
    while (!rl::windowShouldClose()) {
        clay::setLayoutDimensions({rl::getScreenWidth(), rl::getScreenHeight()});
        Vector2 mouse_position = rl::getMousePosition();
        Vector2 scroll_delta = rl::getMouseWheelMoveV();
        clay::setPointerState({mouse_position.x, mouse_position.y}, rl::isMouseButtonDown(MouseButton.LEFT));
        clay::updateScrollContainers(true, {scroll_delta.x, scroll_delta.y}, rl::getFrameTime());

        if (rl::isKeyReleased(rl::KEY_D)) { isDebugModeEnabled = !isDebugModeEnabled; clay::setDebugModeEnabled(isDebugModeEnabled); }

        clay::beginLayout();
		//
		RenderCommandArray renderCommands = clay::endLayout();
        

        rl::beginDrawing();
        rl::clearBackground(rl::BLACK);
        clay::renderer::raylibRender(renderCommands);
        rl::endDrawing();
	}

}