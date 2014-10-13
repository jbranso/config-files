#!/usr/bin/lua
lgi = require 'lgi'
gtk = lgi.Gtk
glib = lgi.GLib
gdk = lgi.Gdk
gobject = lgi.GObject
pixbuf = lgi.GdkPixbuf

w = gtk.Window {
   title = 'window', default_width = 400, default_height = 300,
   on_destroy = gtk.main_quit
}

w:connect ('destroy', gtk.Main_quit)

w:connect('destroy', gtk.main_quit)
w:set_default_size(200, 250)
w:set_title("Icon View Demo")
local sw = gtk.scrolled_window_new(nil, nil)
sw:set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
w:add(sw)
icon_view = gtk.icon_view_new()
sw:add(icon_view)
-- create store
store = gtk.list_store_new(3, glib.TYPE_INT, glib.TYPE_STRING, gdk.pixbuf_get_type())
icon_view:set_model(self.store)
icon_view:set_text_column(1)
icon_view:set_pixbuf_column(2)
-- insert some items. see .../gtk/gtkstock.h
local iter = gtk.new "GtkTreeIter"
local pix
local names = { 'quit', 'open', 'redo', 'refresh', 'stop',
		'save', 'save-as', 'select-color', 'yes', 'no', 'zoom-fit' }
for i, name in ipairs(names) do
      store:append(iter)
   pix = icon_view:render_icon('gtk-' .. name, gtk.ICON_SIZE_DIALOG, "")
   store:set(iter, 0, i, 1, name, 2, pix, -1)
end
w:show_all()
