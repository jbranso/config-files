#!/usr/bin/python
from gi.repository import Gtk

def transparent_expose(widget, event):
	cr = widget.window.cairo_create()
	cr.set_operator(cairo.OPERATOR_CLEAR)
	region = gtk.gdk.region_rectangle(event.area)
	cr.region(region)
	cr.fill()
	return False

class DesktopWindow(gtk.Window):

	# Based upon the composited window example from:
	# http://www.pygtk.org/docs/pygtk/class-gdkwindow.html

	def __init__(self, *args):

		gtk.Window.__init__(self, *args)

		self.set_skip_taskbar_hint(True)
		self.set_skip_pager_hint(True)
		self.set_keep_below(True)
		self.set_decorated(False)
		self.stick()

		screen = self.get_screen()
		rgba = screen.get_rgba_colormap()
		self.set_colormap(rgba)
		self.set_app_paintable(True)
		self.connect("expose-event", transparent_expose)

