local default_gui = data.raw["gui-style"].default

--
-- @see https://forums.factorio.com/viewtopic.php?f=28&t=24292
--

function sprite(filename, size, scale, shift, position)
  return {
    filename = filename,
    priority = "extra-high-no-scale",
    align = "center",
    width = size,
    height = size,
    scale = scale,
    shift = shift,
    x = position.x,
    y = position.y
  }
end

function spriteIcon(filename, size, scale, shift, position)
  return {
    type = "sprite",
    sprite = sprite(filename, size, scale, shift, position)
  }
end

function monolithIcon(filename, size, scale, shift, position, border, stretch)
  return {
    type = "monolith",
    top_monolith_border = border.top,
    right_monolith_border = border.right,
    bottom_monolith_border = border.bottom,
    left_monolith_border = border.left,
    monolith_image = sprite(filename, size, scale, shift, position),
    stretch_monolith_image_to_size = stretch
  }
end

function compositionIcon(filename, corner_size, position)
  return {
    type = "composition",
    filename = filename,
    priority = "extra-high-no-scale",
    corner_size = corner_size,
    position = position
  }
end

--
-- @see https://forums.factorio.com/viewtopic.php?f=28&t=24294
--
function layeredIcon (filename, size, scale, shift, position)
  return {
    type = "layered",
    layers = {
      { -- the border and background are a composition
        type = "composition",
        filename = "__core__/graphics/gui.png",
        corner_size = {3, 3},
        position = {0, 0}
      },
      {
        type = "monolith",
        monolith_image = sprite(filename, size, scale, shift, position)
      }
    }
  }
end

-------------------------------------------------------------------------------
-- Menu icon type
--
-- @function menuIconType
--
-- @param #string name
-- @param #number icon_row
-- @param #table icon_col
-- @param #string suffix
-- @param #string font
-- @param #table hovered_font_color
--
function menuIconType(name, icon_row, icon_col, suffix, font, hovered_font_color)
  local style_name = "helmod_button_icon_"..name
  if suffix ~= nil then style_name = style_name.."_"..suffix end
  default_gui[style_name] = {
    type = "button_style",
    parent = "helmod_button_default",
    width = 32,
    height = 32,
    scalable = false,
    default_graphical_set = monolithIcon("__helmod__/graphics/icons/menu_icons.png", 32, 1, {0,0}, {x=icon_col[1],y=(icon_row-1)*32}, {top=0,right=0,bottom=0,left=0}, true),
    hovered_graphical_set = monolithIcon("__helmod__/graphics/icons/menu_icons.png", 32, 1, {0,0}, {x=icon_col[2],y=(icon_row-1)*32}, {top=0,right=0,bottom=0,left=0}, true),
    hovered_font_color = hovered_font_color,
    clicked_graphical_set = monolithIcon("__helmod__/graphics/icons/menu_icons.png", 32, 1, {0,0}, {x=icon_col[3],y=(icon_row-1)*32}, {top=0,right=0,bottom=0,left=0}, true),
    disabled_graphical_set = monolithIcon("__helmod__/graphics/icons/menu_icons.png", 32, 1, {0,0}, {x=icon_col[4],y=(icon_row-1)*32}, {top=0,right=0,bottom=0,left=0}, true)
  }
  if font ~= nil then
    default_gui[style_name].font = font
  end
end

-------------------------------------------------------------------------------
-- Menu icons
--
-- @function menuIcons
--
-- @param #string name
-- @param #number icon_row
-- @param #string font
--
function menuIcons(name, icon_row, font)
  menuIconType(name, icon_row, {0,32,0,0}, nil, font, {r=0, g=0, b=0})
  menuIconType(name, icon_row, {0,64,0,0}, "red", font, {r=0, g=0, b=0})
  menuIconType(name, icon_row, {96,96,96,96}, "selected", font, {r=1, g=1, b=1})
  menuIconType(name, icon_row, {128,128,128,128}, "selected_yellow", font, {r=0, g=0, b=0})
  menuIconType(name, icon_row, {160,160,160,160}, "selected_red", font, {r=0, g=0, b=0})
end

-------------------------------------------------------------------------------
-- Style Textfield
--
-- @type Textfield
--

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Textfield] default
default_gui["helmod_textfield"] = {
  type = "textfield_style",
  parent = "textfield_style",
  minimal_width = 70,
  maximal_width = 70
}

