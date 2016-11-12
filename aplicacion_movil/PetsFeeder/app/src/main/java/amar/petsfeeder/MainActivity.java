package amar.petsfeeder;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.InterruptedIOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Timer;
import java.util.TimerTask;

import amar.petsfeeder.config.Configuracion;


public class MainActivity extends AppCompatActivity {

    private boolean alimentando = false;


    class BuscarEstado extends AsyncTask<Void, Void, String>{

        @Override
        protected String doInBackground(Void... params) {
            try {

                Log.d("AMAR", "En tarea asíncrona");
                URL url = new URL("http://" + Configuracion.get().getIp().getHostAddress() + ":3000/estado");
                HttpURLConnection conn = (HttpURLConnection)url.openConnection();
                conn.setRequestMethod("GET");
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;

                Log.d("AMAR", "Realizando conexión a " + url);
                String resultado = "";
                while ((inputLine = in.readLine()) != null)
                    resultado+=inputLine;
                in.close();
                return resultado;
            } catch (java.io.IOException e) {
                return "ERROR";
            }
        }

        @Override
        protected void onPostExecute(String s) {
            if (s == "ERROR") {
                ((TextView) findViewById(R.id.textViewMain)).setText("Error de conexión :(");
                return;
            }
            boolean recipienteLleno, platoLleno, detectaMovimiento;
            String[] estado = s.split("_");
            recipienteLleno = Boolean.parseBoolean(estado[0]);
            platoLleno = Boolean.parseBoolean(estado[1]);
            detectaMovimiento = Boolean.parseBoolean(estado[2]);
            String resultado;
            if (platoLleno && detectaMovimiento){
                resultado = "La mascota está comiendo.";
            }else if(platoLleno){
                resultado = "La mascota aún no ha comido.";
            }else if(detectaMovimiento){
                resultado = "La mascota está debajo del alimentador, pero no hay alimento :(";
            }else{
                resultado = "¡Bienvenido Humano!";
            }
            ((TextView) findViewById(R.id.textViewMain)).setText(resultado);
        }
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.d("AMAR", "Creando actividad principal");


        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
               new BuscarEstado().execute();
            }
        };
        timer.schedule(task, 0, 5000);


        SensorManager sensorManager;
        Sensor sensor;

        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);

        sensor = sensorManager.getDefaultSensor(Sensor.TYPE_LINEAR_ACCELERATION);
        sensorManager.registerListener(new SensorEventListener() {
            @Override
            public void onSensorChanged(SensorEvent event) {
                double modulo = Math.sqrt(event.values[0] * event.values[0] +
                                          event.values[1] * event.values[1] +
                                          event.values[2] * event.values[2]);
                if (modulo > 15) {
                    Log.d("AMAR", "Dale látigo!");
                    Toast.makeText(MainActivity.this, "Alimentando", Toast.LENGTH_SHORT).show();
                    alimentar(null);
                }
            }

            @Override
            public void onAccuracyChanged(Sensor sensor, int accuracy) {

            }
        }, sensor, SensorManager.SENSOR_DELAY_NORMAL);

        Sensor lightSensor = sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT);
        sensorManager.registerListener(new SensorEventListener() {
            @Override
            public void onSensorChanged(SensorEvent event) {
                float lux = event.values[0];
                int color = 0;
                color += lux * 100 / 60 + 155;
                if (lux > 60)
                    color = 255;
                getWindow().getDecorView().setBackgroundColor(Color.rgb(color, color, color));
            }

            @Override
            public void onAccuracyChanged(Sensor sensor, int accuracy) {

            }
        }, lightSensor, SensorManager.SENSOR_DELAY_UI);

    }

    @Override
    protected void onStop() {
        super.onStop();
    }

    public void alimentar(View view) {
        if (alimentando) return;
        alimentando = true;
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
                } finally {
                    alimentando = false;
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

    public void openTimeSchedule(View view){
        Intent i = new Intent(this, TimeSchedule.class);
        startActivity(i);
    }
}
