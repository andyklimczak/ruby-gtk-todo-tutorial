module ToDo
  class Application < Gtk::Application
    def initialize
      super 'com.andy.gtk-todo', Gio::ApplicationFlags::FLAGS_NONE

      signal_connect :activate do |application|
        window = Gtk::ApplicationWindow.new(application)
        window.set_title 'Hello gtk+ruby and'
        window.present
      end
    end
  end
end
