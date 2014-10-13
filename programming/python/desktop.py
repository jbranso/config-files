#!/usr/bin/python
from gi.repository import Gtk
class GridWindow (Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Grid Example")
        path = "/home/joshua/.config/awesome/icons/Faenza/apps/96/"
        #create the gtk images and set the images they display
        image1 = Gtk.Image()
        image2 = Gtk.Image()
        image3 = Gtk.Image()
        image4 = Gtk.Image()
        image5 = Gtk.Image()
        image6 = Gtk.Image()
        image7 = Gtk.Image()
        image8 = Gtk.Image()
        image1.set_from_file(path + "libreoffice-writer.png")
        image2.set_from_file(path + "libreoffice-writer.png")
        image3.set_from_file(path + "libreoffice-writer.png")
        image4.set_from_file(path + "libreoffice-writer.png")
        image5.set_from_file(path + "libreoffice-writer.png")
        image6.set_from_file(path + "libreoffice-writer.png")
        image7.set_from_file(path + "libreoffice-writer.png")
        image8.set_from_file(path + "libreoffice-writer.png")

        #add the images to a button widget
        button1 = Gtk.Button(use_underline=False)
        button2 = Gtk.Button(use_underline=False)
        button3 = Gtk.Button(use_underline=False)
        button4 = Gtk.Button(use_underline=False)
        button5 = Gtk.Button(use_underline=False)
        button6 = Gtk.Button(use_underline=False)
        button7 = Gtk.Button(use_underline=False)
        button8 = Gtk.Button(use_underline=False)
        button1.add(image1)
        button2.add(image2)
        button3.add(image3)
        button4.add(image4)
        button5.add(image5)
        button6.add(image6)
        button7.add(image7)
        button8.add(image8)

        #connect the various signals
        # button1.connect("clicked", self.clicked1)

        #create the labels
        label1 = Gtk.Label ("label1")
        label2 = Gtk.Label ("label2")
        label3 = Gtk.Label ("label3")
        label4 = Gtk.Label ("label4")

        #add the buttons to the grid
        grid.add(button1)
        grid.attach(button2, 1, 0, 1, 1)
        grid.attach(button5, 2, 0, 1, 1)
        grid.attach(button6, 3, 0, 1, 1)
        grid.attach(button7, 4, 0, 1, 1)
        grid.attach(button8, 5, 0, 1, 1)
        grid.attach(label1, 0, 1, 1, 1)
        grid.attach(label2, 1, 1, 1, 1)
        grid.attach(button3, 0, 2, 1, 1)
        grid.attach(button4, 1, 2, 1, 1)
        grid.attach(label3, 0, 3, 1, 1)
        grid.attach(label4, 1, 3, 1, 1)

        #define what happens when you click a button
        # def clicked1 (self, button):
        #     print ("hello")



win = GridWindow()
win.connect("delete-event", Gtk.main_quit)
win.show_all()
Gtk.main()
