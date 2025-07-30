module videoexample;

import clay;
import raylib5::rl;

const uint FONT_ID_BODY_16 = 0;

fn void errorHandler(ErrorData errorData)
{
    // std::io::printfn("ERROR: \"%s\"", errorData.errorText.chars);
}

fn void renderDropdownMenuItem(String text) {
    @clay(
        { .layout = clay::layout({ .padding = clay::paddingUni(16)})}
    ) {
        clay::text(
            text, clay::textConfig({
            .fontId = FONT_ID_BODY_16,
            .fontSize = 16,
            .textColor = { 255, 255, 255, 255 },
        }));
    };
}

fn void renderHeaderButton(String text) {
    @clay({
            .layout = clay::layout({ .padding = { 16, 16, 8, 8 }}),
            .backgroundColor = { 140, 140, 140, 255 },
            .cornerRadius = clay::cornerRadiusUni(5)
        }
    ) {
        clay::text(text, clay::textConfig({
            .fontId = FONT_ID_BODY_16,
            .fontSize = 16,
            .textColor = { 255, 255, 255, 255 },
        }));
    };
}


struct SidebarClickData{
    int requestedDocumentIndex;
    int* selectedDocumentIndex;
} 

fn void handleSidebarInteraction(
    ElementId elementId,
    PointerData pointerData,
    iptr userData
) {
    SidebarClickData *clickData = (SidebarClickData*)userData;
    // If this button was clicked
    if (pointerData.state == PointerState.RELEASED_THIS_FRAME) {
        if (clickData.requestedDocumentIndex >= 0 && clickData.requestedDocumentIndex < documents.len) {
            // Select the corresponding document
            *clickData.selectedDocumentIndex = clickData.requestedDocumentIndex;
        }
    }
}

struct Document {
    String title;
    String contents;
}

alias DocumentArray = Document[];
Document[5] documentsRaw;
DocumentArray documents = &documentsRaw;


bool isDebugModeEnabled = false;

struct VideoArena{
    iptr offset;
    iptr memory;
}

struct VideoDemoData {
    int selectedDocumentIndex;
    float yOffset;
    VideoArena arena;
}

