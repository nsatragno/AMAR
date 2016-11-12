package amar.petsfeeder;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.List;

import amar.petsfeeder.config.Configuracion;

public class TimeSchedule extends AppCompatActivity {

    public static final int REQUEST_CODE = 1;

    private static final int [] botones = {
            R.id.buttonTimeSchedule1,
            R.id.buttonTimeSchedule2,
            R.id.buttonTimeSchedule3
    };

    private static final int [] textViews = {
            R.id.textViewTimeSchedule1,
            R.id.textViewTimeSchedule2,
            R.id.textViewTimeSchedule3
    };

    private static final int [] toggles = {
            R.id.toggleButtonTimeSchedule1,
            R.id.toggleButtonTimeSchedule2,
            R.id.toggleButtonTimeSchedule3
    };

    class BotonListener implements View.OnClickListener {

        private final int id;

        BotonListener(int id) {
            this.id = id;
        }

        @Override
        public void onClick(View v) {
            Intent intent = new Intent(TimeSchedule.this, TimePicker.class);
            startActivityForResult(intent, id);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_time_schedule);
        ((Button) findViewById(R.id.buttonTimeScheduleSave)).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onGuardar(v);
            }
        });

        for (int i = 0; i < botones.length; ++i) {
            Button boton = (Button) findViewById(botones[i]);
            boton.setOnClickListener(new BotonListener(i));
        }

        new AsyncTask<Void, Void, String[]>() {
            @Override
            protected String[] doInBackground(Void... params) {
                try {
                    Log.d("AMAR", "En tarea asíncrona");
                    URL url = new URL("http://" + Configuracion.get().getIp().getHostAddress() + ":3000/planificacion");
                    HttpURLConnection conn = (HttpURLConnection)url.openConnection();
                    conn.setRequestMethod("GET");
                    BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    String inputLine;

                    Log.d("AMAR", "Realizando conexión a " + url);
                    String resultado = "";
                    while ((inputLine = in.readLine()) != null)
                        resultado += inputLine;

                    Log.d("AMAR", "Resultado: " + resultado);
                    in.close();
                    return resultado.split(",");
                } catch (java.io.IOException e) {
                    e.printStackTrace();
                }
                return null;
            }

            @Override
            protected void onPostExecute(String[] horarios) {
                if (horarios == null) {
                    return;
                }
                for (int i = 0; i < horarios.length; ++i) {
                    String horario = horarios[i].trim();
                    if(horario.isEmpty()){
                        continue;
                    }
                    ((TextView)findViewById(textViews[i])).setText(horario);
                    ((ToggleButton) findViewById(toggles[i])).setChecked(true);
                }
            }
        }.execute();
    }

    public void onGuardar(View view) {
        String strHorarios = "";
        for (int i = 0; i < textViews.length; ++i) {
            if(!((ToggleButton)findViewById(toggles[i])).isChecked()){
                continue;
            }
           CharSequence charSeqHorarios = ((TextView) findViewById(textViews[i])).getText();
            if(charSeqHorarios.equals("HH:MM")) {
                continue;
            }
           if(i == 0){
               strHorarios = charSeqHorarios.toString();
           }else{
               strHorarios =  ", " + charSeqHorarios.toString();
           }
        }

       final String _strHorarios = strHorarios;


        new AsyncTask<Void, Void, Void>() {
            @Override
            protected Void doInBackground(Void... parametros) {
                try {
                    Log.d("AMAR", "En tarea asíncrona");
                    URL url = new URL("http://" + Configuracion.get().getIp().getHostAddress() + ":3000/planificacion");
                    HttpURLConnection conn = (HttpURLConnection)url.openConnection();
                    conn.setRequestMethod("POST");

                    ArrayList<AbstractMap.SimpleEntry> params = new ArrayList<AbstractMap.SimpleEntry>();
                    params.add(new AbstractMap.SimpleEntry("planificacion", _strHorarios));

                    OutputStream os = conn.getOutputStream();
                    BufferedWriter writer = new BufferedWriter(
                            new OutputStreamWriter(os, "UTF-8"));
                    writer.write(getQuery(params));
                    writer.flush();
                    writer.close();

                    BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    String inputLine;

                    Log.d("AMAR", "Realizando conexión a " + url);
                    String resultado = "";
                    while ((inputLine = in.readLine()) != null)
                        resultado += inputLine;

                    Log.d("AMAR", "Resultado: " + resultado);
                    in.close();

                } catch (IOException e) {
                    e.printStackTrace();
                }
                return null;
            }

            @Override
            protected void onPostExecute(Void aVoid) {
                super.onPostExecute(aVoid);
                Toast.makeText(TimeSchedule.this, "Horarios guardados.", Toast.LENGTH_SHORT).show();
            }
        }.execute();
        finish();
    }


    private String getQuery(List<AbstractMap.SimpleEntry> params) throws UnsupportedEncodingException
    {
        StringBuilder result = new StringBuilder();
        boolean first = true;

        for (AbstractMap.SimpleEntry pair : params)
        {
            if (first)
                first = false;
            else
                result.append("&");

            result.append(URLEncoder.encode(pair.getKey().toString(), "UTF-8"));
            result.append("=");
            result.append(URLEncoder.encode(pair.getValue().toString(), "UTF-8"));
        }

        return result.toString();
    }



    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (data == null || data.getStringExtra("hora") == null)
            return;
        TextView textView = (TextView) findViewById(textViews[requestCode]);
        textView.setText(data.getStringExtra("hora"));
        ((ToggleButton) findViewById(toggles[requestCode])).setChecked(true);
    }
}
