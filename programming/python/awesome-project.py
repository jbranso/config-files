#!/usr/bin/python
from gi.repository import Gtk

class MyWindow (Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Hello World!")
        self.button = Gtk.Button(label="Click Here!")
        self.button.connect("clicked", self.on_button_clicked)
        self.add(self.button)

    def on_button_clicked (self, widget):
        print("Hello World")

class OtherWindow (Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Hello Baby!")
        self.box = Gtk.Box(spacing=6)
        self.add(self.box)

        self.button1 = Gtk.Button(label="hello there!")
        self.button1.connect("clicked", self.on_button1_clicked)
        self.box.pack_start(self.button1, True, True, 0)

        self.button2 = Gtk.Button(label="Goodbye")
        self.button2.connect("clicked", self.on_button2_clicked)
        self.box.pack_start(self.button2, True, True, 0)

    def on_button1_clicked(self, widget):
        print("Hello")

    def on_button2_clicked(self, widget):
        print("Goodbye")


win = OtherWindow()
win.connect("delete-event", Gtk.main_quit)
win.show_all()
Gtk.main()
        
win = MyWindow()
win.connect("delete-event", Gtk.main_quit)
win.show_all()
Gtk.main()

