package amar.petsfeeder;

import android.content.Intent;
import android.graphics.Color;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.UnknownHostException;

import amar.petsfeeder.config.Configuracion;

public class IPConfigActivity extends AppCompatActivity {

    private class ValidadorIP extends AsyncTask<String, Void, InetAddress> {


        @Override
        protected InetAddress doInBackground(String... params) {
            try {
                return Inet4Address.getByName(params[0]);
            } catch (UnknownHostException e) {
                return null;
            }
        }

        @Override
        protected void onPostExecute(InetAddress inetAddress) {
            if (inetAddress == null) {
                TextView errorTextView = (TextView) findViewById(R.id.textViewErrorIP);
                errorTextView.setText("El host no es válido");
                EditText input = (EditText) findViewById(R.id.editTextIPAddress);
                input.setHighlightColor(Color.RED);
                return;
            }
            Configuracion.get().setIp(inetAddress);
            Intent intent = new Intent(IPConfigActivity.this, MainActivity.class);
            startActivity(intent);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ip_config);

    }

    public void onAceptar(View boton) {
        EditText input = (EditText) findViewById(R.id.editTextIPAddress);
        String ip = input.getText().toString();
        new ValidadorIP().execute(ip);
    }
}
