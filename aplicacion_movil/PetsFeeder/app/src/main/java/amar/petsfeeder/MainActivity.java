package amar.petsfeeder;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

import amar.petsfeeder.config.Configuracion;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.d("AMAR", "Creando actividad principal");
    }

    public void alimentar(View view) {
        Log.d("AMAR", "Iniciando alimentación");
        new AsyncTask<Void, Void, Void>() {
            @Override
            protected Void doInBackground(Void... params) {
                try {
                    Log.d("AMAR", "En tarea asíncrona");
                    URL url = new URL("http://" + Configuracion.get().getIp().getHostAddress() + ":3000/alimentar");
                    HttpURLConnection conn = (HttpURLConnection)url.openConnection();
                    conn.setRequestMethod("POST");
                    BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    String inputLine;

                    Log.d("AMAR", "Realizando conexión a " + url);
                    while ((inputLine = in.readLine()) != null)
                        Log.d("AMAR", inputLine);
                    in.close();
                } catch (java.io.IOException e) {
                    e.printStackTrace();
                }
                return null;
            }
        }.execute();
    }

    public void openAbout(View view){
        Intent i = new Intent(this, AboutActivity.class);
        startActivity(i);
    }


    public void openIPConfig(View view){
        Intent i = new Intent(this, IPConfigActivity.class);
        startActivity(i);
    }

    public void openHistory(View view){
        Intent i = new Intent(this, HistoryActivity.class);
        startActivity(i);
    }

    public void openTimeSettings(View view){
        Intent i = new Intent(this, TimeSettings.class);
        startActivity(i);
    }
}
