#!/usr/bin/lua
lgi = require 'lgi'
gtk = lgi.require('Gtk')
gtk.init()
Hello=gtk.MessageDialog { message_type = gtk.MessageType.INFO,
			  buttons = gtk.ButtonsType.OK,
			  text = "Hello World",
			  secondary_text = "This is an example."
}

Hello:run()