-------------------------------------------------------------------------------
-- Style Textbox
--
-- @type Textbox
--

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Textbox] default
default_gui["helmod_textbox_default"] = {
  type = "textbox_style",
  parent = "textbox_style",
  minimal_width = 300,
  maximal_width = 300,
  minimal_height = 300,
  maximal_height = 200
}


-------------------------------------------------------------------------------
-- Style Button
--
-- @type Button
--

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Button] default

local corner_size = {3, 3}
default_gui["helmod_button_default"] = {
  type = "button_style",
  font = "helmod_font_normal",
  default_font_color={r=1, g=1, b=1},
  align = "center",
  top_padding = 2,
  right_padding = 2,
  bottom_padding = 2,
  left_padding = 2,
  height = 28,
  default_graphical_set = compositionIcon("__core__/graphics/gui.png", corner_size, {0, 0}),
  hovered_font_color={r=0, g=0, b=0},
  hovered_graphical_set = compositionIcon("__core__/graphics/gui.png", corner_size, {0, 8}),
  clicked_font_color={r=1, g=1, b=1},
  clicked_graphical_set = compositionIcon("__core__/graphics/gui.png", corner_size, {0, 40}),
  disabled_font_color={r=0.5, g=0.5, b=0.5},
  disabled_graphical_set = compositionIcon("__core__/graphics/gui.png", corner_size, {0, 16}),
  pie_progress_color = {r=1, g=1, b=1}
}

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Button] selected

default_gui["helmod_button_selected"] = {
  type = "button_style",
  font = "helmod_font_normal",
  default_font_color={r=1, g=1, b=1},
  align = "center",
  top_padding = 2,
  right_padding = 2,
  bottom_padding = 2,
  left_padding = 2,
  height = 28,
  default_graphical_set = compositionIcon("__core__/graphics/gui.png", corner_size, {0, 40}),
  hovered_font_color={r=1, g=1, b=1},
  hovered_graphical_set = compositionIcon("__core__/graphics/gui.png", corner_size, {0, 40}),
  clicked_font_color={r=1, g=1, b=1},
  clicked_graphical_set = compositionIcon("__core__/graphics/gui.png", corner_size, {0, 40}),
  disabled_font_color={r=0.5, g=0.5, b=0.5},
  disabled_graphical_set = compositionIcon("__core__/graphics/gui.png", corner_size, {0, 16}),
  pie_progress_color = {r=1, g=1, b=1}
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] favicon

local icon_corner_size = 0
default_gui["helmod_icon"] = {
  type = "button_style",
  parent = "helmod_button_default",
  width = 32,
  height = 32,
  scalable = false,
  default_graphical_set = monolithIcon("__helmod__/graphics/icons/helmod_icon.png", 32, 1, {0,0}, {x=0,y=0}, {top=0,right=0,bottom=0,left=0}, true),
  hovered_graphical_set = monolithIcon("__helmod__/graphics/icons/helmod_icon.png", 32, 1, {0,0}, {x=0,y=0}, {top=0,right=0,bottom=0,left=0}, true),
  clicked_graphical_set = monolithIcon("__helmod__/graphics/icons/helmod_icon.png", 32, 1, {0,0}, {x=0,y=0}, {top=0,right=0,bottom=0,left=0}, true),
  disabled_graphical_set = monolithIcon("__helmod__/graphics/icons/helmod_icon.png", 32, 1, {0,0}, {x=0,y=0}, {top=0,right=0,bottom=0,left=0}, true)
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] icon_default

default_gui["helmod_button_icon_default"] = {
  type = "button_style",
  parent = "helmod_button_default",
  default_graphical_set = compositionIcon("__core__/graphics/gui.png", {icon_corner_size, icon_corner_size}, {3 - icon_corner_size, 3 - icon_corner_size}),
  hovered_graphical_set = compositionIcon("__core__/graphics/gui.png", {icon_corner_size, icon_corner_size}, {3 - icon_corner_size, 11 - icon_corner_size}),
  clicked_graphical_set = compositionIcon("__core__/graphics/gui.png", {icon_corner_size, icon_corner_size}, {3 - icon_corner_size, 43 - icon_corner_size}),
  disabled_graphical_set = compositionIcon("__core__/graphics/gui.png", {icon_corner_size, icon_corner_size}, {3 - icon_corner_size, 19 - icon_corner_size}),
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] icon_yyy

