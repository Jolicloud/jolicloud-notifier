#!/usr/bin/perl

use Gtk2;
use Gtk2::GladeXML;
use Net::DBus;


&reboot_dialog();

sub reboot_dialog {
    Gtk2->init();
    my $builder = Gtk2::Builder->new();
    $builder->add_from_file(
            "/usr/share/jolicloud-notifier/ui/reboot-dialog.glade" );
    $dialog = $builder->get_object( "dialog1" );
    $builder->connect_signals( undef );

    $dialog->show();

    Gtk2->main();
}

sub gtk_main_quit {
    Gtk2->main_quit();
}

sub on_buttonOK_clicked {
    my $bus = Net::DBus->system();
    my $service = $bus->get_service( "org.freedesktop.Hal" );
    my $object = $service->get_object( "/org/freedesktop/Hal/devices/computer",
            "org.freedesktop.Hal.Device.SystemPowerManagement" );
    $object->Reboot();
}

sub on_buttonCancel_clicked {
    Gtk2->main_quit();
}
