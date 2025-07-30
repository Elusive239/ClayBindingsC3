module clay;

import clay::carray;

///this is very very bad never do this but im tired boss
fn void ___chkstk_ms (long size) @export("___chkstk_ms") @if(env::WIN32 && !$defined(___chkstk_ms)) {   }

//clay public api macros

macro max(x, y) => (((x) > (y)) ? (x) : (y));
macro min(x, y) => (((x) < (y)) ? (x) : (y));

// macro TextElementConfig textConfig(...) { 
//   return {$vasplat};
// }

macro borderOutside(widthValue) => {widthValue, widthValue, widthValue, widthValue, 0};

macro borderAll(widthValue) => {widthValue, widthValue, widthValue, widthValue, 0};

macro CornerRadius cornerRadius(radius) => {radius, radius, radius, radius};

macro Padding paddingAll(padding) => {padding, padding, padding, padding};

macro SizingAxis sizingFit(...) {
  return { .size = { .minMax = { $vasplat } }, .type = SizingType.FIT };
}

macro SizingAxis sizingGrow(...) {
  return { .size = { .minMax = { $vasplat } }, .type = SizingType.GROW };
}

macro SizingAxis sizingFixed(fixedSize) {
  return { .size = { .minMax = { fixedSize, fixedSize} }, .type = SizingType.FIXED };
}

macro SizingAxis sizingPercent(percentOfParent) {
  return { .size = { .percent = percentOfParent }, .type = SizingType.FIXED };
}

// Note: If a compile error led you here, you might be trying to use CLAY_ID with something other than a string literal. To construct an ID with a dynamic string, use CLAY_SID instead.
macro id(String label) => clay::sid(clay::string(label));
macro sid(ClayString label) => clay::hashString(label, 0);

// Note: If a compile error led you here, you might be trying to use CLAY_IDI with something other than a string literal. To construct an ID with a dynamic string, use CLAY_SIDI instead.
macro idi(String label, index) => clay::sidi(clay::string(label), index);
macro sidi(ClayString label, index) => clay::hashStringWithOffset(label, index, 0);

// Note: If a compile error led you here, you might be trying to use CLAY_ID_LOCAL with something other than a string literal. To construct an ID with a dynamic string, use CLAY_SID_LOCAL instead.
macro idLocal(String label) => clay::sidLocal(clay::string(label));
macro sidLocal(ClayString label, index) => clay::hashString(label, getParentElementId());

// Note: If a compile error led you here, you might be trying to use CLAY_ID_LOCAL with something other than a string literal. To construct an ID with a dynamic string, use CLAY_SID_LOCAL instead.
macro idiLocal(String label, index) => clay::sidiLocal(clay::string(label), index);
macro sidiLocal(ClayString label, index) => clay::hashStringWithOffset(label, index, getParentElementId());


// #define CLAY__STRING_LENGTH(s) ((sizeof(s) / sizeof((s)[0])) - sizeof((s)[0]))

// #define CLAY__ENSURE_STRING_LITERAL(x) ("" x "")

// BELOW COMMENT IS NOT ACCURATE WITH C3!
// Note: If an error led you here, it's because CLAY_STRING can only be used with string literals, i.e. CLAY_STRING("SomeString") and not CLAY_STRING(yourString)

macro ClayString string(string) {
  return {
    .isStaticallyAllocated = true,
    .length = string.len,
    .chars = (ZString) string.ptr
  };
}

// #define CLAY_STRING_CONST(string) { .isStaticallyAllocated = true, .length = CLAY__STRING_LENGTH(CLAY__ENSURE_STRING_LITERAL(string)), .chars = (string) }

// macro void @clay(...; @body()) @builtin { 
//   clay::openElement();
//   configureOpenElement( (ElementDeclaration) {$vasplat});
//   @body();
//   clay::closeElement();
// }

macro void @clay(ElementDeclaration decl; @body()) @builtin { 
  clay::openElement();
  configureOpenElement( decl);
  @body();
  clay::closeElement();
}

//ClayString text, TextElementConfig *textConfig
macro void text( text, TextElementConfig* textConfig) {
  clay::openTextElement(clay::string(text), textConfig);
}

// alias IfConditionFn = fn void();

macro void @bodyIf(bool #condition, ElementDeclaration ifRes; @body()) { 
  if (#condition) @clay(ifRes){
    @body();
  }; 
}

// macro @bodyIfElse(#condition, #ifRes, #elseRes) { if (#condition) { #ifRes; } else { #elseRes; } }