local list = {
  {name="arrow_down"},
  {name="arrow_right"},
  {name="arrow_top"},
  {name="arrow_left"},
  {name="download"},
  {name="upload"},
  {name="refresh"},
  {name="clock"},
  {name="close"},
  {name="copy"},
  {name="help"},
  {name="info"},
  {name="maximize"},
  {name="minimize"},
  {name="menu"},
  {name="past"},
  {name="pin"},
  {name="delete"},
  {name="edit"},
  {name="settings"},
  {name="time", font="helmod_font_small2_bold"}
}
for icon_row,icon in pairs(list) do
  menuIcons(icon.name, icon_row, icon.font)
end

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] icon

local icon_sm_size=16
local icon_sm_padding=1

local icon_m_size=24
local icon_m_padding=1

local icon_size=32
local icon_padding=2

local icon_xxl_size=64
local icon_xxl_padding=2

local monolith_size=36
local monolith_scale=1

local icon_offset_y=144

local style_list = {
  {suffix="",offset = 0},
  {suffix="_red",offset = 36},
  {suffix="_yellow",offset = 72},
  {suffix="_green",offset = 108}
}

default_gui["helmod_button_icon"] = {
  type = "button_style",
  parent = "helmod_button_icon_default",
  width = icon_size + 2*icon_padding,
  height = icon_size + 2*icon_padding,
  top_padding = icon_padding,
  right_padding = icon_padding,
  bottom_padding = icon_padding,
  left_padding = icon_padding,
  default_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=0,y=60}, {top=0,right=0,bottom=0,left=0}, true),
  scalable = false
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] select_icon
for _,style in pairs(style_list) do
default_gui["helmod_button_select_icon"..style.suffix] = {
  type = "button_style",
  parent = "helmod_button_icon",
    default_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=111,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    hovered_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=148,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    clicked_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=184,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    disabled_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=111,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true)
}
end

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] icon_xxl

default_gui["helmod_button_icon_xxl"] = {
  type = "button_style",
  parent = "helmod_button_icon_default",
  width = icon_xxl_size + 2*icon_xxl_padding,
  height = icon_xxl_size + 2*icon_xxl_padding,
  top_padding = icon_xxl_padding,
  right_padding = icon_xxl_padding,
  bottom_padding = icon_xxl_padding,
  left_padding = icon_xxl_padding,
  default_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=0,y=60}, {top=0,right=0,bottom=0,left=0}, true),
  scalable = false
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] select_icon_xxl

for _,style in pairs(style_list) do
  default_gui["helmod_button_select_icon_xxl"..style.suffix] = {
    type = "button_style",
    parent = "helmod_button_icon_xxl",
    default_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=111,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    hovered_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=148,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    clicked_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=184,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    disabled_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=111,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true)
  }
end

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] icon_m

default_gui["helmod_button_icon_m"] = {
  type = "button_style",
  parent = "helmod_button_icon_default",
  width = icon_m_size + 2*icon_m_padding,
  height = icon_m_size + 2*icon_m_padding,
  top_padding = icon_m_padding,
  right_padding = icon_m_padding,
  bottom_padding = icon_m_padding,
  left_padding = icon_m_padding,
  default_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=0,y=60}, {top=0,right=0,bottom=0,left=0}, true),
  scalable = false
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] select_icon_m

for _,style in pairs(style_list) do
  default_gui["helmod_button_select_icon_m"..style.suffix] = {
    type = "button_style",
    parent = "helmod_button_icon_m",
    default_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=111,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    hovered_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=148,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    clicked_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=184,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    disabled_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=111,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true)
  }
end

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] icon_sm

default_gui["helmod_button_icon_sm"] = {
  type = "button_style",
  parent = "helmod_button_icon_default",
  width = icon_sm_size + 2*icon_sm_padding,
  height = icon_sm_size + 2*icon_sm_padding,
  top_padding = icon_sm_padding,
  right_padding = icon_sm_padding,
  bottom_padding = icon_sm_padding,
  left_padding = icon_sm_padding,
  default_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=0,y=60}, {top=0,right=0,bottom=0,left=0}, true),
  scalable = false
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] select_icon_sm

