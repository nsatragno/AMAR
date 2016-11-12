package amar.petsfeeder;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class TimePicker extends AppCompatActivity {

    private android.widget.TimePicker picker;
    private String hora;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_time_picker);
        picker = (android.widget.TimePicker) findViewById(R.id.timePicker);

        Button boton = (Button) findViewById(R.id.buttonTimePicker);
        boton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent();
                intent.putExtra("hora", hora);
                setResult(0, intent);
                finish();
            }
        });

        picker.setOnTimeChangedListener(new android.widget.TimePicker.OnTimeChangedListener() {
            @Override
            public void onTimeChanged(android.widget.TimePicker view, int hourOfDay, int minute) {
                Log.d("AMAR", "onTimeChanged");
                hora = String.format("%02d:%02d", hourOfDay, minute);
            }
        });
    }
}