macro ElementDeclaration @bodyIfElse(bool #condition, ElementDeclaration ifRes, ifFunc, ElementDeclaration elseIfRes, elseFunc) { 
  if (#condition) {@clay(ifRes){
    ifFunc();
  }; }else {@clay(elseIfRes){
    elseFunc();
  };}
}

// macro rectangle(RectangleElementConfig config) { clay::attachElementConfig({ .rectangleElementConfig = clay::storeRectangleElementConfig(config) }, clay::ELEMENT_CONFIG_TYPE_RECTANGLE ); }

macro layout(LayoutConfig config) { 
  return *clay::storeLayoutConfig(config) ;
}

// macro scroll(ScrollElementConfig config) { clay::attachElementConfig({ .scrollElementConfig = clay::storeScrollElementConfig(config) }, clay::ELEMENT_CONFIG_TYPE_SCROLL_CONTAINER ); }

macro floating(FloatingElementConfig config) { clay::attachElementConfig({ .floatingElementConfig = clay::storeFloatingElementConfig(config) }, clay::ELEMENT_CONFIG_TYPE_FLOATING_CONTAINER ); }

macro borderRadiusUni(uint width, ClayColor color, float cornerRadius = 0) { clay::attachElementConfig({ .borderElementConfig = clay::storeBorderElementConfig({ .left = { width, color }, .right = { width, color }, .top = { width, color }, .bottom = { width, color }, .cornerRadius = {cornerRadius, cornerRadius, cornerRadius, cornerRadius}})}, clay::ELEMENT_CONFIG_TYPE_BORDER_CONTAINER); }

macro TextElementConfig* textConfig(TextElementConfig config) { return clay::storeTextElementConfig(config); }

macro Padding paddingUni(ushort uniform) { return {uniform, uniform, uniform, uniform}; }

macro Padding padding(ushort horizontal, ushort vertical) { return {horizontal, horizontal, vertical, vertical}; }

macro CornerRadius cornerRadiusUni(float uniform) { return {uniform, uniform, uniform, uniform}; }

macro SizingAxis sizingFitCT(float $min = 0, float $max = float.max) { return { .size.minMax = {$min, $max}, .type = SizingType.FIT }; }

macro SizingAxis sizingFixedCT(float $pixels) { return { .size.minMax = {$pixels, $pixels}, .type = SizingType.FIXED }; }

macro SizingAxis sizingPercentCT(float $percent) { return { .size.percent = $percent, .type = SizingType.PERCENT }; }

macro Padding paddingCT(ushort $a, ushort $b, ushort $c, ushort $d) { return { $a, $b, $c, $d }; }