fn VideoDemoData* VideoDemoData.init(&this) {
    documents[0] = { "Squirrels", "The Secret Life of Squirrels: Nature's Clever Acrobats\n""Squirrels are often overlooked creatures, dismissed as mere park inhabitants or backyard nuisances. Yet, beneath their fluffy tails and twitching noses lies an intricate world of cunning, agility, and survival tactics that are nothing short of fascinating. As one of the most common mammals in North America, squirrels have adapted to a wide range of environments from bustling urban centers to tranquil forests and have developed a variety of unique behaviors that continue to intrigue scientists and nature enthusiasts alike.\n""\n""Master Tree Climbers\n""At the heart of a squirrel's skill set is its impressive ability to navigate trees with ease. Whether they're darting from branch to branch or leaping across wide gaps, squirrels possess an innate talent for acrobatics. Their powerful hind legs, which are longer than their front legs, give them remarkable jumping power. With a tail that acts as a counterbalance, squirrels can leap distances of up to ten times the length of their body, making them some of the best aerial acrobats in the animal kingdom.\n""But it's not just their agility that makes them exceptional climbers. Squirrels' sharp, curved claws allow them to grip tree bark with precision, while the soft pads on their feet provide traction on slippery surfaces. Their ability to run at high speeds and scale vertical trunks with ease is a testament to the evolutionary adaptations that have made them so successful in their arboreal habitats.\n""\n""Food Hoarders Extraordinaire\n""Squirrels are often seen frantically gathering nuts, seeds, and even fungi in preparation for winter. While this behavior may seem like instinctual hoarding, it is actually a survival strategy that has been honed over millions of years. Known as \"scatter hoarding,\" squirrels store their food in a variety of hidden locations, often burying it deep in the soil or stashing it in hollowed-out tree trunks.\n""Interestingly, squirrels have an incredible memory for the locations of their caches. Research has shown that they can remember thousands of hiding spots, often returning to them months later when food is scarce. However, they don't always recover every stash some forgotten caches eventually sprout into new trees, contributing to forest regeneration. This unintentional role as forest gardeners highlights the ecological importance of squirrels in their ecosystems.\n""\n""The Great Squirrel Debate: Urban vs. Wild\n""While squirrels are most commonly associated with rural or wooded areas, their adaptability has allowed them to thrive in urban environments as well. In cities, squirrels have become adept at finding food sources in places like parks, streets, and even garbage cans. However, their urban counterparts face unique challenges, including traffic, predators, and the lack of natural shelters. Despite these obstacles, squirrels in urban areas are often observed using human infrastructure such as buildings, bridges, and power lines as highways for their acrobatic escapades.\n""There is, however, a growing concern regarding the impact of urban life on squirrel populations. Pollution, deforestation, and the loss of natural habitats are making it more difficult for squirrels to find adequate food and shelter. As a result, conservationists are focusing on creating squirrel-friendly spaces within cities, with the goal of ensuring these resourceful creatures continue to thrive in both rural and urban landscapes.\n""\n""A Symbol of Resilience\n""In many cultures, squirrels are symbols of resourcefulness, adaptability, and preparation. Their ability to thrive in a variety of environments while navigating challenges with agility and grace serves as a reminder of the resilience inherent in nature. Whether you encounter them in a quiet forest, a city park, or your own backyard, squirrels are creatures that never fail to amaze with their endless energy and ingenuity.\n""In the end, squirrels may be small, but they are mighty in their ability to survive and thrive in a world that is constantly changing. So next time you spot one hopping across a branch or darting across your lawn, take a moment to appreciate the remarkable acrobat at work a true marvel of the natural world.\n" };
    documents[1] = { "Lorem Ipsum", "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." };
    documents[2] = { "Vacuum Instructions", "Chapter 3: Getting Started - Unpacking and Setup\n""\n""Congratulations on your new SuperClean Pro 5000 vacuum cleaner! In this section, we will guide you through the simple steps to get your vacuum up and running. Before you begin, please ensure that you have all the components listed in the \"Package Contents\" section on page 2.\n""\n""1. Unboxing Your Vacuum\n""Carefully remove the vacuum cleaner from the box. Avoid using sharp objects that could damage the product. Once removed, place the unit on a flat, stable surface to proceed with the setup. Inside the box, you should find:\n""\n""    The main vacuum unit\n""    A telescoping extension wand\n""    A set of specialized cleaning tools (crevice tool, upholstery brush, etc.)\n""    A reusable dust bag (if applicable)\n""    A power cord with a 3-prong plug\n""    A set of quick-start instructions\n""\n""2. Assembling Your Vacuum\n""Begin by attaching the extension wand to the main body of the vacuum cleaner. Line up the connectors and twist the wand into place until you hear a click. Next, select the desired cleaning tool and firmly attach it to the wand's end, ensuring it is securely locked in.\n""\n""For models that require a dust bag, slide the bag into the compartment at the back of the vacuum, making sure it is properly aligned with the internal mechanism. If your vacuum uses a bagless system, ensure the dust container is correctly seated and locked in place before use.\n""\n""3. Powering On\n""To start the vacuum, plug the power cord into a grounded electrical outlet. Once plugged in, locate the power switch, usually positioned on the side of the handle or body of the unit, depending on your model. Press the switch to the \"On\" position, and you should hear the motor begin to hum. If the vacuum does not power on, check that the power cord is securely plugged in, and ensure there are no blockages in the power switch.\n""\n""Note: Before first use, ensure that the vacuum filter (if your model has one) is properly installed. If unsure, refer to \"Section 5: Maintenance\" for filter installation instructions." };
    documents[3] = { "Article 4", "Article 4" };
    documents[4] = { "Article 5", "Article 5" }; 
    this.arena = { .memory = (iptr)tmalloc(1024) };
    return this;
}

