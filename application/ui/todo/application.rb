module ToDo
  class Application < Gtk::Application
    def initialize
      super 'com.andy.gtk-todo', Gio::ApplicationFlags::FLAGS_NONE

      signal_connect :activate do |application|
        window = Todo::ApplicationWindow.new(application)
        window.present
      end
    end
  end
end