macro CornerRadius @cornerRadiusUniCT(float #uniform) { return {#uniform, #uniform, #uniform, #uniform}; }


//Clay Types

// Function pointer aliases
alias ErrorHandleFunc = fn void(ErrorData errorText);
alias OnHoverEvent = fn void(ElementId elementId, PointerData pointerData, iptr userData);
alias MeasureTextFunc = fn Dimensions( ClayStringSlice text, TextElementConfig *config, void *userData);
alias QueryScrollOffsetFunc = fn ClayVector2(CUInt elementId, void *userData);

//  String
struct ClayString {
  bool isStaticallyAllocated;
  CInt length;
  ZString chars;
}

//  StringSlice
struct ClayStringSlice {
  CInt length;
  char *chars;
  char *baseChars;
}

//  Arena
struct Arena {
  uptr nextAllocation;
  usz capacity;
  char *memory;
}

//  Dimensions
struct Dimensions {
  float width, height;
}

//  ClayVector2
struct ClayVector2 {
  float x, y;
}

//  Color
struct ClayColor {
  float r, g, b, a;
}

//  ClayBoundingBox
struct ClayBoundingBox {
  float x, y, width, height;
}

//  ElementId
struct ElementId {
  CUInt id;
  CUInt offset;
  CUInt baseId;
  ClayString stringId;
}

//  CornerRadius
struct CornerRadius  {
  float topLeft;
  float topRight;
  float bottomLeft;
  float bottomRight;
} 

//  LayoutDirection
enum LayoutDirection: char @export {
    LEFT_TO_RIGHT,
    TOP_TO_BOTTOM,
}  

//  LayoutAlignmentX
enum LayoutAlignmentX: char @export{
    LEFT,
    RIGHT,
    CENTER,
} 

//  LayoutAlignmentY
enum LayoutAlignmentY: char @export{
    TOP,
    BOTTOM,
    CENTER,
} 

// SizingType
enum SizingType: char @export{
    FIT,
    GROW,
    PERCENT,
    FIXED,
}

//  ChildAlignment
struct  ChildAlignment {
  LayoutAlignmentX x;
  LayoutAlignmentY y;
}

//  SizingMinMax
struct SizingMinMax {
  float min;
  float max;
}

//  SizingAxis
struct SizingAxis {
  union size {
    SizingMinMax minMax;
    float percent;
  } SizingType type;
}

//  Sizing
struct Sizing {
  SizingAxis width;
  SizingAxis height;
}

//  Padding
struct Padding {
  ushort left;
  ushort right;
  ushort top;
  ushort bottom;
}

//  LayoutConfig
struct LayoutConfig {
  Sizing sizing;
  Padding padding;
  ushort childGap;
  ChildAlignment childAlignment;
  LayoutDirection layoutDirection;
}

//  TextElementConfigWrapMode
enum TextElementConfigWrapMode: char @export{
    TEXT_WRAP_WORDS,
    TEXT_WRAP_NEWLINES,
    TEXT_WRAP_NONE,
} 

//  TextAlignment
enum TextAlignment: char @export{
    TEXT_ALIGN_LEFT,
    TEXT_ALIGN_CENTER,
    TEXT_ALIGN_RIGHT,
} 

//  TextElementConfig
struct  TextElementConfig  {
  void *userData;
  ClayColor textColor;
  ushort fontId;
  ushort fontSize;
  ushort letterSpacing;
  ushort lineHeight;
  TextElementConfigWrapMode wrapMode;
  TextAlignment textAlignment;
}
// fn usz? TextElementConfig.to_format(&self, Formatter* f) @dynamic
// => io::struct_to_format(*self, f, false);


//  AspectRatioElementConfig
struct AspectRatioElementConfig {
  float aspectRatio;
}

//  ImageElementConfig
struct ImageElementConfig {
  void *imageData;
}


//  FloatingAttachPointType
enum FloatingAttachPointType: char @export{
    LEFT_TOP,
    LEFT_CENTER,
    LEFT_BOTTOM,
    CENTER_TOP,
    CENTER_CENTER,
    CENTER_BOTTOM,
    RIGHT_TOP,
    RIGHT_CENTER,
    RIGHT_BOTTOM,
}

//  FloatingAttachPoints
struct  FloatingAttachPoints {
  FloatingAttachPointType element;
  FloatingAttachPointType parent;
}   

//  PointerCaptureMode
enum PointerCaptureMode: char @export{
    CAPTURE,
    PASSTHROUGH,
} 

//  FloatingAttachToElement
enum FloatingAttachToElement: char @export{
    NONE,
    PARENT,
    ELEMENT_WITH_ID,
    ROOT,
}  

//  FloatingClipToElement
enum FloatingClipToElement: char @export{
    NONE,
    ATTACHED_PARENT
} 

//  FloatingElementConfig
struct  FloatingElementConfig {
  ClayVector2 offset;
  Dimensions expand;
  CUInt parentId;
  short zIndex;
  FloatingAttachPoints attachPoints;
  PointerCaptureMode pointerCaptureMode;
  FloatingAttachToElement attachTo;
  FloatingClipToElement clipTo;
}

//  CustomElementConfig
struct CustomElementConfig {
  void *customData;
}

//  ClipElementConfig
struct ClipElementConfig {
  bool horizontal;
  bool vertical;
  ClayVector2 childOffset;
}


//  BorderWidth
struct BorderWidth {
  ushort left;
  ushort right;
  ushort top;
  ushort bottom;
  ushort betweenChildren;
}

//  BorderElementConfig
struct BorderElementConfig {
  ClayColor color;
  BorderWidth width;
}

//  TextRenderData
struct TextRenderData {
  ClayStringSlice stringContents;
  ClayColor textColor;
  ushort fontId;
  ushort fontSize;
  ushort letterSpacing;
  ushort lineHeight;
}

//  RectangleRenderData
struct RectangleRenderData {
  ClayColor backgroundColor;
  CornerRadius cornerRadius;
}

//  ImageRenderData
struct ImageRenderData {
  ClayColor backgroundColor;
  CornerRadius cornerRadius;
  void *imageData;
}

//  CustomRenderData
struct CustomRenderData {
  ClayColor backgroundColor;
  CornerRadius cornerRadius;
  void *customData;
}

//  ClipRenderData
struct ClipRenderData {
  bool horizontal;
  bool vertical;
}

//  BorderRenderData
struct BorderRenderData {
  ClayColor color;
  CornerRadius cornerRadius;
  BorderWidth width;
}

//  RenderData (union)
union RenderData {
  RectangleRenderData rectangle;
  TextRenderData text;
  ImageRenderData image;
  CustomRenderData custom;
  BorderRenderData border;
  ClipRenderData clip;
}

//  ScrollContainerData
struct ScrollContainerData {
  ClayVector2 *scrollPosition;
  Dimensions scrollContainerDimensions;
  Dimensions contentDimensions;
  ClipElementConfig config;
  bool found;
}

//  ElementData
struct ElementData {
  ClayBoundingBox boundingBox;
  bool found;
}

//  RenderCommandType
enum RenderCommandType : char @export{
    NONE,
    RECTANGLE,
    BORDER,
    TEXT,
    IMAGE,
    SCISSOR_START,
    SCISSOR_END,
    CUSTOM,
}

//  RenderCommand
struct  RenderCommand {
  ClayBoundingBox boundingBox;
  RenderData renderData;
  void *userData;
  CUInt id;
  short zIndex;
  RenderCommandType commandType;
}

//  PointerState
enum PointerState: char @export{
    PRESSED_THIS_FRAME,
    PRESSED,
    RELEASED_THIS_FRAME,
    RELEASED,
} 

//  PointerData
struct  PointerData {
  ClayVector2 position;
  PointerState state;
}

//  ElementDeclaration
struct ElementDeclaration {
  ElementId id;
  LayoutConfig layout;
  ClayColor backgroundColor;
  CornerRadius cornerRadius;
  AspectRatioElementConfig aspectRatio;
  ImageElementConfig image;
  FloatingElementConfig floating;
  CustomElementConfig custom;
  ClipElementConfig clip;
  BorderElementConfig border;
  void *userData;
}


//  ErrorType
enum ErrorType : char @export{
    TEXT_MEASUREMENT_FUNCTION_NOT_PROVIDED,
    ARENA_CAPACITY_EXCEEDED,
    ELEMENTS_CAPACITY_EXCEEDED,
    TEXT_MEASUREMENT_CAPACITY_EXCEEDED,
    DUPLICATE_ID,
    FLOATING_CONTAINER_PARENT_NOT_FOUND,
    PERCENTAGE_OVER_1,
    INTERNAL_ERROR,
} 

//  ErrorData
struct  ErrorData {
  ErrorType errorType;
  ClayString errorText;
  void *userData;
}

//  ErrorHandler
struct ErrorHandler {
  ErrorHandleFunc errorHandlerFunction;
  // void (*errorHandlerFunction)(Clay_ErrorData errorText);
  void *userData;
}

// Many array types are generated by macros, e.g.:

// ...and so on for each type used in arrays

// Warning
struct Warning {
  String baseMessage;
  String dynamicMessage;
}

//  SharedElementConfig
struct SharedElementConfig {
  ClayColor backgroundColor;
  CornerRadius cornerRadius;
  void *userData;
}

// ElementConfigType
enum ElementConfigType : char @export{
    NONE,
    BORDER,
    FLOATING,
    CLIP,
    ASPECT,
    IMAGE,
    TEXT,
    CUSTOM,
    SHARED,
} 

//  ElementConfigUnion (union of pointers)
union ElementConfigUnion{
  TextElementConfig *textElementConfig;
  AspectRatioElementConfig *aspectRatioElementConfig;
  ImageElementConfig *imageElementConfig;
  FloatingElementConfig *floatingElementConfig;
  CustomElementConfig *customElementConfig;
  ClipElementConfig *clipElementConfig;
  BorderElementConfig *borderElementConfig;
  SharedElementConfig *sharedElementConfig;
}

//  ElementConfig
struct ElementConfig {
  ElementConfigType type;
  ElementConfigUnion config;
}

// Many more array types for each struct above, e.g.:
// struct ElementConfigArray{ CInt capacity; CInt length;  ElementConfig
// *internalArray; } ;

// WrappedTextLine
struct WrappedTextLine {
  Dimensions dimensions;
  ClayString line;
}

// TextElementData
struct TextElementData {
  ClayString text;
  Dimensions preferredDimensions;
  CInt elementIndex;
  WrappedTextLineArraySlice wrappedLines;
}

alias WrappedTextLineArraySlice = carray::Slice{WrappedTextLineArray};
alias ElementConfigArraySlice = carray::Slice{ElementConfigArray};

// LayoutElementChildren
struct LayoutElementChildren {
  CInt *elements;
  ushort length;
}

//  LayoutElement
struct LayoutElement {
  union childrenOrTextContent {
    LayoutElementChildren children;
    TextElementData *textElementData;
  } Dimensions dimensions;
  Dimensions minDimensions;
  LayoutConfig *layoutConfig;
  ElementConfigArraySlice elementConfigs;
  CUInt id;
}

// ScrollContainerDataInternal
struct ScrollContainerDataInternal {
  LayoutElement *layoutElement;
  ClayBoundingBox boundingBox;
  Dimensions contentSize;
  ClayVector2 scrollOrigin;
  ClayVector2 pointerOrigin;
  ClayVector2 scrollMomentum;
  ClayVector2 scrollPosition;
  ClayVector2 previousDelta;
  float momentumTime;
  CUInt elementId;
  bool openThisFrame;
  bool pointerScrollActive;
}

// DebugElementData
struct DebugElementData {
  bool collision;
  bool collapsed;
}

//  LayoutElementHashMapItem
struct LayoutElementHashMapItem {
    ClayBoundingBox boundingBox;
    ElementId elementId;
    LayoutElement* layoutElement;
    OnHoverEvent onHoverFunction;
    iptr hoverFunctionUserData;
    CInt nextIndex;
    CUInt generation;
    CUInt idAlias;
    DebugElementData *debugData;
}

// MeasuredWord
struct MeasuredWord {
  CInt startOffset;
  CInt length;
  float width;
  CInt next;
}

// MeasureTextCacheItem
struct MeasureTextCacheItem {
  Dimensions unwrappedDimensions;
  CInt measuredWordsStartIndex;
  float minWidth;
  bool containsNewlines;
  CUInt id;
  CInt nextIndex;
  CUInt generation;
}

// LayoutElementTreeNode
struct LayoutElementTreeNode {
  LayoutElement *layoutElement;
  ClayVector2 position;
  ClayVector2 nextChildOffset;
}

// LayoutElementTreeRoot
struct LayoutElementTreeRoot {
  CInt layoutElementIndex;
  CUInt parentId;
  CUInt clipElementId;
  short zIndex;
  ClayVector2 pointerOffset;
}

//  Context (full definition)
struct Context {
  CInt maxElementCount;
  CInt maxMeasureTextCacheWordCount;
  bool warningsEnabled;
  ErrorHandler errorHandler;
  BooleanWarnings booleanWarnings;
  WarningArray warnings;

  PointerData pointerInfo;
  Dimensions layoutDimensions;
  ElementId dynamicElementIndexBaseHash;
  CUInt dynamicElementIndex;
  bool debugModeEnabled;
  bool disableCulling;
  bool externalScrollHandlingEnabled;
  CUInt debugSelectedElementId;
  CUInt generation;
  uptr arenaResetOffset;
  void *measureTextUserData;
  void *queryScrollOffsetUserData;
  Arena internalArena;
  // Layout Elements / Render Commands
  LayoutElementArray layoutElements;
  RenderCommandArray renderCommands;
  Int32Array openLayoutElementStack;
  Int32Array layoutElementChildren;
  Int32Array layoutElementChildrenBuffer;
  TextElementDataArray textElementData;
  Int32Array aspectRatioElementIndexes;
  Int32Array reusableElementIndexBuffer;
  Int32Array layoutElementClipElementIds;
  // Configs
  LayoutConfigArray layoutConfigs;
  ElementConfigArray elementConfigs;
  TextElementConfigArray textElementConfigs;
  AspectRatioElementConfigArray aspectRatioElementConfigs;
  ImageElementConfigArray imageElementConfigs;
  FloatingElementConfigArray floatingElementConfigs;
  ClipElementConfigArray clipElementConfigs;
  CustomElementConfigArray customElementConfigs;
  BorderElementConfigArray borderElementConfigs;
  SharedElementConfigArray sharedElementConfigs;
  // Misc Data Structures
  StringArray layoutElementIdStrings;
  WrappedTextLineArray wrappedTextLines;
  LayoutElementTreeNodeArray layoutElementTreeNodeArray1;
  LayoutElementTreeRootArray layoutElementTreeRoots;
  LayoutElementHashMapItemArray layoutElementsHashMapInternal;
  Int32Array layoutElementsHashMap;
  MeasureTextCacheItemArray measureTextHashMapInternal;
  Int32Array measureTextHashMapInternalFreeList;
  Int32Array measureTextHashMap;
  MeasuredWordArray measuredWords;
  Int32Array measuredWordsFreeList;
  Int32Array openClipElementStack;
  ElementIdArray pointerOverIds;
  ScrollContainerDataInternalArray scrollContainerDatas;
  BoolArray treeNodeVisited;
  CharArray dynamicStringData;
  DebugElementDataArray debugElementData;
}

struct RenderDebugLayoutData {
    CInt rowCount;
    CInt selectedElementRowIndex;
}

struct DebugElementConfigTypeLabelConfig {
    ClayString label;
    ClayColor color;
}

struct BooleanWarnings {
    bool maxElementsExceeded;
    bool maxRenderCommandsExceeded;
    bool maxTextMeasureCacheExceeded;
    bool textMeasurementFunctionNotSet;
}

alias ElementIdArray = carray::Array{ElementId};
alias RenderCommandArray = carray::Array{RenderCommand};
alias WarningArray = carray::Array{Warning};
alias ElementConfigArray = carray::Array{ElementConfig};
alias TextElementDataArray = carray::Array{TextElementData};
alias LayoutElementArray = carray::Array{LayoutElement};
alias LayoutConfigArray = carray::Array{LayoutConfig};
alias TextElementConfigArray = carray::Array{TextElementConfig};
alias AspectRatioElementConfigArray = carray::Array{AspectRatioElementConfig};
alias ImageElementConfigArray = carray::Array{ImageElementConfig};
alias FloatingElementConfigArray = carray::Array{FloatingElementConfig};
alias ClipElementConfigArray = carray::Array{ClipElementConfig};
alias CustomElementConfigArray = carray::Array{CustomElementConfig};
alias BorderElementConfigArray = carray::Array{BorderElementConfig};
alias SharedElementConfigArray = carray::Array{SharedElementConfig};
alias StringArray = carray::Array{ClayString};
alias WrappedTextLineArray = carray::Array{WrappedTextLine};
alias LayoutElementTreeNodeArray = carray::Array{LayoutElementTreeNode};
alias LayoutElementTreeRootArray = carray::Array{LayoutElementTreeRoot};
alias LayoutElementHashMapItemArray = carray::Array{LayoutElementHashMapItem};
alias MeasureTextCacheItemArray = carray::Array{MeasureTextCacheItem};
alias MeasuredWordArray = carray::Array{MeasuredWord};
alias ScrollContainerDataInternalArray = carray::Array{ScrollContainerDataInternal};
alias DebugElementDataArray = carray::Array{DebugElementData};
alias BoolArray = carray::Array{bool};
alias CharArray = carray::Array{char};
alias Int32Array = carray::Array{CInt};
alias UInt32Array = carray::Array{CUInt};
alias UptrArray = carray::Array{uptr};

// ===== Clay API Functions (w/ String replacement) =====
extern fn CUInt minMemorySize() @extern("Clay_MinMemorySize");
extern fn Arena createArenaWithCapacityAndMemory(usz capacity, void *memory) @extern("Clay_CreateArenaWithCapacityAndMemory");
extern fn void setPointerState(ClayVector2 position, bool pointerDown) @extern("Clay_SetPointerState");
extern fn Context* initialize(Arena arena, Dimensions layoutDimensions, ErrorHandler errorHandler) @extern("Clay_Initialize");
extern fn Context* getCurrentContext() @extern("Clay_GetCurrentContext");
extern fn void setCurrentContext(Context* context) @extern("Clay_SetCurrentContext");
extern fn void updateScrollContainers(bool enableDragScrolling, ClayVector2 scrollDelta, float deltaTime) @extern("Clay_UpdateScrollContainers");
extern fn ClayVector2 getScrollOffset() @extern("Clay_GetScrollOffset");
extern fn void setLayoutDimensions(Dimensions dimensions) @extern("Clay_SetLayoutDimensions");
extern fn void beginLayout() @extern("Clay_BeginLayout");
extern fn RenderCommandArray endLayout() @extern("Clay_EndLayout");

fn ElementId getElementId(String idString) {
    return _getElementId({false, idString.len, (ZString) idString.ptr});
}
extern fn ElementId _getElementId(ClayString idString) @extern("Clay_GetElementId");

fn ElementId getElementIdWithIndex(String idString, CUInt index) {
    return _getElementIdWithIndex({false, idString.len,(ZString) idString.ptr}, index);
}
extern fn ElementId _getElementIdWithIndex(ClayString idString, CUInt index) @extern("Clay_GetElementIdWithIndex");

extern fn ElementData getElementData(ElementId id) @extern("Clay_GetElementData");
extern fn bool hovered() @extern("Clay_Hovered");
extern fn void onHover(OnHoverEvent func, iptr userData) @extern("Clay_OnHover");
extern fn bool pointerOver(ElementId elementId) @extern("Clay_PointerOver");
extern fn ElementIdArray getPointerOverIds() @extern("Clay_GetPointerOverIds");
extern fn ScrollContainerData getScrollContainerData(ElementId id) @extern("Clay_GetScrollContainerData");
extern fn void setMeasureTextFunction(MeasureTextFunc func, void *userData) @extern("Clay_SetMeasureTextFunction");
extern fn void setQueryScrollOffsetFunction(QueryScrollOffsetFunc func, void *userData) @extern("Clay_SetQueryScrollOffsetFunction");
extern fn RenderCommand* RenderCommandArray.get(RenderCommandArray* array, CInt index) @extern("Clay_RenderCommandArray_Get");
extern fn void setDebugModeEnabled(bool enabled) @extern("Clay_SetDebugModeEnabled");
extern fn bool isDebugModeEnabled() @extern("Clay_IsDebugModeEnabled");
extern fn void setCullingEnabled(bool enabled) @extern("Clay_SetCullingEnabled");
extern fn CInt getMaxElementCount() @extern("Clay_GetMaxElementCount");
extern fn void setMaxElementCount(CInt maxElementCount) @extern("Clay_SetMaxElementCount");
extern fn CInt getMaxMeasureTextCacheWordCount() @extern("Clay_GetMaxMeasureTextCacheWordCount");
extern fn void setMaxMeasureTextCacheWordCount(CInt maxMeasureTextCacheWordCount) @extern("Clay_SetMaxMeasureTextCacheWordCount");
extern fn void resetMeasureTextCache() @extern("Clay_ResetMeasureTextCache");

// ===== Internal Clay API Functions =====
extern fn void openElement() @extern("Clay__OpenElement");
extern fn void configureOpenElement(ElementDeclaration config) @extern("Clay__ConfigureOpenElement");
extern fn void configureOpenElementPtr(ElementDeclaration *config) @extern("Clay__ConfigureOpenElementPtr");
extern fn void closeElement() @extern("Clay__CloseElement");
extern fn ElementId hashString(ClayString key, CUInt seed) @extern("Clay__HashString");
extern fn ElementId hashStringWithOffset(ClayString key, CUInt offset, CUInt seed) @extern("Clay__HashStringWithOffset");
extern fn void openTextElement(ClayString text, TextElementConfig *textConfig) @extern("Clay__OpenTextElement");
extern fn TextElementConfig* storeTextElementConfig(TextElementConfig config) @extern("Clay__StoreTextElementConfig");
extern fn CUInt getParentElementId() @extern("Clay__GetParentElementId");
extern fn void suppressUnusedLatchDefinitionVariableWarning() @extern("Clay__SuppressUnusedLatchDefinitionVariableWarning");
extern fn WarningArray warningArray_Allocate_Arena(CInt capacity, Arena *arena) @extern("Clay__WarningArray_Allocate_Arena");
extern fn Warning* warningArray_Add(WarningArray *array, Warning item) @extern("Clay__WarningArray_Add");
extern fn void* array_Allocate_Arena(CInt capacity, CUInt itemSize, Arena *arena) @extern("Clay__Array_Allocate_Arena");
extern fn bool array_RangeCheck(CInt index, CInt length) @extern("Clay__Array_RangeCheck");
extern fn bool array_AddCapacityCheck(CInt length, CInt capacity) @extern("Clay__Array_AddCapacityCheck");
extern fn Context* context_Allocate_Arena(Arena *arena) @extern("Clay__Context_Allocate_Arena");
extern fn ClayString writeStringToCharBuffer(CharArray *buffer, ClayString string) @extern("Clay__WriteStringToCharBuffer");
extern fn LayoutElement* getOpenLayoutElement() @extern("Clay__GetOpenLayoutElement");
extern fn LayoutConfig* storeLayoutConfig(LayoutConfig config) @extern("Clay__StoreLayoutConfig");
extern fn AspectRatioElementConfig* storeAspectRatioElementConfig(AspectRatioElementConfig config) @extern("Clay__StoreAspectRatioElementConfig");
extern fn ImageElementConfig* storeImageElementConfig(ImageElementConfig config) @extern("Clay__StoreImageElementConfig");
extern fn FloatingElementConfig* storeFloatingElementConfig(FloatingElementConfig config) @extern("Clay__StoreFloatingElementConfig");
extern fn CustomElementConfig* storeCustomElementConfig(CustomElementConfig config) @extern("Clay__StoreCustomElementConfig");
extern fn ClipElementConfig* storeClipElementConfig(ClipElementConfig config) @extern("Clay__StoreClipElementConfig");
extern fn BorderElementConfig* storeBorderElementConfig(BorderElementConfig config) @extern("Clay__StoreBorderElementConfig");
extern fn SharedElementConfig* storeSharedElementConfig(SharedElementConfig config) @extern("Clay__StoreSharedElementConfig");
extern fn ElementConfig attachElementConfig(ElementConfigUnion config, ElementConfigType type) @extern("Clay__AttachElementConfig");
extern fn ElementConfigUnion findElementConfigWithType(LayoutElement *element, ElementConfigType type) @extern("Clay__FindElementConfigWithType");
extern fn ElementId hashNumber(CUInt offset, CUInt seed) @extern("Clay__HashNumber");
extern fn ulong hashData(char* data, usz length) @extern("Clay__HashData");
extern fn CUInt hashStringContentsWithConfig(ClayString *text, TextElementConfig *config) @extern("Clay__HashStringContentsWithConfig");
extern fn MeasuredWord* addMeasuredWord(MeasuredWord word, MeasuredWord *previousWord) @extern("Clay__AddMeasuredWord");
extern fn MeasureTextCacheItem* measureTextCached(ClayString *text, TextElementConfig *config) @extern("Clay__MeasureTextCached");
extern fn bool pointIsInsideRect(ClayVector2 point, ClayBoundingBox rect) @extern("Clay__PointIsInsideRect");
extern fn LayoutElementHashMapItem* addHashMapItem(ElementId elementId, LayoutElement* layoutElement, CUInt idAlias) @extern("Clay__AddHashMapItem");
extern fn LayoutElementHashMapItem* getHashMapItem(CUInt id) @extern("Clay__GetHashMapItem");
extern fn ElementId generateIdForAnonymousElement(LayoutElement *openLayoutElement) @extern("Clay__GenerateIdForAnonymousElement");
extern fn bool elementHasConfig(LayoutElement *layoutElement, ElementConfigType type) @extern("Clay__ElementHasConfig");
extern fn void updateAspectRatioBox(LayoutElement *layoutElement) @extern("Clay__UpdateAspectRatioBox");
extern fn bool memCmp(char *s1, char *s2, CInt length) @extern("Clay__MemCmp");
extern fn void initializeEphemeralMemory(Context* context) @extern("Clay__InitializeEphemeralMemory");
extern fn void initializePersistentMemory(Context* context) @extern("Clay__InitializePersistentMemory");
extern fn bool floatEqual(float left, float right) @extern("Clay__FloatEqual");
extern fn void sizeContainersAlongAxis(bool xAxis) @extern("Clay__SizeContainersAlongAxis");
extern fn ClayString intToString(CInt integer) @extern("Clay__IntToString");
extern fn void addRenderCommand(RenderCommand renderCommand) @extern("Clay__AddRenderCommand");
extern fn bool elementIsOffscreen(ClayBoundingBox *boundingBox) @extern("Clay__ElementIsOffscreen");
extern fn void calculateFinalLayout() @extern("Clay__CalculateFinalLayout");
extern fn DebugElementConfigTypeLabelConfig clay__DebugGetElementConfigTypeLabel(ElementConfigType type) @extern("Clay__DebugGetElementConfigTypeLabel");
extern fn RenderDebugLayoutData renderDebugLayoutElementsList(CInt initialRootsLength, CInt highlightedRowIndex) @extern("Clay__RenderDebugLayoutElementsList");
extern fn void renderDebugLayoutSizing(SizingAxis sizing, TextElementConfig *infoTextConfig) @extern("Clay__RenderDebugLayoutSizing");
extern fn void renderDebugViewElementConfigHeader(ClayString elementId, ElementConfigType type) @extern("Clay__RenderDebugViewElementConfigHeader");
extern fn void renderDebugViewColor(ClayColor color, TextElementConfig *textConfig) @extern("Clay__RenderDebugViewColor");
extern fn void renderDebugViewCornerRadius(CornerRadius cornerRadius, TextElementConfig *textConfig) @extern("Clay__RenderDebugViewCornerRadius");
extern fn void handleDebugViewCloseButtonInteraction(ElementId elementId, PointerData pointerInfo, iptr userData) @extern("HandleDebugViewCloseButtonInteraction");
extern fn void renderDebugView() @extern("Clay__RenderDebugView");

// ==========================================================================
// ===== An internal module for wrapping Struct Array's defined in Clay =====
// ==========================================================================
module clay::carray{ElementType};
import clay;
struct Array {
    int capacity;
    int length;
    ElementType *data;
}

struct Slice {
  CInt length;
  ElementType *internalArray;
}

fn ElementType* Slice.get(
    Slice* slice,
    int index
  ) {
    if(clay::array_RangeCheck(index, slice.length)) return &(slice.internalArray[index]) ;
    return {};
}


// TODO: extensions to clay.c since our clay::Context alignment appears to be off
// Clay_PointerData Clay__GetPointerData()
// {
//     return Clay_GetCurrentContext()->pointerInfo;
// }

// Clay_LayoutElementArray* Clay__GetLayoutElementArrayFromContext()
// {
//     return &Clay_GetCurrentContext()->layoutElements;
// }