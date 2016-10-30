package amar.petsfeeder.config;

import android.widget.EditText;

import java.net.Inet4Address;
import java.net.InetAddress;

/**
 * Created by nicolas on 30/10/16.
 */

public class Configuracion {
    private static Configuracion instancia = new Configuracion();
    private InetAddress ip;

    private Configuracion() { }

    public static Configuracion get() {
        return instancia;
    }

    public void setIp(InetAddress ip) {
        this.ip = ip;
    }

    public InetAddress getIp() {
        return ip;
    }
}
