#!/usr/bin/python

from gi.repository import Gtk

class GridWindow (Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Grid Example")

        grid = Gtk.Grid()
        self.add (grid)

        button1 = Gtk.Button(label="Button 1")
        button2 = Gtk.Button(label="Button 2")
        button3 = Gtk.Button(label="Button 3")
        button4 = Gtk.Button(label="Button 4")

        grid.add(button1)
        grid.attach(button2, 1, 0, 1, 1)
        grid.attach(button3, 0, 1, 1, 1)
        grid.attach(button4, 1, 1, 1, 1)


win = GridWindow()
win.connect("delete-event", Gtk.main_quit)
win.show_all()
Gtk.main()
