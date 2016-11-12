package amar.petsfeeder;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import java.util.ArrayList;

public class TimeSettings extends AppCompatActivity {

    private TimePicker timePicker;
    private Button buttonAdd;
    private Button buttonRefreshTimeSettings;
    private Horario h;
    private String horario;
  //  private TextView textViewTime1;
    //private TextView textViewTime2;
    ArrayList<String> listHorario = new ArrayList<String>(2);
    int b = 0;

    String cadenaHorarios = new String();
    private ListView timeList;
    private String[] strTimeList;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_time_settings);
        agregarHorario();
        guardarHorarios();

        timeList = (ListView) findViewById(R.id.listViewTimeSettings);
        ArrayAdapter<String> timeSettingsListAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, listHorario);
        timeList.setAdapter(timeSettingsListAdapter);
         TextView textViewTime1 = (TextView) findViewById(R.id.textViewTime1);
         TextView textViewTime2 = (TextView) findViewById(R.id.textViewTime2);
    }


    public void agregarHorario() {
        timePicker = (TimePicker) findViewById(R.id.timePickerTimeSettings);
        buttonAdd = (Button) findViewById(R.id.buttonAddTimeSettings);

        buttonAdd.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        b++; //Incremento b con cada click, para deshabilitar el botón cuando llega al máximo de peticiones deseado (en este caso, 2).
                        h = new Horario();
                        h.setHora(timePicker.getCurrentHour());
                        h.setMinutos(timePicker.getCurrentMinute());
                        horario = h.mostrarHorario();
                        listHorario.add(horario);
                        Toast.makeText(getBaseContext(), listHorario.get(listHorario.size() - 1), Toast.LENGTH_SHORT).show();

                        if (b == 2) {
                            //Si ya se han agregado 2 horarios, deshabilito el botón "Agregar".
                            buttonAdd.setEnabled(false);
                            TextView textViewTime1 = (TextView) findViewById(R.id.textViewTime1);
                            TextView textViewTime2 = (TextView) findViewById(R.id.textViewTime2);

                            int j = 0;
                            for (String ho : listHorario) {
                                if (j == 0) {
                                    textViewTime1.setText(ho);

                                } else {
                                    textViewTime2.setText(ho);
                                    // textViewTime2.setText(String.valueOf(ho.mostrarHorario()));
                                }
                                j++;
                            }
                        }
                    }
                });
    }


    //Se almacena la cadena de horarios en la forma: "HH:MM,HH:MM,HH:MM..."
    public String guardarHorarios() {
        for (int i = 0; i < listHorario.size(); i++) {
            if (i == 0) {
                cadenaHorarios = (listHorario.get(i));
            } else {
                cadenaHorarios = "," + (listHorario.get(i));
            }
        }
        return cadenaHorarios;
    }


}