for _,style in pairs(style_list) do
default_gui["helmod_button_select_icon_sm"..style.suffix] = {
  type = "button_style",
  parent = "helmod_button_icon_sm",
    default_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=111,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    hovered_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=148,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    clicked_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=184,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true),
    disabled_graphical_set = monolithIcon("__core__/graphics/gui.png", monolith_size, monolith_scale, {0,0}, {x=111,y=icon_offset_y+style.offset}, {top=0,right=0,bottom=0,left=0}, true)
}
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] small_bold

default_gui["helmod_button_small_bold"] = {
  type = "button_style",
  parent = "helmod_button_default",
  font = "helmod_font_normal_bold",

  minimal_width = 24,
  height = 24,

  top_padding = 2,
  right_padding = 2,
  bottom_padding = 2,
  left_padding = 2
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] small-bold-start

default_gui["helmod_button_small_bold_start"] = {
  type = "button_style",
  parent = "helmod_button_default",
  font = "helmod_font_normal_bold",

  width = 24,
  height = 24,

  top_padding = 2,
  right_padding = 0,
  bottom_padding = 2,
  left_padding = 2
}

-------------------------------------------------------------------------------
-- Style of button
--
-- @field [parent=#Button] small-bold-middle

default_gui["helmod_button_small_bold_middle"] = {
  type = "button_style",
  parent = "helmod_button_default",
  font = "helmod_font_normal_bold",

  width = 24,
  height = 24,

  top_padding = 2,
  right_padding = 0,
  bottom_padding = 2,
  left_padding = 0
}

default_gui["helmod_button_small_bold_end"] = {
  type = "button_style",
  parent = "helmod_button_default",
  font = "helmod_font_normal_bold",

  width = 24,
  height = 24,

  top_padding = 2,
  right_padding = 2,
  bottom_padding = 2,
  left_padding = 0
}

-------------------------------------------------------------------------------
-- Style label
--
-- @type Label
--

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] default

default_gui["helmod_label_default"] = {
  type = "label_style",
  parent = "label_style",
  top_padding = 2,
  right_padding = 2,
  bottom_padding = 2,
  left_padding = 2
}

-------------------------------------------------------------------------------
-- Style of text
--
-- @field [parent=#Label] help

default_gui["helmod_label_help"] = {
  type = "label_style",
  parent = "helmod_label_default",
  maximal_width = 50
}

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] max_xx

for w=50, 600, 50 do
  default_gui["helmod_label_max_"..w] = {
    type = "label_style",
    parent = "helmod_label_default",
    maximal_width = w
  }
end

-------------------------------------------------------------------------------
-- Style of title frame
--
-- @field [parent=#Label] title_frame

default_gui["helmod_label_title_frame"] = {
  type = "label_style",
  parent = "helmod_label_default",
  font = "helmod_font_title_frame"
}

-------------------------------------------------------------------------------
-- Style of time
--
-- @field [parent=#Label] time

default_gui["helmod_label_time"] = {
  type = "label_style",
  parent = "label_style",
  top_padding = 4,
  right_padding = 2,
  bottom_padding = 2,
  left_padding = 2
}

-------------------------------------------------------------------------------
-- Style of label
--
-- @field [parent=#Label] sm

default_gui["helmod_label_sm"] = {
  type = "label_style",
  font = "helmod_font_normal",
  align = "right",
  top_padding = 0,
  right_padding = 1,
  bottom_padding = 1,
  left_padding = 0
}

-------------------------------------------------------------------------------
-- Style of label
--
-- @field [parent=#Label] right

default_gui["helmod_label_right"] = {
  type = "label_style",
  font = "default",
  align = "right"
}

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] right_xx

for w=20, 100, 10 do
  default_gui["helmod_label_right_"..w] = {
    type = "label_style",
    parent = "helmod_label_right",
    minimal_width = w
  }
end

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] row_right

  default_gui["helmod_label_row_right"] = {
    type = "label_style",
    parent = "helmod_label_right",
    top_padding = 15
  }

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] row_right_xx

for w=20, 100, 10 do
  default_gui["helmod_label_row_right_"..w] = {
    type = "label_style",
    parent = "helmod_label_row_right",
    minimal_width = w
  }
end

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] row2_right

  default_gui["helmod_label_row2_right"] = {
    type = "label_style",
    parent = "helmod_label_right",
    font = "helmod_font_normal",
    top_padding = 0,
    right_padding = 1,
    bottom_padding = 1,
    left_padding = 0
  }

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] row2_right_xx

