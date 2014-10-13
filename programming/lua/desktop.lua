#!/usr/bin/lua
lgi = require 'lgi'
gtk = lgi.Gtk
glib = lgi.GLib
gdk = lgi.Gdk
gobject = lgi.GObject
pixbuf = lgi.GdkPixbuf
gtk.init()

local window = gtk.Window {
   title = 'window', default_width = 400, default_height = 300,
   on_destroy = gtk.main_quit
}

if tonumber(gtk._version) >= 3 then
   window.has_resize_grip = true
end
-- -- create a gtk icon view and add icons to it
-- local icon_view = gtk.IconView
-- -- icon_view:set_column_spacing (10)
-- -- icon_view:set_row_spacing (10)
icon_view = gtk.IconView
{
   column_spacing = 10,
   row_spacing = 10
}

-- create store
store = gtk.ListStore (gdk.Pixbuf, gobject.TYPE_STRING)
icon_view:set_model (store) --icon_view:set_model ( model = node )

path = "/home/joshua/.config/awesome/icons/Faenza/apps/96/"
pix = pixbuf.Pixbuf.new_from_file ( path .. "libreoffice-writer.png" )

store:append(pix, "writer")

-- create a grid and add stuff to it.
local grid = gtk.Grid ()

grid:attach (icon_view, 0, 0, 1, 1)

window:add (grid)

-- show the window and start the loop
window:show_all()
gtk.main()


-- function MainWin.new()
--    local self = {}
--    setmetatable (self, MainWin)

--    self.w = gtk.window_new (gtk.Window_TOPLEVEL)
--    self.w:connect ('destroy', gtk.main_quit)
--    self.w:set_default_size (200, 250)
--    self.w:set_title ("Icon View Demo")

--    local sw = gtk.scrolled_window_new (nil, nil)
--    sw:set_policy (gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
--    self.w:add(sw)

--    self.icon_view = gtk.icon_view_new ()
--    sw.add(self.icon_view)

--    -- create store
--    self.store = gtk.list_store_new (3, glib.TYPE_INT, glib.TYPE_STRING,
-- 				    gdk.pixbuf_get_type())
--    self.icon_view:set_model (self.store)
--    self.icon_view:set_text_column (1)
--    self.icon_view:set_pixbuf_column (2)

--    -- insert some items
--    local iter = gtk.new "GtkTreeIter"
--    local pix

--    local names = { 'quit', 'open', 'redo', 'refresh', 'stop', 'save', 'save-as', 'select-color',
-- 		   'yes', 'no', 'zoom-fit' }

--    for i, name in ipairs(names) do
--       self.store:append(iter)
--       pix = self.icon_view:render_icon('gtk-' .. name, gtk.ICON_SIZE_DIALOG, "")
--       self.store:set(iter, 0, i, 1, name, 2, pix, -1)
--    end

--    self.w:show_all()
--    return self
-- end