fn RenderCommandArray VideoDemoData.createLayout( VideoDemoData* data) {
    data.arena.offset = 0;
    clay::beginLayout();
    Sizing layoutExpand = (Sizing){ clay::sizingGrow(), clay::sizingGrow() };
    ClayColor contentBackgroundColor = {90,90,90,255};

    //STUFF TO RENDER

    @clay({
        .id = clay::id("OuterContainer"),
        .backgroundColor = { 43, 41, 51, 255 },
        .layout = clay::layout({
            .layoutDirection = LayoutDirection.TOP_TO_BOTTOM,
            .sizing = layoutExpand,
            .padding = clay::paddingUni(16),
            .childGap = 16,
        })
        }
    ) {
        @clay({
            .id = clay::id("HeaderBar"),
            .layout = clay::layout({
                .sizing = {
                    .height = clay::sizingFixed(60),
                    .width = clay::sizingGrow()
                },
                .padding = { 16, 16, 0, 0 },
                .childGap = 16,
                .childAlignment = {
                    .y = LayoutAlignmentY.CENTER
                }
            }),
            .backgroundColor = {90,90,90,255},
            .cornerRadius = clay::@cornerRadiusUniCT(8),
        }) {
            // Header buttons go here
            @clay({
                .id = clay::id("FileButton"),
                .layout= clay::layout({ .padding = { 16, 16, 8, 8 }}),
                .backgroundColor = { 140, 140, 140, 255 },
                .cornerRadius = clay::cornerRadiusUni(5)}
            ) {
                clay::text("File", clay::textConfig({
                    .fontId = FONT_ID_BODY_16,
                    .fontSize = 16,
                    .textColor = { 255, 255, 255, 255 },
                }));
                bool fileMenuVisible =
                    clay::pointerOver(clay::getElementId("FileButton"))
                    ||
                    clay::pointerOver(clay::getElementId("FileMenu"));
                if (fileMenuVisible) { // Below has been changed slightly to fix the small bug where the menu would dismiss when mousing over the top gap
                    @clay({
                        .id = clay::id("FileMenu"),
                        .floating = clay::floating({
                            .attachTo = FloatingAttachToElement.PARENT,
                            .attachPoints = {
                                .parent = FloatingAttachPointType.LEFT_BOTTOM,
                            },
                        }),
                        .layout =  clay::layout({
                            .padding = {0, 0, 8, 8 },
                        }),
                        }
                    ) {
                        @clay({
                            .layout =  clay::layout({
                                .layoutDirection = LayoutDirection.TOP_TO_BOTTOM,
                                .sizing = {
                                        .width = clay::sizingFixed(200)
                                },
                            }),
                                .backgroundColor = { 40, 40, 40, 255 },
                                .cornerRadius = clay::cornerRadiusUni(8)
                            }
                        ) {
                            // Render dropdown items here
                            renderDropdownMenuItem("New");
                            renderDropdownMenuItem("Open");
                            renderDropdownMenuItem("Close");
                        };
                    };
                }
            };
            renderHeaderButton("Edit");
            @clay({
                .layout =   clay::layout({ .sizing = { .width = clay::sizingGrow() }})
            }) {};
            renderHeaderButton("Upload");
            renderHeaderButton("Media");
            renderHeaderButton("Support");
        };
        @clay({
            .id = clay::id("LowerContent"),
            .layout = clay::layout({ .sizing = layoutExpand, .childGap = 16 })
            }
        ) {
            @clay({
                .id = clay::id("Sidebar"),
                .backgroundColor={ 90, 90, 90, 255 },
                // .cornerRadius= clay::@cornerRadiusUniCT(8),
                .layout = clay::layout({
                    .layoutDirection = LayoutDirection.TOP_TO_BOTTOM,
                    .padding = clay::paddingAll(16),
                    .childGap = 8,
                    .sizing = {
                        .width = clay::sizingFixed(250),
                        .height = clay::sizingGrow()
                    },
                })
                }
            ) {
                for (int i = 0; i < documents.len; i++) {
                    Document* document = &documents[i];
                    LayoutConfig sidebarButtonLayout = {
                        .sizing = { .width = clay::sizingGrow() },
                        .padding = clay::paddingAll(16)
                    };
                    if (i == data.selectedDocumentIndex) {
                        @clay({
                                .layout = clay::layout(sidebarButtonLayout),
                                .backgroundColor = { 120, 120, 120, 255 },
                                .cornerRadius = clay::cornerRadiusUni(8),
                            }
                        ) {
                            clay::text(document.title, clay::textConfig({
                                .fontId = FONT_ID_BODY_16,
                                .fontSize = 20,
                                .textColor = { 255, 255, 255, 255 },
                            }));
                        };
                    } else {
                        SidebarClickData *clickData =  (SidebarClickData*)  data.arena.memory +  data.arena.offset;
                        *clickData = {
                            .requestedDocumentIndex = i,
                            .selectedDocumentIndex = &data.selectedDocumentIndex
                        };
                        data.arena.offset += SidebarClickData.sizeof;
                        // clay::hovered(), 
                        @clay( {
                                .layout =  sidebarButtonLayout,
                                .backgroundColor = { 120, 120, 120, clay::hovered() ? 120 : 0 },
                                .cornerRadius = clay::cornerRadiusUni(8)
                            }) {
                            clay::onHover(&handleSidebarInteraction, (iptr) clickData);
                            clay::text(document.title, clay::textConfig({
                                .textColor = { 255, 255, 255, 255 },
                                .fontId = FONT_ID_BODY_16,
                                .fontSize = 20,
                            }));
                        };
                    }
                }
            };
            @clay({
                .id = clay::id("MainContent"),
                .backgroundColor = {90,90,90,255},
                .cornerRadius = clay::@cornerRadiusUniCT(8),
                .clip = { .vertical = true, .childOffset = clay::getScrollOffset() },
                .layout =  clay::layout({
                    .layoutDirection = LayoutDirection.TOP_TO_BOTTOM,
                    .childGap = 14,
                    .padding = clay::paddingUni(16),
                    .sizing = layoutExpand,
                }),
                }
            ) {
                Document document = documents[data.selectedDocumentIndex];
                clay::text(document.title, clay::textConfig({
                    .fontId = FONT_ID_BODY_16,
                    .fontSize = 24,
                    .textColor = {255, 255, 255, 255},
                }));
                clay::text(document.contents, clay::textConfig({
                    .fontId = FONT_ID_BODY_16,
                    .fontSize = 24,
                    .textColor = {255, 255, 255, 255},
                }));
            };
        };
    };

    //END OF STUFF TO RENDER

    RenderCommandArray renderCommands = clay::endLayout();
    for (int i = 0; i < renderCommands.length; i++) {
        renderCommands.get(i).boundingBox.y += data.yOffset;
    }
    return renderCommands;
}