for w=20, 100, 10 do
  default_gui["helmod_label_row2_right_"..w] = {
    type = "label_style",
    parent = "helmod_label_row2_right",
    minimal_width = w
  }
end

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] row2_right_sm

  default_gui["helmod_label_row2_right_sm"] = {
    type = "label_style",
    parent = "helmod_label_right",
    font = "helmod_font_small",
    top_padding = 0,
    right_padding = 1,
    bottom_padding = 0,
    left_padding = 0
  }

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Label] row2_right_sm_xx

for w=20, 100, 10 do
  default_gui["helmod_label_row2_right_sm_"..w] = {
    type = "label_style",
    parent = "helmod_label_row2_right_sm",
    minimal_width = w
  }
end

-------------------------------------------------------------------------------
-- Style of label
--
-- @field [parent=#Label] icon

default_gui["helmod_label_icon"] = {
  type = "label_style",
  parent = "helmod_label_right",
  font = "helmod_font_icon",
  align = "right",
  top_padding = 0,
  right_padding = 1,
  bottom_padding = 1,
  left_padding = 0
}

-------------------------------------------------------------------------------
-- Style of label
--
-- @field [parent=#Label] icon_text_sm

default_gui["helmod_label_icon_text_sm"] = {
  type = "label_style",
  parent = "helmod_label_right",
  font = "helmod_font_icon_4",
  minimal_width = 45,
  top_padding = 18,
  right_padding = 1,
  bottom_padding = 1,
  left_padding = 0
}

-------------------------------------------------------------------------------
-- Style of label
--
-- @field [parent=#Label] icon_sm

default_gui["helmod_label_icon_sm"] = {
  type = "label_style",
  parent = "helmod_label_right",
  font = "helmod_font_icon_4",
  minimal_width = 45,
  top_padding = 10,
  right_padding = 1,
  bottom_padding = 1,
  left_padding = 0
}

-------------------------------------------------------------------------------
-- Style table
--
-- @type Table
--

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Table] default

default_gui["helmod_table_default"] = {
  type = "table_style",
  horizontal_spacing = 0,
  vertical_spacing = 0,
  top_padding = 0,
  right_padding = 0,
  bottom_padding = 0,
  left_padding = 0
}

-------------------------------------------------------------------------------
-- Style of factory modules
--
-- @field [parent=#Table] factory_modules

default_gui["helmod_factory_modules"] = {
  type = "table_style",
  parent = "helmod_table_default",
  minimal_width = 36
}

-------------------------------------------------------------------------------
-- Style of beacon modules
--
-- @field [parent=#Table] beacon_modules

default_gui["helmod_beacon_modules"] = {
  type = "table_style",
  parent = "helmod_table_default",
  minimal_width = 18
}

-------------------------------------------------------------------------------
-- Style of recipe modules
--
-- @field [parent=#Table] recipe_modules

default_gui["helmod_table_recipe_modules"] = {
  type = "table_style",
  parent = "table_style",
  minimal_height = 36
}

-------------------------------------------------------------------------------
-- Style of recipe selector
--
-- @field [parent=#Table] recipe_selector

default_gui["helmod_table_recipe_selector"] = {
  type = "table_style",
  horizontal_spacing = 2,
  vertical_spacing = 2,
  top_padding = 1,
  right_padding = 0,
  bottom_padding = 1,
  left_padding = 0
}

-------------------------------------------------------------------------------
-- Style of recipe selector
--
-- @field [parent=#Table] odd

default_gui["helmod_table-odd"] = {
  type = "table_style",
  -- default orange with alfa
  hovered_row_color = {r=0.98, g=0.66, b=0.22, a=0.7},
  cell_padding = 1,
  horizontal_spacing = 3,
  vertical_spacing = 2,
  horizontal_padding = 1,
  vertical_padding = 1,
  odd_row_graphical_set =
  {
    type = "composition",
    filename = "__core__/graphics/gui.png",
    priority = "extra-high-no-scale",
    corner_size = {0, 0},
    position = {78, 18},
    opacity = 0.7
  }
}

-------------------------------------------------------------------------------
-- Name of display
--
-- |--------------------------------------------------|
-- | Flow.main                                        |
-- | |-----------------------|----------------------| |
-- | | Flow.info             | Flow.dialog          | |
-- | | |-------------------| | |------------------| | |
-- | | | Frame.main_menu   | | | Frame.dialog     | | |
-- | | |-------------------| | |                  | | |
-- | | | Frame.data        | | |                  | | |
-- | | |                   | | |                  | | |
-- | | |                   | | |                  | | |
-- | | |                   | | |                  | | |
-- | | |-------------------| | |------------------| | |
-- | |-----------------------|----------------------| |
-- |--------------------------------------------------|
--

local width_info=480
local width_scroll=8
local width_block_info=290
local width_recipe_column=220
local height_block_header = 450
local height_selector_header = 350

local width_1920 = math.ceil(1920*0.85) -- 1632
local height_1200 = math.ceil(1200*0.85) -- 1020
local width_1680 = math.ceil(1680*0.85) -- 1388
local height_1050 = math.ceil(1050*0.85) -- 893


-------------------------------------------------------------------------------
-- Style flow
--
-- @type Flow
--

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Flow] default

default_gui["helmod_flow_default"] = {
  type = "flow_style",
  parent = "flow_style",
  horizontal_spacing = 1,
  vertical_spacing = 1
}

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Flow] cell

default_gui["helmod_flow_cell"] = {
  type = "flow_style",
  parent = "helmod_flow_default",
  horizontal_spacing = 0,
  vertical_spacing = 0
}

-------------------------------------------------------------------------------
-- Style of left menu panel
--
-- @field [parent=#Flow] left_menu
--

default_gui["helmod_flow_left_menu"] = {
  type = "flow_style",
  parent = "helmod_flow_default",
  minimal_width = 46,
  maximal_width = 46,
  maximal_height = height_1050
}

-------------------------------------------------------------------------------
-- Style of data tab panel
--
-- @field [parent=#Flow] data_tab

default_gui["helmod_flow_data_tab"] = {
  type = "flow_style",
  parent = "helmod_flow_default",
  horizontal_spacing = 3,
  minimal_width = width_1680 - width_info - 400
}

-------------------------------------------------------------------------------
-- Style of full resize row panel
--
-- @field [parent=#Flow] full_resize_row

default_gui["helmod_flow_full_resize_row"] = {
  type = "flow_style",
  parent = "helmod_flow_default",
  resize_row_to_width = true,
  resize_to_row_height = true
}

-------------------------------------------------------------------------------
-- Style of resize row width panel
--
-- @field [parent=#Flow] resize_row_width

default_gui["helmod_flow_resize_row_width"] = {
  type = "flow_style",
  parent = "helmod_flow_default",
  resize_row_to_width = true
}

-------------------------------------------------------------------------------
-- Style of info panel
--
-- @field [parent=#Flow] info

default_gui["helmod_flow_info"] = {
  type = "flow_style",
  parent = "helmod_flow_resize_row_width"
}

-------------------------------------------------------------------------------
-- Style of dialog panel
--
-- @field [parent=#Flow] dialog

default_gui["helmod_flow_dialog"] = {
  type = "flow_style",
  parent = "helmod_flow_resize_row_width"
}

-------------------------------------------------------------------------------
-- Style of recipe selector
--
-- @field [parent=#Flow] recipe_selector

default_gui["helmod_flow_recipe_selector"] = {
  type = "flow_style",
  parent = "flow_style",
  horizontal_spacing = 0,
  vertical_spacing = 0
}

-------------------------------------------------------------------------------
-- Style frame
--
-- @type Frame
--

-------------------------------------------------------------------------------
-- Style of default
--
-- @field [parent=#Frame] default

default_gui["helmod_frame_default"] = {
  type = "frame_style",
  parent = "frame_style",

  -- marge interieure
  top_padding  = 2,
  right_padding = 2,
  bottom_padding = 2,
  left_padding = 2,

  -- padding title
  title_top_padding = 0,
  title_left_padding = 0,
  title_bottom_padding = 4,
  title_right_padding = 0,

  font = "helmod_font_title_frame",

  flow_style = {
    horizontal_spacing = 0,
    vertical_spacing = 0
  }
}

-------------------------------------------------------------------------------
-- Style of left menu panel
--
-- @field [parent=#Frame] left_menu
--

default_gui["helmod_frame_left_menu"] = {
  type = "frame_style",
  parent = "helmod_frame_default",
  minimal_width = 46,
  maximal_width = 46
}

-------------------------------------------------------------------------------
-- Style of main panel (only testing)
-- minimal_width = screen width * 85%
-- minimal_height = screen height * 85%
-- @field [parent=#Frame] main

default_gui["helmod_frame_main"] = {
  type = "frame_style",
  parent = "frame_style",
  -- marge interieure
  top_padding  = 0,
  right_padding = 0,
  bottom_padding = 0,
  left_padding = 0,

  -- padding title
  title_top_padding = 0,
  title_left_padding = 0,
  title_bottom_padding = 0,
  title_right_padding = 0
}

-------------------------------------------------------------------------------
-- Style of data menu
-- @field [parent=#Frame] data_menu

default_gui["helmod_frame_data_menu"] = {
  type = "frame_style",
  parent = "frame_style",

  -- marge interieure
  top_padding  = 0,
  right_padding = 0,
  bottom_padding = 0,
  left_padding = 0,

  -- padding title
  title_top_padding = 0,
  title_left_padding = 0,
  title_bottom_padding = 2,
  title_right_padding = 0
}

-------------------------------------------------------------------------------
-- Style of main menu panel
--
-- @field [parent=#Frame] main_menu
--

default_gui["helmod_frame_main_menu"] = {
  type = "frame_style",
  parent = "helmod_frame_default"
}

-------------------------------------------------------------------------------
-- Style of resize width row panel
--
-- @field [parent=#Frame] resize_row_width
--

default_gui["helmod_frame_resize_row_width"] = {
  type = "frame_style",
  parent = "helmod_frame_default",
  resize_row_to_width = true,
  flow_style = {
    resize_row_to_width = true,
    horizontal_spacing = 0,
    vertical_spacing = 0
  }
}

-------------------------------------------------------------------------------
-- Style of resize full row panel
--
-- @field [parent=#Frame] full_resize_row
--

default_gui["helmod_frame_full_resize_row"] = {
  type = "frame_style",
  parent = "helmod_frame_default",
  resize_row_to_width = true,
  resize_to_row_height = true,
  flow_style = {
    resize_row_to_width = true,
    resize_to_row_height = true,
    horizontal_spacing = 0,
    vertical_spacing = 0
  }
}

-------------------------------------------------------------------------------
-- Style of recipe modules panel
--
-- @field [parent=#Frame] recipe_modules
--

default_gui["helmod_frame_recipe_modules"] = {
  type = "frame_style",
  parent = "helmod_frame_default",
  minimal_width = width_recipe_column,
  maximal_width = width_recipe_column
}

-------------------------------------------------------------------------------
-- Style of recipe ingredients panel
--
-- @field [parent=#Frame] recipe_ingredients
--

default_gui["helmod_frame_recipe_ingredients"] = {
  type = "frame_style",
  parent = "helmod_frame_default",
  minimal_width = width_recipe_column,
  maximal_width = width_recipe_column,
  minimal_height = 76,
  maximal_height = 76
}

-------------------------------------------------------------------------------
-- Style of recipe products panel
--
-- @field [parent=#Frame] recipe_products
--

default_gui["helmod_frame_recipe_products"] = {
  type = "frame_style",
  parent = "helmod_frame_default",
  minimal_width = width_recipe_column,
  maximal_width = width_recipe_column,
  minimal_height = 77,
  maximal_height = 77
}

-------------------------------------------------------------------------------
-- Style of recipe info
--
-- @field [parent=#Frame] recipe_info
--

default_gui["helmod_frame_recipe_info"] = {
  type = "frame_style",
  parent = "helmod_frame_default",
  minimal_width = width_recipe_column,
  maximal_width = width_recipe_column
}

-------------------------------------------------------------------------------
-- Style of recipe factory panel
--
-- @field [parent=#Frame] recipe_factory
--

default_gui["helmod_frame_recipe_factory"] = {
  type = "frame_style",
  parent = "helmod_frame_default",
  minimal_width = width_recipe_column,
  maximal_width = width_recipe_column,
  minimal_height = 305,
  maximal_height = 305
}

-------------------------------------------------------------------------------
-- Style scroll
--
-- @type Scroll
--

-------------------------------------------------------------------------------
-- Style of block info
--
-- @field [parent=#Scroll] block_info

default_gui["helmod_scroll_block_info"] = {
  type = "scroll_pane_style",
  parent = "scroll_pane_style",
  minimal_width = width_block_info,
  maximal_width = width_block_info
}

-------------------------------------------------------------------------------
-- Style of block element
--
-- @field [parent=#Scroll] block_element

default_gui["helmod_scroll_block_element"] = {
  type = "scroll_pane_style",
  parent = "scroll_pane_style",
  minimal_height = 36,
  maximal_height = 72
}

-------------------------------------------------------------------------------
-- Style of block pin tab
--
-- @field [parent=#Scroll] block_pin_tab

default_gui["helmod_scroll_block_pin_tab"] = {
  type = "scroll_pane_style",
  parent = "scroll_pane_style",
  minimal_width = 220,
  maximal_width = 450,
  minimal_height = 72,
  maximal_height = 500
}

-------------------------------------------------------------------------------
-- Style of recipe module list
--
-- @field [parent=#Scroll] recipe_module_list

default_gui["helmod_scroll_recipe_module_list"] = {
  type = "scroll_pane_style",
  parent = "scroll_pane_style",
  minimal_width = width_recipe_column - width_scroll,
  maximal_width = width_recipe_column - width_scroll,
  minimal_height = 197,
  maximal_height = 197
}

-------------------------------------------------------------------------------
-- Style of recipe selector
--
-- @field [parent=#Scroll] recipe_selector

default_gui["helmod_scroll_recipe_selector"] = {
  type = "scroll_pane_style",
  parent = "scroll_pane_style",
  minimal_width = 400,
  maximal_width = 400
}

-------------------------------------------------------------------------------
-- Style of recipe factories
--
-- @field [parent=#Scroll] recipe_factories

default_gui["helmod_scroll_recipe_factories"] = {
  type = "scroll_pane_style",
  parent = "scroll_pane_style",
  minimal_width = width_recipe_column - width_scroll,
  maximal_width = width_recipe_column - width_scroll,
  minimal_height = 270,
  maximal_height = 270
}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

default_gui["helmod_button-sorted-none"] = {
  type = "button_style",
  parent = "button_style",
  scalable = false,
  width = 22,
  height = 22,
  top_padding = 1,
  right_padding = 1,
  bottom_padding = 1,
  left_padding = 1,
  default_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 1, {0,0}, {x=0,y=0}, {top=1,right=1,bottom=1,left=1}, false),
  hovered_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 1, {0,0}, {x=72,y=0}, {top=1,right=1,bottom=1,left=1}, false),
  clicked_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 1, {0,0}, {x=0,y=0}, {top=1,right=1,bottom=1,left=1}, false)
}

default_gui["helmod_button-sorted-down"] = {
  type = "button_style",
  parent = "button_style",
  scalable = false,
  width = 22,
  height = 22,
  top_padding = 1,
  right_padding = 1,
  bottom_padding = 1,
  left_padding = 1,
  default_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 22/24, {0,0}, {x=48,y=0}, {top=1,right=1,bottom=1,left=1}, false),
  hovered_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 22/24, {0,0}, {x=24,y=0}, {top=1,right=1,bottom=1,left=1}, false),
  clicked_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 22/24, {0,0}, {x=72,y=0}, {top=1,right=1,bottom=1,left=1}, false)
}

default_gui["helmod_button-sorted-up"] = {
  type = "button_style",
  parent = "button_style",
  scalable = false,
  width = 22,
  height = 22,
  top_padding = 1,
  right_padding = 1,
  bottom_padding = 1,
  left_padding = 1,
  default_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 1, {0,0}, {x=24,y=0}, {top=1,right=1,bottom=1,left=1}, false),
  hovered_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 1, {0,0}, {x=48,y=0}, {top=1,right=1,bottom=1,left=1}, false),
  clicked_graphical_set = monolithIcon("__helmod__/graphics/switch-quickbar.png", 24, 1, {0,0}, {x=72,y=0}, {top=1,right=1,bottom=1,left=1}, false)
}
