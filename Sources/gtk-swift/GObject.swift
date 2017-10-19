
import SwiftGlibc.POSIX.termios
import CGtk

class GObject {

      var obj: OpaquePointer?
      init() {
          obj = nil
      }
      deinit {
          if obj != nil {
             g_object_unref(unsafeBitCast(obj!, to:gpointer.self))
             obj = nil
          }
      }
}


class GApplication: GObject {

    init (name id: String, flags: GApplicationFlags) {
         super.init()
         obj = unsafeBitCast(gtk_application_new(id, flags), to:OpaquePointer?.self)
    }

}

class GWindow: GObject {
    override init () {
        super.init()
    }
    func setTitle(_ title:String) {
        gtk_window_set_title(unsafeBitCast(obj,to:UnsafeMutablePointer<GtkWindow>!.self), title)
    }
}

class GApplicationWindow: GObject {
    init (_ app: GApplication) {
        super.init()
        obj = unsafeBitCast(gtk_application_window_new(unsafeBitCast(app.obj,to:UnsafeMutablePointer<GtkApplication>!.self)),to:OpaquePointer?.self)
    }
}

struct GSignal {
    func connectData(_ instance: gpointer!, _ detailed_signal: UnsafePointer<gchar>!, _ c_handler: CGtk.GCallback!, _ data: gpointer!, _ destroy_data: CGtk.GClosureNotify!, _ connect_flags: GConnectFlags) {
        g_signal_connect_data(instance, detailed_signal, c_handler, data, destroy_data, connect_flags)
    }
    func connect(_ instance: gpointer!, _ detailed_signal: UnsafePointer<gchar>!, _ c_handler: CGtk.GCallback!, _ data: gpointer!) {
        g_signal_connect_data(instance, detailed_signal, c_handler, data, nil, GConnectFlags(rawValue: 0));
    }
}