fn void main() @public
{    
    renderer::raylibInitialize(
        1024, 768, "Introducing Clay C3-Demo",
        (uint) (rl::FLAG_VSYNC_HINT | rl::FLAG_WINDOW_RESIZABLE | rl::FLAG_WINDOW_HIGHDPI | rl::FLAG_MSAA_4X_HINT)
    );
    defer renderer::raylibClose();

    uint clayRequiredMemory = clay::minMemorySize();
    Arena clayMemory = clay::createArenaWithCapacityAndMemory(clayRequiredMemory, malloc(clayRequiredMemory));
    clay::initialize(clayMemory, { rl::getScreenWidth(), rl::getScreenHeight() }, { &errorHandler, null });
    
    clay::renderer::raylibFonts[FONT_ID_BODY_16] = { 
        FONT_ID_BODY_16, 
        rl::loadFontEx("resources/Lexend-Regular.ttf", 48, null, 400)
    };
    rl::setTextureFilter(
        clay::renderer::raylibFonts[FONT_ID_BODY_16].font.texture, 
        TextureFilter.BILINEAR
    );
    clay::setMeasureTextFunction(&clay::renderer::raylibMeasureText, null);

    VideoDemoData demo = *(VideoDemoData){}.init();

    while (!rl::windowShouldClose()) {
        clay::setLayoutDimensions({rl::getScreenWidth(), rl::getScreenHeight()});

        Vector2 mouse_position = rl::getMousePosition();
        Vector2 scroll_delta = rl::getMouseWheelMoveV();

        clay::setPointerState({mouse_position.x, mouse_position.y}, rl::isMouseButtonDown(MouseButton.LEFT));
        clay::updateScrollContainers(true, {scroll_delta.x, scroll_delta.y}, rl::getFrameTime());

        if (rl::isKeyReleased(rl::KEY_D)) { isDebugModeEnabled = !isDebugModeEnabled; clay::setDebugModeEnabled(isDebugModeEnabled); }

        RenderCommandArray cmds = demo.createLayout();
        rl::beginDrawing();
        rl::clearBackground(rl::BLACK);
        renderer::raylibRender(cmds);
        rl::endDrawing();

    }

}